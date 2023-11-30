//
//  RecipeRow.swift
//  Client
//
//  Created by Emma GAUBERT on 23/11/2023.
//

import SwiftUI

/// What every recipe row looks like
struct RecipeRowView: View {
    let recipe: Recipe
    var body: some View {
        // TODO: Design the recipe row
        Text(recipe.title)
    }
}
