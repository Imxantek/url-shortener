from flask_sqlalchemy import SQLAlchemy
from datetime import datetime, timezone

db=SQLAlchemy()

class Urls(db.Model):
    __tablename__ = 'urls'
    full_url = db.Column(db.String(500), primary_key=True)
    short_url = db.Column(db.String(500), nullable=False)
    created_at = db.Column(db.DateTime, default=datetime.now(timezone.utc))

    analytics=db.relationship('Analytics', backref='urls', lazy=True)

class Analytics(db.Model):
    __tablename__ = 'analytics'
    aID = db.Column(db.Integer, primary_key=True)
    full_url = db.Column(db.String(500), db.ForeignKey('urls.full_url'), nullable=False)
    click_time = db.Column(db.DateTime, default=datetime.now(timezone.utc))
    country = db.Column(db.String(30))
    browser = db.Column(db.String(50))