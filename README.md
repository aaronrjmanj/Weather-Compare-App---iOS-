📌 WeatherCompare - iOS App
A simple iOS app built with SwiftUI that allows users to compare the weather of two cities side by side. It fetches real-time weather data from the OpenWeatherMap API and displays the temperature, weather condition, and icons for selected cities.

📸 Screenshot

🚀 Features
✅ Select two cities from a list
✅ Fetch real-time weather data using OpenWeatherMap API
✅ Display temperature, weather description, and icons
✅ SwiftUI-based responsive design
✅ Uses URLSession for API requests

🛠️ Technologies Used
	•	Swift 5 & SwiftUI
	•	Xcode
	•	OpenWeatherMap API
	•	URLSession for Networking
	•	JSON Parsing

📌 Installation & Setup
🔹 Prerequisites
	•	Install Xcode (latest version) from the Mac App Store
	•	Get an API key from OpenWeatherMap

🔹 Steps to Run Locally
	1.	Clone the repository:
       git clone https://github.com/YOUR_USERNAME/WeatherCompare.git
       cd WeatherCompare
  2.	Open WeatherCompare.xcodeproj in Xcode.
	3.	Replace "YOUR_API_KEY" in ContentView.swift with your actual API key.
	4.	Select an iPhone simulator and Run the project (Cmd + R).

 🖥️ How It Works
	1.	Open the app and select two cities from the dropdown list.
	2.	Tap the “Compare Weather” button.
	3.	The app fetches real-time weather and displays:
	•	Temperature (°C) 🌡️
	•	Weather condition (e.g., “Cloudy”, “Sunny”) ⛅
	•	Weather icon 🌤️

 📌 Future Improvements
🔹 Add a searchable city picker instead of a fixed list
🔹 Improve UI with animations and themes
🔹 Add support for multiple weather providers
