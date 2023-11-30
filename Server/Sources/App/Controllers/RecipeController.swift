import Fluent
import Vapor

struct RecipeController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let recipes = routes.grouped("recipes")
        recipes.get(use: index)
        recipes.post(use: create)
        recipes.group(":recipeID") { recipe in
            recipe.get(use: indexRecipe)
            recipe.patch(use: update)
            recipe.delete(use: delete)
        }
    }
    
    func indexRecipe(req: Request) async throws -> Response {
        guard let recipe = try await Recipe.find(req.parameters.get("recipeID"), on: req.db) else {
            throw Abort(.notFound)
        }
        return try await recipe.encodeResponse(status: .ok, for: req)
    }
    
    /// Function called by a /recipes/:recipeID HTTP PATCH network call
    /// - Parameter req: the incoming PATCH request to /recipes/:recipeID
    /// - Returns: A Response object with a HTTP code
    func update(req: Request) async throws -> Response {
        guard let recipe = try await Recipe.find(req.parameters.get("recipeID"), on: req.db) else {
            throw Abort(.notFound)
        }
        
        // TODO: make sure that PATCH funcs work ie unit test it
        // TODO: Users can add a single step or ingredient instead of the full array or dictionary
        
        let patch = try req.content.decode(PatchRecipe.self)
        
        if let title = patch.title {
            recipe.title = title
        }
        
        if let ingredient = patch.ingredient {
            recipe.ingredients.append(ingredient)
        }
        
        if let recipeType = patch.recipeType {
            recipe.recipeType = recipeType
        }
        
        if let time = patch.time {
            recipe.time = time
        }
        
        if let ingredients = patch.ingredients {
            recipe.ingredients = ingredients
        }
        
        if let steps = patch.steps {
            recipe.steps = steps
        }

        if let cuisine = patch.cuisine {
            recipe.$cuisine.id = cuisine
        }
        
        try await recipe.save(on: req.db)
        return .init(status: .noContent)
    }

    func index(req: Request) async throws -> [Recipe] {
        try await Recipe.query(on: req.db).all()
    }

    func create(req: Request) async throws -> Response {
        let recipe = try req.content.decode(Recipe.self)
        try await recipe.save(on: req.db)
        req.logger.info("A new recipe for \(recipe.title) has been successfully saved to DB")
        return try await recipe.encodeResponse(status: .created, for: req)
    }

    func delete(req: Request) async throws -> Response {
        guard let recipe = try await Recipe.find(req.parameters.get("recipeID"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await recipe.delete(on: req.db)
        return .init(status: .ok)
    }
}
