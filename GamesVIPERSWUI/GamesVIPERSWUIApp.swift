//
//  GamesVIPERSWUIApp.swift
//  GamesVIPERSWUI
//
//  Created by Jose Preatorian on 04-02-26.
//

import SwiftUI

@main
struct GamesVIPERSWUIApp: App {
    var body: some Scene {
        WindowGroup {
            LaunchView()
        }
        .modelContainer(for: FavoriteGame.self)
    }
        
}
