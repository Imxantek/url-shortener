from sqlite3 import IntegrityError

from flask import Blueprint, abort, redirect, request, jsonify
from models import *
from services.shortener import create_hash

api_bp=Blueprint('api', __name__)
@api_bp.route("/<string:short_url>", methods=['GET'])
def redirect_to_url(short_url):
    redir=Urls.query.filter_by(short_url=short_url).first()
    if not redir:
        abort(404)

    return redirect(redir.full_url)

@api_bp.route("/api/v1/shorten", methods=['POST'])
def shorten():
    data = request.get_json()

    if not data or "full_url" not in data:
        return jsonify({"error": "No full_url provided"}), 400

    full_url = data["full_url"]
    url=Urls.query.filter_by(full_url=full_url).first()

    if not url:
        short = create_hash(db.session.query(Urls).count())
        new_url = Urls(short_url=short, full_url=full_url)
        db.session.add(new_url)
        try:
            db.session.commit()
            return jsonify({"short_url": short}), 201
        except Exception as e:
            return jsonify({"error": "error while saving to database", "details": str(e)}), 500
    else:
        return jsonify({"short_url": url.short_url}), 200