//
//  ContentView.swift
//  Client
//
//  Created by Emma GAUBERT on 10/11/2023.
//

import SwiftUI

/// First view displayed when a user opens the App. Allows user to select what she wishes to display.
struct ContentView: View {
    var body: some View {
        TabView {
            
            // TODO: Homepage
            // TODO: Each country has a detailed page with info about the different dishes
            WorldCuisineMenuView()
                .tabItem {
                    Label("Explore", systemImage: "network") // compass instead
                }
            
            // TODO: SearchView allows users to add a list of ingredients and get suggestions for which recipes they could make with those
            // TODO: A random recipe to appear and people can swipe
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            
            AddRecipeView()
                .tabItem {
                    Label("Add", systemImage: "plus")
                }
            
            LikesView()
                .tabItem {
                    Label("Likes", systemImage: "hand.thumbsup")
                }
            
            // TODO: Build UserProfileView with UIKit
            UserProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person") // users' photo instead
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
