from __init__ import create_app
from models import db
import time
app = create_app()

if __name__ == '__main__':

    with app.app_context():
        for i in range(5):
            try:
                db.create_all()
                print("Successfully created the database")
                break
            except Exception as e:
                print(f"Failed to create the database. Retrying in 5 seconds ({4-i} tries left)...")
                time.sleep(5)
    app.run(host="0.0.0.0", debug=True, port=5000)