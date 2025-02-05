# AgriTech Market Connect

AgriTech Market Connect is a mobile application designed to empower farmers by providing up-to-date market trends and pricing information. This project consists of a **back-end** built with Django and a **mobile app** developed using Flutter.

---

## Prerequisites

Ensure you have the following installed:

- **Back-end**
  - Python 3.9+  
  - Django 4.x  
  - PostgreSQL  
  - Virtualenv  
  - Gunicorn  

- **Mobile App**
  - Flutter SDK 3.x  
  - Android Studio / Xcode  


## Back-End Setup (Django)

### 1. Clone the Repository
```bash
git clone https://github.com/Ben6jamin/agritech_market_connect.git
cd agritech_market_connect/server
```

### 2. Create a Virtual Environment
```bash
python3 -m venv venv
source venv/bin/activate  # Use `venv\Scripts\activate` on Windows
```

### 3. Install Dependencies
```bash
pip install -r requirements.txt
```
### 4. Run Migrations
```bash
python manage.py makemigrations
python manage.py migrate
```

### 5. Start the Server
```bash
python manage.py runserver
``` 
------

## Mobile App setup (Flutter)

### 1. Install dependencies
```bash
python manage.py runserver
```

### 2. Run the app
```bash
flutter run
```


# Deployment Plan
## Back-End Deployment
Set Up the Server

Use a cloud platform (e.g., AWS, DigitalOcean, or Heroku).
Install Docker or Python on the server.
Deploy Django Back-End

Use Gunicorn and Nginx for deployment.
Steps:
```bash
pip install gunicorn
gunicorn --bind 0.0.0.0:8000 projectname.wsgi
```
Configure Nginx to proxy requests to Gunicorn.
Use HTTPS

Use Let's Encrypt for free SSL certificates:
```bash
sudo certbot --nginx
```
Environment Variables

Use .env files or export variables for sensitive configurations like database credentials.

## Mobile App Deployment
Generate Build

For Android:
```bash
flutter build apk
```
For iOS:
```bash
flutter build ios
```

Distribute App

Android: Publish the APK on the Google Play Store.
iOS: Submit the app to the Apple App Store.
API Endpoint Configuration

Ensure the mobile app points to the live Django back-end URL in the API_BASE_URL variable.
