🍽️ Restaurant Finder App

A Flutter-based mobile application that helps users discover restaurants, search for food products, and view directions using Google Maps.

 Features
 Smart Search
Search for food products
Get restaurants that serve the selected product
Real-time filtering suggestions
 Restaurant Discovery
Browse recommended restaurants
View restaurant details (name, address, cuisine, status)
 Directions & Maps
Show user location and restaurant location
Calculate distance between user and restaurant
Estimate travel time
Open Google Maps for navigation
 Interactive Map View
Google Maps integration
Markers for user and restaurants
Switch between list and map views
 Clean UI/UX
Modern and simple design
Reusable components
Responsive layout
 Tech Stack
Flutter
Dart
BLoC (State Management)
Google Maps Flutter
Geolocator
URL Launcher
Dependency Injection (get_it)
 Project Structure
features/
 ├── search/
 │    ├── presentation/
 │    │     ├── screens
 │    │     ├── widgets
 │    │     ├── cubit
 │    │     └── utils
 │
 ├── restaurants/
 │    ├── presentation/
 │    ├── domain/
 │    └── data
📸 Screens (Optional)
Product Search Screen
Restaurant List Screen
Restaurant Details Screen
Directions Map Screen
⚙️ Setup Instructions
Clone the repository:
git clone <repo-url>
Install dependencies:
flutter pub get
Run the app:
flutter run
 Dependencies

Make sure to add:

google_maps_flutter
geolocator
url_launcher
flutter_bloc
get_it
 Future Improvements
Add user authentication
Save favorite restaurants
Add reviews & ratings
Improve recommendation system
Offline map support
 Author

Built by [Habiba Zein]
Computer Science & AI Student – Cairo University
Backend & Flutter Developer
