//
//  ContentView.swift
//  EduMatrix Admin
//
//  Created by Ankit Rajput on 03/07/24.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                }
            RequestsView()
                .tabItem {
                    Image(systemName: "book.fill")
                }
        }
        .navigationBarHidden(true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

