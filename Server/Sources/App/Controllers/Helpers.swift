import Fluent
import Vapor
import Foundation
// MARK: CuisineController extension: helper functions
extension CuisineController {
    /// Helper function used to ascertain wether a new world cuisine can be added
    /// - Parameters:
    ///   - newCuisine: the proposed new cuisine
    ///   - req: the incoming HTTP POST request
    /// - Returns: a true Boolean if the new cuisine can be added to the DB because it doesn't already exist, false if it can't.
    func canAddNewCuisine(_ newCuisine: String, req: Request) async throws -> Bool {
        let cuisines = try await Cuisine.query(on: req.db).all()
        for cuisine in cuisines where cuisine.country == newCuisine {
            return false
        }
        return true
    }
}

// MARK: extending Recipe class to give it query filters
extension Recipe {
    /// The struct used to decode the query filters.
    struct QueryFilter: Content {
        let random: Bool?
        let recipeID: UUID?
    }
}

// MARK: Ingredient Controller helper functions
extension IngredientController {
    func fetchIngredients(_ recipes: [Recipe], req: Request) async throws -> [String] {
        var ingredients = Array<String>()
        for recipe in recipes {
            for ingredient in recipe.ingredients {
                if ingredients.contains(ingredient.name) {
                    continue
                }
                ingredients.append(ingredient.name)
            }
        }
        return ingredients
    }
    
    /// Allows users to get all the recipes associated with a particular ingredient
    /// - Parameters:
    ///   - ingredients: the array of strings naming the ingredients they have in their fridge
    ///   - req: the incoming HTTP POST request to /ingredients endpoint
    /// - Returns: all the recipes that require the use of at least one of the ingredients
    func fetchRecipesWithMyIngredients(_ ingredients: [String], req: Request) async throws -> [Recipe] {
        let recipes = try await Recipe.query(on: req.db).all()
        var usersRecipes = Array<Recipe>()
        for recipe in recipes {
            for ingredient in recipe.ingredients where ingredients.contains(ingredient.name) {
                usersRecipes.append(recipe)
            }
        }
        return usersRecipes
    }
}


