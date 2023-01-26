//
//  SearchView.swift
//  Weather
//
//  Created by Luka Kuterovac on 17.01.2023..
//

import SwiftUI

struct SearchView: View {
    
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var cityData: CityData
    @State var query: String = ""
    var filteredCties: [CityModel] {
        if query.isEmpty {
            return Array()
        } else {
            return cityData.cities.filter { city in
                return city.name.lowercased().starts(with: query.lowercased())
            }
        }
    }
    
    var body: some View {
        VStack {
            TopBar()
            TextField("Search a city", text: $query)
                .autocorrectionDisabled(true)
                .textInputAutocapitalization(.never)
                .padding()
                .background(RoundedRectangle(cornerRadius: 16.0)
                    .opacity(0.1))
            List(filteredCties) { city in
                CityItem(
                    city: Binding.constant(city)
                ).environmentObject(cityData)
            }
            .listStyle(.plain)
            Spacer()
        }.padding()
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView().environmentObject(CityData()).environmentObject(CityData())
    }
}
