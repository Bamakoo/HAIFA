//
//  CuisineList.swift
//  Client
//
//  Created by Emma GAUBERT on 10/11/2023.
//

import SwiftUI

/// The NavigationSplitView powering the three different views, the first one for the list of available world cuisines, the second one for the list of recipes from the selected country, the third for the detailed view of the selected recipe.
struct WorldCuisineMenuView: View {
    // MARK: Selected cuisine and recipe passed as bindings to the three child views.
    @State private var selectedCuisine: Cuisine?
    @State private var selectedRecipe: Recipe?
    
    var body: some View {
        NavigationSplitView {
            CuisineListView(selectedCuisine: $selectedCuisine)
        } content: {
            RecipeListView(selectedRecipe: $selectedRecipe, selectedCuisine: $selectedCuisine)
        } detail: {
            RecipeDetailView(recipe: $selectedRecipe)
        } // TODO: see if it's possible to remove detail without breaking everything
    }
}

struct CuisineList_Previews: PreviewProvider {
    static var previews: some View {
        WorldCuisineMenuView()
    }
}
