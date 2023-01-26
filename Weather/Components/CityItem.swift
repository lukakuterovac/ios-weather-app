//
//  City.swift
//  Weather
//
//  Created by Luka Kuterovac on 20.01.2023..
//

import SwiftUI

struct CityItem: View {
    @Binding var city: CityModel
    @EnvironmentObject var userData: UserData
    @State var isForecastDetailsShown = false
    var weatherManager: WeatherManager = WeatherManager()
    @State var weather: ForecastModel?
    
    var body: some View {
        Button(action: { isForecastDetailsShown.toggle() }) {
            Text(city.name + ", " + city.country)
        }
        .sheet(
            isPresented: $isForecastDetailsShown
        ) {
            if let weather = weather {
                VStack {
                    HStack {
                        let coords = Coordinates(id: String(city.id), lon: city.coord.lon, lat: city.coord.lat)
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
                        .task {
                            userData.save()
                        }
                    }
                    ForecastView(weather: weather)
                    HStack {
                        Spacer()
                        Button(action: { isForecastDetailsShown.toggle() }) {
                            Text("Back")
                        }
                        Spacer()
                    }
                    .padding()
                }
            } else {
                LoadingView()
                    .task {
                        do {
                            weather = try await weatherManager.getWeather(lat: city.coord.lat, lon: city.coord.lon)
                        } catch {
                            print("Error\(error)")
                        }
                    }
            }
        }
    }
}

struct CityItem_Previews: PreviewProvider {
    static var previews: some View {
        CityItem(
            city: Binding.constant(
                CityModel(
                    id: 3193935,
                    name: "Osijek",
                    state: "",
                    country: "HR",
                    coord: CoordinatesModel(
                        lon: 18.69389,
                        lat: 45.551109
                    )
                )
            )
        ).environmentObject(UserData())
    }
}
