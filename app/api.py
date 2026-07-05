from flask import Blueprint, abort, redirect, request, jsonify
import requests
from models import *
from services.shortener import create_hash
from schemas import schemas

api_bp=Blueprint('api', __name__)
@api_bp.route("/<string:short_url>", methods=['GET'])
def redirect_to_url(short_url):
    redir=Urls.query.filter_by(short_url=short_url).first()
    if not redir:
        abort(404)
    ip_ad=request.remote_addr
    user_agent = request.user_agent.string
    country = None
    if ip_ad and ip_ad!="127.0.0.1":
        try:
            response = requests.get(f"http://ip-api.com/json/{ip_ad}", timeout=2)
            if response.status_code == 200:
                data = response.json()
                if data.get("status") == "success":
                    country = data["country"]
        except Exception:
            pass
    elif ip_ad=="127.0.0.1":
        country = "Localhost (Test)"
    try:
        validated_data=schemas.Analytics(full_url=redir.full_url, click_time=datetime.now(timezone.utc), country=country, browser=user_agent)
        new_analytic=Analytics(full_url=validated_data.full_url, click_time=validated_data.click_time, country=validated_data.country, browser=validated_data.browser)
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
        validated_data=schemas.Url(full_url=data["full_url"], short_url="")
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
