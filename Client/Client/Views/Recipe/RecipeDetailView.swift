//
//  RecipeDetail.swift
//  Client
//
//  Created by Emma GAUBERT on 21/11/2023.
//

import SwiftUI

/// A detailed view of the Recipe selected by the user
struct RecipeDetailView: View {
    @Binding var recipe: Recipe?
    @State private var selectedDetailMenu: DetailMenu = .ingredients
    
    var body: some View {
        
        // TODO: Design this view properly, exquisite look and feel
        // TODO: ask Vapor Core Team about deployments
        // TODO: ask Vapor Core Team about storing Images/photos
        
        if let recipe = recipe {
            // ScrollView inside of it:
            ScrollView {
                // TODO: Real photo of the recipe stored in the DB
                // TODO: display picture with AsyncImage
                // MARK: Photo of the recipe
                Image(systemName: "heart")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                
                Spacer(minLength: 35)
                
                // MARK: HStack
                HStack {
                    Spacer(minLength: 2)
                    // MARK: The recipe's title
                    Text(recipe.title)
                        .font(.system(size: 36, weight: .bold, design: .rounded))
                    Spacer(minLength: 15)
                    // MARK: VStack
                    VStack(spacing: 3) {
                        // clock "emoji" + how long it takes to complete the recipe
                        Image(systemName: "clock")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                        Text(String(recipe.time))
                            .font(.system(size: 20, weight: .semibold, design: .rounded))
                    }
                    Spacer(minLength: 15)
                }
                Spacer(minLength: 15)
                // recipe description
                Text(recipe.description)
                    .font(.subheadline)
                    .font(.system(size: 20, weight: .light, design: .rounded))

                Spacer(minLength: 15)
                
                // MARK: Picker
                Picker(String(), selection: $selectedDetailMenu) {
                    ForEach(DetailMenu.allCases) { detailedMenu in
                        Text(detailedMenu.rawValue.capitalized)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.leading, 20)
                .padding(.trailing, 20)

                Spacer(minLength: 15)

                if selectedDetailMenu == .recipe {
                    RecipeStepsListView(steps: recipe.steps)
                } else if selectedDetailMenu == .ingredients {
                    IngredientsListView(ingredients: recipe.ingredients)
                }
            }
        }
    }
}
