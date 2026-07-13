# Url-shortener
summer holiday programming project - the idea is to create a link shortener that also allows us to analyze user data such as ip address or country


## .env setup:
1. Create a new file in the main project catalogue, and name it
<br>_.env_<br>
2. To set up the database, type in:
<br>_DATABASE_URI=mysql+pymysql://root:@db:3306/url_db_<br>
3. To set up the frontend, type in:
<br>_FRONTEND_URL=http://localhost:5173_<br>
for local hosting
<br>__OR__<br>
_FRONTEND_URL=(enter your frontend domain name here)_
<br>for hosting on your public domain
4. To set up the backend, type in:
<br>_VITE_API_URL=http://localhost:5000_<br>
for local hosting
<br>__OR__<br>
_VITE_API_URL=(enter your backend domain name here)_
<br>for hosting on your public domain
## db backup:
To backup your database to url_db.sql file simply run:<br>
_docker exec url-shortener-db-1 mysqldump -u root url_db > url_db.sql_
<br>in your cmd