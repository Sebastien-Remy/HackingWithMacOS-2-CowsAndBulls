//
//  CowsAndBullsApp.swift
//  CowsAndBulls
//
//  Created by Sebastien REMY on 17/10/2022.
//

import SwiftUI

@main
struct CowsAndBullsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        Settings(content: SettingsView.init)
    }
}
