//
//  Serenity_SquadApp.swift
//  Serenity Squad
//
//  Created by marhuenda joris on 02/06/2024.
//

import SwiftUI

@main
struct Serenity_SquadApp: App {
    @StateObject private var themeStore = ThemeStore(named: "default")
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(themeStore)
        }
    }
}
