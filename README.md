# WeatherJournal
WeatherJournal is a weather tracking app that provides users with real-time weather updates based on their current location. 

Features
Location-based Weather Updates: Automatically detects your current location and fetches real-time weather data.
Builder Pattern for Weather Data Fetching: Implements the Builder Pattern for constructing the WeatherService, allowing more flexibility in configuring service dependencies.
Location Permission Handling: Manages location permission statuses such as authorized, denied, restricted, or not determined.
Lazy Loading for Views: Efficient UI rendering with SwiftUI's LazyView, improving app performance and memory management.
Asynchronous Weather Data Fetching: Utilizes Swift's concurrency model (async/await) for non-blocking API requests.
Error Handling: Displays user-friendly error messages and allows users to retry fetching weather data if an error occurs.


Technologies Used
SwiftUI: For building declarative user interfaces.
CoreLocation: To manage device location services and permissions.
Builder Pattern: To implement a clean, flexible architecture for constructing services.
Swift Concurrency: For handling asynchronous operations using async/await.
MVVM Architecture: For separating business logic from the UI, ensuring code scalability and maintainability.
Weather API: For fetching current weather data based on the user's location.

Installation
Clone the repository:

git clone https://github.com/devdallu/WeatherJournal.git
Open the project in Xcode:

Build and run the project on a simulator or a physical device.
