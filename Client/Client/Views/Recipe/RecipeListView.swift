//
//  RecipeContent.swift
//  Client
//
//  Created by Emma GAUBERT on 21/11/2023.
//

import SwiftUI

/// A list of recipes from the country selected by the user
struct RecipeListView: View {
    
    @StateObject private var viewModel = RecipeViewModel()
    @Binding var selectedRecipe: Recipe?
    @Binding var selectedCuisine: Cuisine?
    
    var body: some View {
        List(viewModel.recipes, selection: $selectedRecipe) { recipe in
            NavigationLink(destination: RecipeDetailView(recipe: Binding.constant(recipe))) {
                RecipeRowView(recipe: recipe)
            }
            .listRowBackground(
                Color.clear
                    .ignoresSafeArea()
            )
            .listRowSeparator(.hidden, edges: .bottom)
            .listRowInsets(EdgeInsets.init(top: 0,
                                           leading: 10,
                                           bottom: 0,
                                           trailing: 10))
        }
        .scrollContentBackground(.hidden)
        .environment(\.defaultMinListRowHeight, 90)
        .listStyle(.automatic)
        .navigationTitle("Recipes")
        .onChange(of: selectedCuisine) { cuisine in
            Task {
                try await viewModel.fetchRecipes(for: cuisine)
            }
        }
    }
}
