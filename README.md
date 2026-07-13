# Url-shortener

## Project goals and description:
Shortify is a modern, self-hosted URL shortener that not only creates tiny links but also provides in-depth analytics for every click. Built as a summer holiday programming project, it tracks user engagement including IP-based geolocation, browser types, and click-time trends.

### Key features:
- **Fast url shortening** - Turn very long links into short shareable codes
- **Advanced analytics** - Tsx Charts (powered by recharts) depicting:
  - Clicks over the last 7 days 
  - Browser usage statistics
  - User Geolocation (countries)
- **Dockerized environment** - Fully containerized for deployment for any machine or home server
- **Production ready** - Configured to work behind Reverse Proxies and Cloudflare Tunnels

## Tech stack:
- **Frontend** - React 19, TypeScript, Vite, Recharts
- **Backend** - Flask, Python, SQLAlchemy
- **Database** - MySql 8.0
- **Deployment** - Docker & Docker Compose

## Setup and installation:
### 1. Prerequisites 
Make sure you have installed on your machine:
- [Docker](https://www.docker.com/) and Docker Compose
- Git
### 2. Environment Variables (`.env`)
Create a new file named `.env` in the root directory of the project and paste the following configuration. 

Adjust the URLs depending on your environment (Local vs Production):

```env
# Database Connection
DATABASE_URI=mysql+pymysql://root:@db:3306/url_db

# Frontend URL (Used by Backend for CORS)
# - For Local: http://localhost:5173
# - For Prod:  https://your-domain.com
FRONTEND_URL=http://localhost:5173

# Backend API URL (Used by Frontend to fetch data)
# - For Local: http://localhost:5000
# - For Prod:  https://api.your-domain.com
VITE_API_URL=http://localhost:5000
```

### 3. Run the application:
```
docker-compose up --build
```
- The frontend will be available on http://localhost:5173 (or your domain) .
- The backend will be available on http://localhost:5000 (or your domain).
- The database initializes automatically using the url_db.sql dump.

## Database management:
To create a backup of your current database to url_db.sql file, run the following command into your terminal:
```
docker exec url-shortener-db-1 mysqldump -u root url_db > url_db.sql
```
Note: make sure your db container is called url-shortener-db-1. If not, replace it with the correct container name

## Testing

### Backend (Python / Pytest)
The backend test suite is built with `pytest` and runs directly inside the isolated Docker container. To execute the tests, run the following command in your terminal:

```bash
docker-compose exec backend pytest /app/tests  
```
### Test Coverage Includes:
- **Unit Tests (Core Logic)**: Validation of the shortener service (the core URL hashing algorithm). We ensure that the algorithm reliably generates valid strings and gracefully handles invalid inputs.
- **Integration Tests (API Endpoints)**: Validation of the Flask API routes using an isolated, in-memory SQLite database. We verify that the endpoints (like /api/v1/shorten) correctly process client requests, manage database states safely, and return the expected HTTP status codes.

### Frontend (React / Vitest)
The frontend test suite is powered by Vitest and React Testing Library, providing a fast, Vite-native testing environment that simulates a real browser DOM. To execute the tests, navigate to the frontend directory and run:

```Bash
cd frontend
npm run test
```
### Test Coverage Includes:
- **Component Rendering**: Ensuring core components (like the Home view and Analytics dashboard) mount and render correctly without crashing.
- **UI Elements & Accessibility**: Verifying that essential user interface elements (such as input fields, submission buttons, and headers) are present and interactable in the document.

Created by Imxantek