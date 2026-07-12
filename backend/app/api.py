from datetime import timedelta
from flask import Blueprint, abort, redirect, request, jsonify
from sqlalchemy import func
from models import *
from services.shortener import create_hash
from schemas import schemas
from user_agents import parse
import requests
import ipaddress

api_bp=Blueprint('api', __name__)
@api_bp.route("/<string:short_url>", methods=['GET'])
def redirect_to_url(short_url):
    redir=Urls.query.filter_by(short_url=short_url).first()
    if not redir:
        abort(404)
    ip_ad = request.headers.get('CF-Connecting-IP') or request.headers.get('X-Forwarded-For') or request.remote_addr
    if ip_ad and ',' in ip_ad:
        ip_ad = ip_ad.split(',')[0].strip()
    user_agent = request.user_agent.string
    clean_browser=parse(user_agent).browser.family
    country = None
    if ip_ad:
        ip_obj=ipaddress.ip_address(ip_ad)
        if ip_obj.is_private:
            country = "Localhost (Test)"
        else:
            try:
                response = requests.get(f"http://ip-api.com/json/{ip_ad}", timeout=2)
                if response.status_code == 200:
                    data = response.json()
                    if data.get("status") == "success":
                        country = data["country"]
            except Exception:
                pass
    try:
        validated_data= schemas.Analytics(short_url=redir.short_url, click_time=datetime.now(timezone.utc), country=country, browser=clean_browser)
        new_analytic=Analytics(short_url=validated_data.short_url, click_time=validated_data.click_time, country=validated_data.country, browser=validated_data.browser)
        db.session.add(new_analytic)
        try:
            db.session.commit()
        except Exception:
            db.session.rollback()
    except Exception as e:
        pass

    return redirect(redir.full_url)

@api_bp.route("/api/v1/shorten", methods=['POST'])
def shorten():
    data = request.get_json()

    if not data or "full_url" not in data:
        return jsonify({"error": "No full_url provided"}), 400
    try:
        validated_data= schemas.Url(full_url=data["full_url"], short_url="")
    except Exception as e:
        return jsonify({"error": "error while validating data", "details": str(e)}), 400

    full_url = validated_data.full_url
    url=Urls.query.filter_by(full_url=full_url).first()

    if not url:
        short = create_hash(db.session.query(Urls).count())
        new_url = Urls(short_url=short, full_url=full_url)
        db.session.add(new_url)
        try:
            db.session.commit()
            return jsonify({"short_url": short}), 201
        except Exception as e:
            db.session.rollback()
            return jsonify({"error": "error while saving to database", "details": str(e)}), 500
    else:
        return jsonify({"short_url": url.short_url}), 200

@api_bp.route("/api/v1/analytics/<string:short_url>", methods=['GET'])
def analytics(short_url):
    if not short_url:
        abort(404)

    total_clicks=db.session.query(func.count(Analytics.aID)).filter_by(short_url=short_url).scalar()

    if not total_clicks:
        return jsonify({"error": "Invalid link, or no clicks yet"}), 400

    countries_query=(db.session.query(
        Analytics.country,
        func.count(Analytics.aID)
    ).filter_by(short_url=short_url).group_by(Analytics.country).all())

    countries={country if country is not None else "Unknown":  count for country, count in countries_query}

    browsers_query = db.session.query(
        Analytics.browser,
        func.count(Analytics.aID)
    ).filter_by(short_url=short_url).group_by(Analytics.browser).all()

    browsers = {browser if browser is not None else "Unknown": count for browser, count in browsers_query}

    week_ago=datetime.now()-timedelta(days=7)

    clicks_query=db.session.query(
        func.date(Analytics.click_time),
        func.count(Analytics.aID)
    ).filter(
        Analytics.short_url==short_url,
        Analytics.click_time>=week_ago
    ).group_by(func.date(Analytics.click_time)).all()

    click_times={str(click): count for click, count in clicks_query}


    return jsonify({"short_url": short_url,
                    "total_clicks": total_clicks,
                    "countries": countries,
                    "browsers": browsers,
                    "click_times": click_times}), 200

