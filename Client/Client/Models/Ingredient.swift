//
//  Ingredient.swift
//  Server
//
//  Created by Emma GAUBERT on 22/11/2023.
//

import Foundation

/// A Codable Struct to represent a single Ingredient in a recipe
struct Ingredient: Codable, Hashable {
    /// the ingredient's name
    let name: String
    /// The amount or quantity of the ingredient that is required for the recipe
    let quantity: Double
    /// The unit used to measure the amount of the ingredient needed for the recipe
    let unit: String
}
