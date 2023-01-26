//
//  CityData.swift
//  Weather
//
//  Created by Luka Kuterovac on 20.01.2023..
//

import Foundation
import Combine

struct CityModel: Identifiable, Codable {
    let id: Int
    let name: String
    let state: String
    let country: String
    let coord: CoordinatesModel
}

struct CoordinatesModel: Codable {
    let lon: Double
    let lat: Double
}

class CityData: ObservableObject {
    @Published var cities: [CityModel] = []
    
    @MainActor @Sendable
    func getCityData() async {
        if let url = Bundle.main.url(forResource: "cities", withExtension: "json") {
                do {
                    let data = try Data(contentsOf: url)
                    let decoder = JSONDecoder()
                    let jsonData = try decoder.decode([CityModel].self, from: data)
                    cities = jsonData
                } catch {
                    print("error:\(error)")
                }
        }
    }
}
