//
//  TopBarView.swift
//  Weather
//
//  Created by Luka Kuterovac on 17.01.2023..
//

import SwiftUI

struct TopBar: View {
    var body: some View {
        HStack {
            Spacer()
            Image(systemName: "cloud.circle.fill")
                .foregroundColor(Color.blue)
                .imageScale(.large)
                .bold()
            Text("Simple Weather")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.blue)
            Spacer()
        }.padding()
    }
}

struct TopBarView_Previews: PreviewProvider {
    static var previews: some View {
        TopBar()
    }
}
