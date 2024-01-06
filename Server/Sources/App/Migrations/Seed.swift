//
//  Seed.swift
//
//
//  Created by Emma GAUBERT on 21/10/2023.
//

import Foundation
import Fluent

/// A Migration used to Seed the DB with sample data after it's finished running the other migrations
struct Seed: AsyncMigration {

    func prepare(on database: Database) async throws {
        
        // MARK: Mexico
        let mexicanCuisine = Cuisine(country: "Mexico")
        try await mexicanCuisine.create(on: database)
        
        let mexicanRecipe = Recipe(id: nil,
                            title: "Nachos and Guacamole",
                            description: "A delicious and tasty snack but quite unhealthy",
                                   recipeType: .snack, difficulty: 2,
                            time: 12,
                            ingredients: [.init(name: "Avocado", quantity: 3, unit: "NA"),
                                          .init(name: "Nachos", quantity: 500, unit: "grams")],
                            steps: ["step1": "mix the nachos", "step2": "Enjoy"],
                            cuisineID: try mexicanCuisine.requireID())
        try await mexicanRecipe.create(on: database)
                
        // MARK: France
        let frenchCuisine = Cuisine(country: "France")
        try await frenchCuisine.create(on: database)
        
        let frenchRecipe = Recipe(id: nil,
                                  title: "Farmer's Chicken",
                                  description: "A delicious, juicy chicken, served with a generous serving of fries",
                                  recipeType: .lunch,
                                  difficulty: 3,
                                  time: 23,
                                  ingredients: [.init(name: "Chicken", quantity: 1, unit: "NA")],
                                  steps: ["step1": "put the chicken in the oven"],
                                  cuisineID: try frenchCuisine.requireID())
        try await frenchRecipe.create(on: database)
        
        // MARK: United States of America
        let americanCuisine = Cuisine(country: "United States of America")
        try await americanCuisine.create(on: database)
        
        let americanRecipe = Recipe(id: nil,
                                    title: "Hamburger",
                                    description: "Juicy burgers",
                                    recipeType: .dinner,
                                    difficulty: 4,
                                    time: 23,
                                    ingredients: [.init(name: "Paddies", quantity: 2, unit: "NA")],
                                    steps: ["step1": "Cook the meat", "step2": "Enjoy the food"],
                                    cuisineID: try americanCuisine.requireID())
        try await americanRecipe.create(on: database)
        
        // MARK: Thailand
        let thaiCuisine = Cuisine(country: "Thailand")
        try await thaiCuisine.create(on: database)
        
        let thaiRecipe = Recipe(id: nil,
                                title: "Green Curry",
                                description: "A staple of Thai Cooking, delicious green curry with coconut milk",
                                recipeType: .mainCourse,
                                difficulty: 3,
                                time: 23,
                                ingredients: [.init(name: "green peppers", quantity: 12, unit: "NA")],
                                steps: ["step1": "mix the stuff together", "step2": "enjoy!"],
                                cuisineID: try thaiCuisine.requireID())
        try await thaiRecipe.create(on: database)
        
        // MARK: Greece
        let greekCuisine = Cuisine(country: "Greece")
        try await greekCuisine.create(on: database)
        
        let greekRecipe = Recipe(id: nil,
                                 title: "Pita bread",
                                 description: "A traditioal bread and national treasure of greece",
                                 recipeType: .snack,
                                 difficulty: 4,
                                 time: 123,
                                 ingredients: [.init(name: "flour", quantity: 23, unit: "grams")],
                                 steps: ["step1": "mix flour"],
                                 cuisineID: try greekCuisine.requireID())
        try await greekRecipe.create(on: database)
        
        // MARK: India
        let indianCuisine = Cuisine(country: "India")
        try await indianCuisine.create(on: database)
        
        let indianRecipe = Recipe(id: nil,
                                  title: "Chicken Tiki Massala",
                                  description: "My favorite Indian dish, a delicious blend of chicken, rice and curry",
                                  recipeType: .dinner,
                                  difficulty: 4,
                                  time: 234,
                                  ingredients: [.init(name: "chicken", quantity: 1, unit: "NA")],
                                  steps: ["step1": "purchase the chickens"],
                                  cuisineID: try indianCuisine.requireID())
        try await indianRecipe.create(on: database)
        
        // MARK: Japan
        
        let japanaseCuisine = Cuisine(country: "Japan")
        try await japanaseCuisine.create(on: database)
        
        let japaneseRecipe = Recipe(id: nil,
                                    title: "Sushi",
                                    description: "What do you think about when you think about Japanese Cuisine? That's right. Sushi",
                                    recipeType: .mainCourse,
                                    difficulty: 4,
                                    time: 32,
                                    ingredients: [.init(name: "Fish", quantity: 1, unit: "NA")],
                                    steps: ["step1": "Roll it!"],
                                    cuisineID: try japanaseCuisine.requireID())
        try await japaneseRecipe.create(on: database)
        
        // MARK: Spain
        
        let spanishCuisine = Cuisine(country: "Spain")
        try await spanishCuisine.create(on: database)
        
        let spanishRecipe = Recipe(id: nil,
                                   title: "Tortilla",
                                   description: "These aren't tortilla chips! It's a blend of eggs and potatoe cooked together",
                                   recipeType: .lunch,
                                   difficulty: 4,
                                   time: 34,
                                   ingredients: [.init(name: "eggs", quantity: 12, unit: "NA")],
                                   steps: ["step1": "mix the eggs and potatoes together"],
                                   cuisineID: try spanishCuisine.requireID())
        try await spanishRecipe.create(on: database)
        
        // MARK: China
        
        let chineseCuisine = Cuisine(country: "China")
        try await chineseCuisine.create(on: database)
        
        let chineseRecipe = Recipe(id: nil,
                                   title: "Dumplings",
                                   description: "An oldie but a goodie",
                                   recipeType: .mainCourse,
                                   difficulty: 1,
                                   time: 32,
                                   ingredients: [.init(name: "eggs", quantity: 32, unit: "NA")],
                                   steps: ["step1": "eat!"],
                                   cuisineID: try chineseCuisine.requireID())
        try await chineseRecipe.create(on: database)
        
        let italianCuisine = Cuisine(country: "Italia")
        try await italianCuisine.create(on: database)
        
        let italianRecipe = Recipe(id: nil,
                                   title: "pizza",
                                   description: "the ultimate italian food along with pasta",
                                   recipeType: .mainCourse,
                                   difficulty: 3,
                                   time: 32,
                                   ingredients: [.init(name: "flour", quantity: 320, unit: "grams")],
                                   steps: ["step1": "Enjoy!"],
                                   cuisineID: try italianCuisine.requireID())
        try await italianRecipe.create(on: database)
        
    }

    func revert(on database: Database) async throws {
        try await Cuisine.query(on: database).delete()
    }
}

