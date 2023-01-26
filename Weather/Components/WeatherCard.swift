//
//  Forecast.swift
//  Weather
//
//  Created by Luka Kuterovac on 13.12.2022..
//

import SwiftUI

struct WeatherCard: View {
    
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var userData: UserData
    var coords: Coordinates
    var weatherManager: WeatherManager = WeatherManager()
    @State var isForecastDetailsShown = false
    @State var weather: ForecastModel?
    
    var body: some View {
        Button(action: { isForecastDetailsShown.toggle() }) {
            if let weather = weather {
                HStack {
                    Text(weather.name)
                        .bold()
                    Spacer()
                    WeatherIcon(weather: Binding.constant(weather.weather[0].main))
                    Text(weather.main.temp.roundDouble() + "°")
                        .bold()
                }.padding()
            } else {
                HStack {
                    Spacer()
                    Text("Loading")
                    Spacer()
                        .task {
                            do {
                                weather = try await weatherManager.getWeather(lat: coords.lat, lon: coords.lon)
                            } catch {
                                print("Error\(error)")
                            }
                        }
                }.padding()
            }
        }
        .tint(colorScheme == .dark ? .black : .white)
        .foregroundColor(.blue)
        .buttonStyle(.bordered)
        .buttonBorderShape(.roundedRectangle)
        .overlay(RoundedRectangle(cornerRadius: 16.0).stroke(Color.blue, lineWidth: 2.0))
        .sheet(
            isPresented: $isForecastDetailsShown
        ) {
            VStack {
                HStack {
                    let coords = Coordinates(id: coords.id, lon: coords.lon, lat: coords.lat)
                    Button(action: {
                        if(userData.contains(coords)) {
                            userData.remove(coords)
                        } else {
                            userData.add(coords)
                        }
                    }) {
                        Spacer()
                        if(userData.contains(coords)) {
                            Text("Remove")
                        } else {
                            Text("Add")
                        }
                    }
                    .padding()
                }
                ForecastView(weather: weather!)
                HStack {
                    Spacer()
                    Button(action: { isForecastDetailsShown.toggle() }) {
                        Text("Back")
                    }
                    Spacer()
                }
                .padding()
            }
        }
    }
}

struct WeatherCard_Previews: PreviewProvider {
    static var previews: some View {
        WeatherCard(coords: Coordinates(id: "a", lon: 0.0, lat: 0.0))
            .environmentObject(UserData())
    }
}
