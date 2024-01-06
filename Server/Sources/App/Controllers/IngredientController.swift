import Fluent
import Vapor

struct IngredientController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let ingredients = routes.grouped("ingredients")
        ingredients.get(use: index)
        ingredients.post(use: recipesWithMyIngredients)
    }
    
    /// Returns an array of Ingredients as a Response object
    /// - Parameter req: the incoming HTTP GET request to /ingredients
    /// - Returns: a Response object containing all the Ingredients
    func index(req: Request) async throws -> Response {
        req.logger.info("Fetching all the Ingredients")
        let recipes = try await Recipe.query(on: req.db).all()
        let ingredients = try await fetchIngredients(recipes, req: req)
        return try await ingredients.encodeResponse(status: .ok, for: req)
    }
    
    /// Allows users to send an array of ingredients and get an array of Recipes in response
    /// - Parameter req: the incoming HTTP POST request with a body of Ingredient objects
    /// - Returns: A Response object
    func recipesWithMyIngredients(req: Request) async throws -> Response {
        // TODO: sanitize payload with validation + .capitalized String
        let ingredients = try req.content.decode([String].self)
        req.logger.info("Received \(ingredients) from the client")
        let recipes = try await fetchRecipesWithMyIngredients(ingredients, req: req)
        return try await recipes.encodeResponse(status: .ok, for: req)
    }
}

// TODO: Combine Architecture
// TODO: Pictures/Camera
