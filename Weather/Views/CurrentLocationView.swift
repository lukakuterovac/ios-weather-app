//
//  CurrentLocationView.swift
//  Weather
//
//  Created by Luka Kuterovac on 22.01.2023..
//

import SwiftUI

struct CurrentLocationView: View {
    @StateObject var locationManager: LocationManager = LocationManager()
    var weatherManager: WeatherManager = WeatherManager()
    @State var weather: ForecastModel?
    
    var body: some View {
        VStack {
            if let location = locationManager.location {
                if let weather = weather {
                    ForecastView(weather: weather)
                } else {
                    LoadingView()
                        .task {
                            do {
                                weather = try await weatherManager.getWeather(lat: Double(location.latitude), lon: Double(location.longitude))
                            } catch {
                                print("Error\(error)")
                            }
                        }
                }
            } else {
                if locationManager.isLoading {
                    LoadingView()
                } else {
                    WelcomeView()
                        .environmentObject(locationManager)
                }
            }
        }
    }
}

struct CurrentLocationView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentLocationView()
    }
}
