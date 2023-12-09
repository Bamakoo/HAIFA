//
//  Recipe.swift
//  Client
//
//  Created by Emma GAUBERT on 17/11/2023.
//

import Foundation

typealias Recipes = [Recipe]

struct Recipe: Hashable, Codable, Identifiable {
    let id: UUID?
    let title: String
    let description: String
    let recipeType: RecipeType
    let time: Int
    let difficulty: Int
    let ingredients: [Ingredient]
    let steps: [String: String]
    let cuisine: Cuisine
}
