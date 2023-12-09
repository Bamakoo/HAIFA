//
//  PatchRecipe.swift
//  
//
//  Created by Emma GAUBERT on 24/11/2023.
//

import Foundation

struct PatchRecipe: Codable {
    let title: String?
    let recipeType: RecipeType?
    let time: Int?
    /// Used to add an ingredient to the list
    let ingredient: Ingredient?
    /// Used to send a new list of ingredients
    let ingredients: [Ingredient]?
    // TODO: find out what a single step would look like
    let steps: Dictionary<String, String>?
    let cuisine: UUID?
}
