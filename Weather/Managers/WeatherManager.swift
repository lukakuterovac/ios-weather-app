//
//  WeatherManager.swift
//  Weather
//
//  Created by Luka Kuterovac on 22.01.2023..
//

import Foundation
import CoreLocation

let API_KEY = "API_KEY"

class WeatherManager {
    func getWeather(lat: CLLocationDegrees, lon: CLLocationDegrees) async throws -> ForecastModel {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(API_KEY)&units=metric") else { fatalError("Missing URL") }
        
        let urlRequest = URLRequest(url: url)
        
        let (data, response) =  try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error fetching weather data") }
        
        let decodedData = try JSONDecoder().decode(ForecastModel.self, from: data)
        
        return decodedData
    }
}

struct ForecastModel: Decodable, Identifiable {
    var coord: CoordinatesModel
    var weather: [WeatherModel]
    var main: MainModel
    var name: String
    var wind: WindModel
    var id: Int
    
    struct WeatherModel: Decodable {
        var id: Double
        var main: String
        var description: String
        var icon: String
    }
    
    struct MainModel: Decodable {
        var temp: Double
        var feels_like: Double
        var temp_min: Double
        var temp_max: Double
        var pressure: Double
        var humidity: Double
    }
    
    struct WindModel: Decodable {
        var speed: Double
        var deg: Double
    }
}
