//
//  WeatherDetail.swift
//  Weather
//
//  Created by Luka Kuterovac on 23.01.2023..
//

import SwiftUI

struct WeatherDetail: View {
    var logo: String
    var name: String
    var value: String
    
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: logo)
                .font(.title2)
                .frame(width: 20, height: 20)
                .padding()
                .background(.gray.opacity(0.25))
                .cornerRadius(50)
            Spacer()
            VStack {
                Text(name)
                    .font(.caption)
                    .bold()
                Text(value)
                    .font(.title3)
            }
        }
        .frame(maxWidth: 250)
        .padding(20)
        .background(.gray.opacity(0.10))
        .cornerRadius(32)
    }
}

struct WeatherDetail_Previews: PreviewProvider {
    static var previews: some View {
        WeatherDetail(logo: "humidity", name: "Humidity", value: "50%")
    }
}
