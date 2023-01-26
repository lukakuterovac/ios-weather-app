//
//  ContentView.swift
//  Weather
//
//  Created by Luka Kuterovac on 13.12.2022..
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var userData: UserData
    var weatherManager = WeatherManager()
    @State var isShowingForecastDetails = false
    @ObservedObject var favorites: ForecastViewModel
    @State var weather: ForecastModel?
        
    var body: some View {
        VStack {
            TopBar()
            Spacer()
            if (favorites.forecasts.isEmpty) {
                HStack {
                    Spacer()
                    Text("No favorites.")
                    Spacer()
                }
            } else {
                List(favorites.forecasts) { favorite in
                    WeatherCard(coords: favorite)
                        .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
            }
            Spacer()
        }
        .padding()
        .task {
            favorites.forecasts = userData.get()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(favorites: ForecastViewModel())
            .environmentObject(UserData())
    }
}
