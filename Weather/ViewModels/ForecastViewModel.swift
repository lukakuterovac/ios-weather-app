//
//  ForecastViewModel.swift
//  Weather
//
//  Created by Luka Kuterovac on 24.01.2023..
//

import Foundation

class ForecastViewModel: ObservableObject {
    @Published var forecasts: [Coordinates]
    
    init() {
        forecasts = []
    }
    
    init(coords: [Coordinates]) {
        forecasts = coords
    }
}
