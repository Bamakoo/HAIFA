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
        }
        .listStyle(.automatic)
        .navigationTitle("Recipes")
        .onChange(of: selectedCuisine) { cuisine in
            do {
                try viewModel.fetchRecipes(for: cuisine)
            } catch {
                print(error)
            }
        }
    }
}
