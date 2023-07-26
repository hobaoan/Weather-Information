//
//  WeatherForecast.swift
//  Weather Map
//
//  Created by Hồ Bảo An on 26/07/2023.
//

import Foundation

class WeatherForecast: Codable {
    var cod: String
    var message: Int
    var cnt: Int
    var list: [WeatherForecastData]
    var city: CityData
    
    init(cod: String, message: Int, cnt: Int, list: [WeatherForecastData], city: CityData) {
        self.cod = cod
        self.message = message
        self.cnt = cnt
        self.list = list
        self.city = city
    }
}

class WeatherForecastData: Codable {
    var dt: TimeInterval
    var main: WeatherMain
    var weather: [WeatherInfo]
    var clouds: Clouds
    var wind: Wind
    var visibility: Int
    var pop: Float
    var rain: Rain?
    var sys: Sys
    var dt_txt: String
    
    init(dt: TimeInterval, main: WeatherMain, weather: [WeatherInfo], clouds: Clouds, wind: Wind, visibility: Int, pop: Float, rain: Rain?, sys: Sys, dt_txt: String) {
        self.dt = dt
        self.main = main
        self.weather = weather
        self.clouds = clouds
        self.wind = wind
        self.visibility = visibility
        self.pop = pop
        self.rain = rain
        self.sys = sys
        self.dt_txt = dt_txt
    }
}

class WeatherMain: Codable {
    var temp: Float
    var feels_like: Float
    var temp_min: Float
    var temp_max: Float
    var pressure: Int
    var sea_level: Int
    var grnd_level: Int
    var humidity: Int
    var temp_kf: Float
    
    init(temp: Float, feels_like: Float, temp_min: Float, temp_max: Float, pressure: Int, sea_level: Int, grnd_level: Int, humidity: Int, temp_kf: Float) {
        self.temp = temp
        self.feels_like = feels_like
        self.temp_min = temp_min
        self.temp_max = temp_max
        self.pressure = pressure
        self.sea_level = sea_level
        self.grnd_level = grnd_level
        self.humidity = humidity
        self.temp_kf = temp_kf
    }
}

class WeatherInfo: Codable {
    var id: Int
    var main: String
    var description: String
    var icon: String
    
    init(id: Int, main: String, description: String, icon: String) {
        self.id = id
        self.main = main
        self.description = description
        self.icon = icon
    }
}

class Clouds: Codable {
    var all: Int
    
    init(all: Int) {
        self.all = all
    }
}

class Wind: Codable {
    var speed: Float
    var deg: Int
    var gust: Float?
    
    init(speed: Float, deg: Int, gust: Float?) {
        self.speed = speed
        self.deg = deg
        self.gust = gust
    }
}

class Rain: Codable {
    var h3: Float
    
    init(h3: Float) {
        self.h3 = h3
    }
}

class Sys: Codable {
    var pod: String
    
    init(pod: String) {
        self.pod = pod
    }
}

class CityData: Codable {
    var id: Int
    var name: String
    var coord: Coordinates
    var country: String
    var population: Int
    var timezone: Int
    var sunrise: TimeInterval
    var sunset: TimeInterval
    
    init(id: Int, name: String, coord: Coordinates, country: String, population: Int, timezone: Int, sunrise: TimeInterval, sunset: TimeInterval) {
        self.id = id
        self.name = name
        self.coord = coord
        self.country = country
        self.population = population
        self.timezone = timezone
        self.sunrise = sunrise
        self.sunset = sunset
    }
}

class Coordinates: Codable {
    var lat: Double
    var lon: Double
    
    init(lat: Double, lon: Double) {
        self.lat = lat
        self.lon = lon
    }
}

