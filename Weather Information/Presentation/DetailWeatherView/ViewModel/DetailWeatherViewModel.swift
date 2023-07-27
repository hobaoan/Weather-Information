//
//  DetailWeatherViewModel.swift
//  Weather Map
//
//  Created by Hồ Bảo An on 26/07/2023.
//

import Foundation
import UIKit

class DetailWeatherViewModel {
   
    var weatherForecast: WeatherForecast?
    
    func getWeatherForecast(for city: String, completion: @escaping (Error?) -> Void) {
        let urlString = "\(Network.weatherForecastBaseUrl)?q=\(city)&units=metric&appid=\(Network.weatherForecastApiKey)"
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
                let weatherForecast = try decoder.decode(WeatherForecast.self, from: data)
                self.weatherForecast = weatherForecast
                completion(nil)
                
            } catch {
                completion(error)
            }
        }.resume()
    }
    
}
