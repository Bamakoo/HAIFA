//
//  IngredientsListView.swift
//  Client
//
//  Created by Emma GAUBERT on 29/11/2023.
//

import SwiftUI

struct IngredientsListView: View {
    let ingredients: Array<Ingredient>
    
    var body: some View {
            ForEach(ingredients, id: \.self) { ingredient in
                Text(ingredient.name.capitalized)
                    // TODO: IngredientRowView
            }
    }
}

