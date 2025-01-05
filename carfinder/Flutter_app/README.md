# Car Finder App

This is a simple car search application built with Flutter for the frontend and PHP + MySQL for the backend. It allows users to search for cars within a specific price range.

## Features
- Search for cars by price range.
- Displays car name and price in a clean UI.
- Connects to a backend service hosted online.

## Setup Instructions
### Flutter Frontend
1. Install Flutter on your machine.
2. Clone this repository.
3. Navigate to the `flutter_app` directory.
4. Run `flutter pub get` to install dependencies.
5. Run `flutter run` to launch the app.

### Backend
1. The backend is written in PHP and hosted online.
2. Ensure the `search_cars.php` file is uploaded to your hosting server.
3. Ensure your database is correctly set up using the `database.sql` file.

### Database
- Create a MySQL database using the `database.sql` file provided in the `backend` folder.
- Update the `search_cars.php` file with your database credentials.

## Folder Structure
- `flutter_app`: Contains the Flutter project files.
- `backend`: Contains PHP code and SQL database setup files.

## License
This project is for educational purposes only.
