//
//  Search.swift
//  Client
//
//  Created by Emma GAUBERT on 26/11/2023.
//

import SwiftUI
// TODO: users can input a list of ingredients and get back a list of recipes that they can make with those ingredients
struct SearchView: View {
    
    let layout = [
        GridItem(.adaptive(minimum: 80)),
        GridItem(.adaptive(minimum: 80)),
        GridItem(.adaptive(minimum: 80)),
        GridItem(.adaptive(minimum: 80)),
    ]
    
    @StateObject private var viewModel = SearchViewModel()
    @State private var showingSheet = false
    
    var body: some View {
        ScrollView {
            //            Grid(alignment: .bottom, horizontalSpacing: 1, verticalSpacing: 1) {
            //                GridRow {
            //                    ForEach(viewModel.ingredients[0...3], id: \.self) { ingredient in
            //                        Text(ingredient)
            //                    }
            //                }
            //            }
            LazyVGrid(columns: layout) {
                ForEach(viewModel.ingredients, id: \.self) { ingredient in
                    Button {
                        viewModel.myIngredients.append(ingredient.capitalized)
                    } label: {
                        Capsule()
                            .overlay(Text(ingredient.capitalized)
                                .foregroundColor(.white))
                            .foregroundColor(viewModel.myIngredients.contains(ingredient.capitalized) ? .red : .blue)
                            .frame(height: 80)
                    }
                }
            }
            TextField("Add Ingredient", text: $viewModel.newIngredient, prompt: Text("Add Ingredient"))
            Button {
                viewModel.ingredients.append(viewModel.newIngredient)
                viewModel.myIngredients.append(viewModel.newIngredient)
                viewModel.newIngredient = String()
            } label: {
                Text("Add new Ingredient")
            }
            Button {
                Task {
                    showingSheet.toggle()
                    try await viewModel.fetchRandomRecipe()
                }
            } label: {
                Text("Discover a random recipe!")
            }
        }
        .task {
            do {
                try await viewModel.fetchIngredients()
            } catch {
                print(error.localizedDescription)
            }
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
