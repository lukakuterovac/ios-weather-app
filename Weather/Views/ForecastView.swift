//
//  ForecastView.swift
//  Weather
//
//  Created by Luka Kuterovac on 23.01.2023..
//

import SwiftUI

struct ForecastView: View {
    var weather: ForecastModel
    
    var body: some View {
        VStack {
            Spacer()
            Text(weather.name)
                .font(.system(size: 30))
            Text(weather.main.temp.roundDouble() + "°")
                .font(.system(size: 90))
                .bold()
            HStack {
                Text(weather.weather[0].main)
                    .font(.system(size: 30))
                WeatherIcon(weather: Binding.constant(weather.weather[0].main))
            }
            Spacer()
            VStack {
                WeatherDetail(logo: "thermometer.low", name: "Min temp", value: weather.main.temp_min.roundDouble() + "°")
                WeatherDetail(logo: "thermometer.high", name: "Max temp", value: weather.main.temp_max.roundDouble() + "°")
                WeatherDetail(logo: "humidity", name: "Humidity", value: weather.main.humidity.roundDouble() + "%")
                WeatherDetail(logo: "wind", name: "Wind speed", value: weather.wind.speed.roundDouble() + "m/s")
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ForecastView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastView(weather: previewWeather)
    }
}
