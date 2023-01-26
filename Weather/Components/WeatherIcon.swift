//
//  WeatherIcon.swift
//  Weather
//
//  Created by Luka Kuterovac on 23.01.2023..
//

import SwiftUI

let clouds = "Clouds"
let clear = "Clear"
let atmosphere = ["Mist", "Smoke", "Haze", "Dust", "Fog", "Sand", "Ash", "Squall", "Tornado"]
let snow = "Snow"
let rain = "Rain"
let drizzle = "Drizzle"
let thunderstorm = "Thunderstorm"


struct WeatherIcon: View {
    @Binding var weather: String
    
    var body: some View {
        Image(systemName: getWeatherIcon(weather: weather))
            .imageScale(.large)
    }
    
    func getWeatherIcon(weather: String) -> String {
        let hour = Calendar.current.component(.hour, from: Date())
        if (weather == clear) {
            if (hour >= 6 && hour <= 21) {
                return "sun.max"
            } else {
                return "moon.stars"
            }
        } else if (weather == clouds) {
            return "cloud"
        } else if (weather == rain || weather == drizzle) {
            return "cloud.heavyrain"
        } else if (weather == thunderstorm) {
            return "cloud.bolt"
        } else if (weather == snow) {
            return "cloud.snow"
        } else if (atmosphere.contains(weather)) {
            return "cloud.fog"
        }
        return "questionmark.circle"
    }
}

struct WeatherIcon_Previews: PreviewProvider {
    static var previews: some View {
        WeatherIcon(weather: Binding.constant("Clear"))
    }
}
