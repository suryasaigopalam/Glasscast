//
//  GlasscastApp.swift
//  Glasscast
//
//  Created by Surya Sai Gopalam on 17/01/26.
//

import SwiftUI

@main
struct GlasscastApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(ViewModel())
        }
    }
}
