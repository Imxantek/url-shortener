# Url-shortener
summer holiday programming project - the idea is to create a link shortener that also allows us to analyze user data such as ip address or country


### How to setup the database:
1. Run XAMPP and start apache and mysql
2. Open your browser, and then go to http://localhost/phpmyadmin
3. Create a new database and name it _url_db_
4. Make sure your version of the project has an .env file with a correct connection chain
<br>If not - create one, and type in: <br>
_DATABASE_URI=mysql+pymysql://root:@localhost:3306/url_db_
5. Run and create a virtual environment (venv)
6. Install required packets by running <br> _uv pip install -r requirements.txt_<br>
7. Create the tables by simply running <br> _python .\app\database.py_ 

### How to setup the frontend page
1. Install node.js
2. Change the current folder to frontend <br> _cd frontend_</br>
3. Run this command <br> _npm run dev_ </br>
4. After this, click on the link from the cmd, or simply go to <br> _http://localhost:5173_</br>