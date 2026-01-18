//
//  ContentView.swift
//  Glasscast
//
//  Created by Surya Sai Gopalam on 17/01/26.
//

import SwiftUI

struct ContentView: View {
    @Environment(ViewModel.self) var viewModel:ViewModel
    var body: some View {
        
            if viewModel.authenStatus == false {
                AuthenView()
            } else {
                
                TabView {
                    HomeView()
                        .tabItem {
                            Label("Home", systemImage: "house.fill")
                        }
                    
                    SearchTabView()
                        .tabItem {
                            Label("Search", systemImage: "magnifyingglass")
                        }
                    
                    SettingsView()
                        .tabItem {
                            Label("Settings", systemImage: "gearshape.fill")
                        }
                
            }
        }
    }
}


#Preview {
    ContentView()
        .environment(ViewModel())
}
