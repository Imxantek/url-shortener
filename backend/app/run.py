from __init__ import create_app
from models import db
app = create_app()

if __name__ == '__main__':
    with app.app_context():
        db.create_all()
        print("Successfully created the database")

    app.run(host="0.0.0.0", debug=True, port=5000)