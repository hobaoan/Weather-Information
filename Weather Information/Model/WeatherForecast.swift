//
//  WeatherForecast.swift
//  Weather Map
//
//  Created by Hồ Bảo An on 26/07/2023.
//

import Foundation

class WeatherForecast: Codable {
    let city: City
    let list: [WeatherInfo]
    
    init(city: City, list: [WeatherInfo]) {
        self.city = city
        self.list = list
    }
}

class City: Codable {
    let name: String
    let country: String
    
    init(name: String, country: String) {
        self.name = name
        self.country = country
    }
}

class WeatherInfo: Codable {
    let dt: Int
    let main: MainWeather
    let weather: [WeatherDescription]
    let wind: Wind
    let visibility: Int
    let pop: Double
    let dt_txt: String
    
    init(dt: Int, main: MainWeather, weather: [WeatherDescription], wind: Wind, visibility: Int, pop: Double, dt_txt: String) {
        self.dt = dt
        self.main = main
        self.weather = weather
        self.wind = wind
        self.visibility = visibility
        self.pop = pop
        self.dt_txt = dt_txt
    }
}

class MainWeather: Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
    let humidity: Int
    
    init(temp: Double, feels_like: Double, temp_min: Double, temp_max: Double, pressure: Int, humidity: Int) {
        self.temp = temp
        self.feels_like = feels_like
        self.temp_min = temp_min
        self.temp_max = temp_max
        self.pressure = pressure
        self.humidity = humidity
    }
}

class WeatherDescription: Codable {
    let main: String
    let description: String
    let icon: String
    
    init(main: String, description: String, icon: String) {
        self.main = main
        self.description = description
        self.icon = icon
    }
}

class Wind: Codable {
    let speed: Double
    let deg: Int
    let gust: Double
    
    init(speed: Double, deg: Int, gust: Double) {
        self.speed = speed
        self.deg = deg
        self.gust = gust
    }
}
