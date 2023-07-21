//
//  Weather.swift
//  Weather Map
//
//  Created by Hồ Bảo An on 20/07/2023.
//

class WeatherData: Codable {
    
    class Coordinate: Codable {
        let lon: Double
        let lat: Double
        
        init(lon: Double, lat: Double) {
            self.lon = lon
            self.lat = lat
        }
    }
    
    class WeatherInfo: Codable {
        let id: Int
        let main: String
        let description: String
        let icon: String
        
        init(id: Int, main: String, description: String, icon: String) {
            self.id = id
            self.main = main
            self.description = description
            self.icon = icon
        }
    }
    
    class MainInfo: Codable {
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
    
    class WindInfo: Codable {
        let speed: Double
        let deg: Int
        
        init(speed: Double, deg: Int) {
            self.speed = speed
            self.deg = deg
        }
    }
    
    class CloudsInfo: Codable {
        let all: Int
        
        init(all: Int) {
            self.all = all
        }
    }
    
    class SystemInfo: Codable {
        let type: Int
        let id: Int
        let country: String
        let sunrise: Int
        let sunset: Int
        
        init(type: Int, id: Int, country: String, sunrise: Int, sunset: Int) {
            self.type = type
            self.id = id
            self.country = country
            self.sunrise = sunrise
            self.sunset = sunset
        }
    }
    
    let coord: Coordinate
    let weather: [WeatherInfo]
    let base: String
    let main: MainInfo
    let visibility: Int
    let wind: WindInfo
    let clouds: CloudsInfo
    let dt: Int
    let sys: SystemInfo
    let timezone: Int
    let id: Int
    let name: String
    let cod: Int
    
    init(coord: Coordinate, weather: [WeatherInfo], base: String, main: MainInfo, visibility: Int, wind: WindInfo, clouds: CloudsInfo, dt: Int, sys: SystemInfo, timezone: Int, id: Int, name: String, cod: Int) {
        self.coord = coord
        self.weather = weather
        self.base = base
        self.main = main
        self.visibility = visibility
        self.wind = wind
        self.clouds = clouds
        self.dt = dt
        self.sys = sys
        self.timezone = timezone
        self.id = id
        self.name = name
        self.cod = cod
    }
}
