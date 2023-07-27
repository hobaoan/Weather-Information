//
//  WeatherViewModel.swift
//  Weather Map
//
//  Created by Hồ Bảo An on 20/07/2023.
//

import Foundation

class WeatherViewModel {
    
    var weatherData: WeatherData?

    
    func getWeatherData(for city: String, completion: @escaping (Error?) -> Void) {
        let urlString = "\(Network.weatherDataBaseUrl)?q=\(city)&units=metric&appid=\(Network.weatherDataApiKey)"
        guard let url = URL(string: urlString) else {
            completion(NSError(domain: "Invalid URL", code: 0, userInfo: nil))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(error)
                return
            }
            
            guard let data = data else {
                completion(NSError(domain: "Empty response", code: 0, userInfo: nil))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let weatherData = try decoder.decode(WeatherData.self, from: data)
                self.weatherData = weatherData
                completion(nil)
                
            } catch {
                completion(error)
            }
        }.resume()
    }
    
    func printWeatherDataAsJSON() {
        if let weatherData = self.weatherData {
            do {
                let encoder = JSONEncoder()
                encoder.outputFormatting = .prettyPrinted
                let jsonData = try encoder.encode(weatherData)
                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    print("Weather Data json: \(jsonString)")
                } else {
                    print("Error: Unable to convert data to string")
                }
            } catch {
                print("Error: Unable to encode WeatherData to JSON format")
            }
        } else {
            print("Error: No weather data available")
        }
    }
    
}
