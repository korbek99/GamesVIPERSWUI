//
//  HomeView.swift
//  GamesVIPERSWUI
//
//  Created by Jose Preatorian on 04-02-26.
//


import SwiftUI

struct HomeView: View {
    @State private var selectedTab = 0
    @State private var showMenu = false

    init() {
     
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .black

        appearance.stackedLayoutAppearance.normal.iconColor = .white
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        // 3. Color de los iconos seleccionados (Amarillo)
        appearance.stackedLayoutAppearance.selected.iconColor = .systemYellow
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.systemYellow]

        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }

    var body: some View {
        TabView(selection: $selectedTab) {
            
            CommingSoonView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(0)

            GamesRouter.createModule()
                .tabItem {
                    Label("Games", systemImage: "gamecontroller.fill")
                }
                .tag(1)
            
            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "heart.fill")
                }
                .tag(2)

            InfoView()
                .tabItem {
                    Label("Info", systemImage: "info.circle.fill")
                }
                .tag(3)
        }
 
        .accentColor(.yellow)
    }
}



#Preview {
    HomeView()
}
