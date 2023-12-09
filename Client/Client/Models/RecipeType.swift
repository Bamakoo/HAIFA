//
//  RecipeType.swift
//
//
//  Created by Emma GAUBERT on 22/11/2023.
//

import Foundation

enum RecipeType : String, Identifiable, Codable, CaseIterable {
    var id: Self { self }
    case dessert
    case snack
    case lunch
    case dinner
    case starter
    case mainCourse
}
