//
//  MenuSelector.swift
//  Client
//
//  Created by Emma GAUBERT on 28/11/2023.
//

import Foundation

/// An enum representing the choices offered to the user in RecipeDetailView: display the list of ingredients or the steps required to make the recipe
enum DetailMenu: String, Identifiable, Hashable, CaseIterable {
    var id: Self { self }

    case ingredients
    case recipe
}
