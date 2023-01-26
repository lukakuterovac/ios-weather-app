//
//  UserData.swift
//  Weather
//
//  Created by Luka Kuterovac on 21.01.2023..
//

import Foundation

class UserData: ObservableObject {
    private let defaults = UserDefaults.standard
    private var favorites: Set<String>
    private var favoriteCoords: [String: Coordinates]
    private let favoritesSetKey = "favorites"
    private let favoritesDictKey = "favoriteCoords"
    
    init() {
        favorites = []
        favoriteCoords = [:]
    }
    
    func get() -> [Coordinates] {
        var favorites: [Coordinates] = []
        for fav in favoriteCoords {
            favorites.append(fav.value)
        }
        return favorites
    }
    
    func contains(_ coords: Coordinates) -> Bool {
        favorites.contains(coords.id)
    }
    
    func add(_ coords: Coordinates) {
        objectWillChange.send()
        favorites.insert(coords.id)
        favoriteCoords.updateValue(coords, forKey: coords.id)
        save()
    }
    
    func remove(_ coords: Coordinates) {
        objectWillChange.send()
        favorites.remove(coords.id)
        favoriteCoords.removeValue(forKey: coords.id)
        save()
    }
    
    func save() {
        if let encoded = try? JSONEncoder().encode(favoriteCoords) {
            defaults.set(encoded, forKey: favoritesDictKey)
        }
    }
    
    @Sendable
    func load() async {
        if let data = defaults.object(forKey: favoritesDictKey) as? Data,
           let coords = try? JSONDecoder().decode([String: Coordinates].self, from: data) {
            favoriteCoords = coords
        }
        favorites = Set<String>()
        for el in favoriteCoords {
            favorites.insert(el.key)
        }
    }
}

struct Coordinates: Identifiable, Codable {
    let id: String
    let lon: Double
    let lat: Double
}
