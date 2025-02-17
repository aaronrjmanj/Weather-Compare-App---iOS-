//
//  ContentView.swift
//  WeatherCompare
//
//  Created by Arun Raja Priyadharshini on 2/15/25.
//

import SwiftUI

struct ContentView: View {
    @State private var city1: String = ""
    @State private var city2: String = ""
    @State private var weather1: String = "Weather for City 1"
    @State private var weather2: String = "Weather for City 2"
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Weather Compare")
                .font(.largeTitle)
                .bold()
            
            HStack {
                VStack {
                    TextField("Enter first city", text: $city1)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    Text(weather1)
                }
                VStack {
                    TextField("Enter second city", text: $city2)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    Text(weather2)
                }
            }
            
            Button(action: fetchWeather) {
                Text("Compare Weather")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
    
    //New function to compare the weather
    func fetchWeather() {
        guard !city1.isEmpty, !city2.isEmpty else {
            weather1 = "Please enter both city names."
            weather2 = ""
            return
        }
        
        let apiKey = "" // Replace with your actual API key
        
        let group = DispatchGroup() // To handle both requests simultaneously
        
        // Fetch weather for city 1
        group.enter()
        fetchWeather(for: city1, apiKey: apiKey) { result in
            DispatchQueue.main.async {
                self.weather1 = result
                group.leave()
            }
        }
        
        // Fetch weather for city 2
        group.enter()
        fetchWeather(for: city2, apiKey: apiKey) { result in
            DispatchQueue.main.async {
                self.weather2 = result
                group.leave()
            }
        }
        
        // Notify when both requests are done
        group.notify(queue: .main) {
            print("Weather comparison complete!")
        }
    }
    
    func fetchWeather(for city: String, apiKey: String, completion: @escaping (String) -> Void) {
        let cityEncoded = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? city
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(cityEncoded)&appid=\(apiKey)&units=metric"
        
        guard let url = URL(string: urlString) else {
            completion("Invalid URL for \(city)")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion("Error fetching weather: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                completion("No data received")
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let main = json["main"] as? [String: Any],
                   let temp = main["temp"] as? Double,
                   let weatherArray = json["weather"] as? [[String: Any]],
                   let weather = weatherArray.first,
                   let description = weather["description"] as? String,
                   let icon = weather["icon"] as? String {
                    
                    let iconURL = "https://openweathermap.org/img/wn/\(icon)@2x.png"
                    
                    completion("🌡 Temp: \(temp)°C\n🌤 \(description.capitalized)\n🖼 [Icon](\(iconURL))")
                } else {
                    completion("Could not parse weather for \(city)")
                }
            } catch {
                completion("Failed to parse JSON: \(error.localizedDescription)")
            }
        }.resume()
    }
}
