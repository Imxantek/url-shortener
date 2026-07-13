import os
from app.models import *
from app.api import api_bp
from flask import Flask
from flask_cors import CORS
from dotenv import load_dotenv
def create_app():
    load_dotenv()
    CURRENT_DIR = os.path.abspath(os.path.dirname(__file__))
    app = Flask(__name__)
    frontend_url = os.getenv('FRONTEND_URL', 'http://localhost:5173')
    CORS(app, resources={r"/api/*": {"origins": frontend_url}})

    app.config['SQLALCHEMY_DATABASE_URI'] = os.getenv('DATABASE_URI')
    app.config['SQLALCHEMY_TRACK_MODIFICATION'] = False
    app.config['SQLALCHEMY_ECHO'] = True

    db.init_app(app)
    app.register_blueprint(api_bp)
    return app