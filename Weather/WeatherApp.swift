//
//  WeatherApp.swift
//  Weather
//
//  Created by Luka Kuterovac on 13.12.2022..
//

import SwiftUI
import Network

@main
struct WeatherApp: App {
    
    @StateObject var userData: UserData = UserData()
    @StateObject var cityData: CityData = CityData()
    let networkMonitor = NWPathMonitor()
    
    var body: some Scene {
        WindowGroup {
            TabView {
                ContentView(favorites: ForecastViewModel(coords: userData.get()))
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                SearchView()
                    .tabItem {
                        Label("Search", systemImage: "magnifyingglass")
                    }
                CurrentLocationView()
                    .tabItem {
                        Label("Current location", systemImage: "location")
                    }
            }
            .environmentObject(userData)
            .environmentObject(cityData)
            .task(cityData.getCityData)
            .task(userData.load)
        }
    }
}
