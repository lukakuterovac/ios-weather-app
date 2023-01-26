//
//  NoInternetView.swift
//  Weather
//
//  Created by Luka Kuterovac on 23.01.2023..
//

import SwiftUI

struct NoInternetView: View {
    var body: some View {
        VStack {
            Text("No internet connection")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct NoInternetView_Previews: PreviewProvider {
    static var previews: some View {
        NoInternetView()
    }
}
