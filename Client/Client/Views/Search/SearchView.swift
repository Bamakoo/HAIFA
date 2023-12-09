//
//  Search.swift
//  Client
//
//  Created by Emma GAUBERT on 26/11/2023.
//

import SwiftUI
// TODO: users can input a list of ingredients and get back a list of recipes that they can make with those ingredients
struct SearchView: View {
    
    @StateObject private var viewModel = SearchViewModel()
    @State private var showingSheet = false
    
    var body: some View {
        Button {
            Task {
                showingSheet.toggle()
                try await viewModel.fetchRandomRecipe()
            }
        } label: {
            Text("Discover a random recipe!")
        }
        .sheet(isPresented: $showingSheet) {
            RecipeDetailView(recipe: Binding.constant(viewModel.randomRecipe))
        }
    }
}

struct Search_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
