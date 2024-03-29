import Fluent
import Vapor

// TODO: Ingredients Table
// TODO: touch Readme.MD
// TODO: revamp' LI profile

struct RecipeController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let recipes = routes.grouped("recipes")
        recipes.get(use: index)
        recipes.post(use: create)
        recipes.group(":recipeID") { recipe in
            recipe.patch(use: update)
            recipe.delete(use: delete)
        }
    }
    
    /// Function called by a /recipes/:recipeID HTTP PATCH network call
    /// - Parameter req: the incoming PATCH request to /recipes/:recipeID
    /// - Returns: A Response object with a HTTP code
    func update(req: Request) async throws -> Response {
        guard let recipe = try await Recipe.find(req.parameters.get("recipeID"), on: req.db) else {
            req.logger.info("Failed to fetche Recipe from DB")
            throw Abort(.notFound)
        }
        req.logger.info("Fetched \(recipe) from DB")
        
        let patch = try req.content.decode(PatchRecipe.self)
        req.logger.info("Decoded \(patch) from request")
        
        if let title = patch.title {
            recipe.title = title
            req.logger.info("New title \(title) for recipe: \(recipe)")
        }
        
        if let ingredient = patch.ingredient {
            recipe.ingredients.append(ingredient)
            req.logger.info("New ingredient \(ingredient) for recipe: \(recipe)")
        }
        
        if let recipeType = patch.recipeType {
            recipe.recipeType = recipeType
            req.logger.info("New recipeType \(recipeType) for recipe: \(recipe)")
        }
        
        if let time = patch.time {
            recipe.time = time
            req.logger.info("New time \(time) for recipe: \(recipe)")
        }
        
        if let ingredients = patch.ingredients {
            recipe.ingredients = ingredients
            req.logger.info("New set of ingredients \(ingredients) for recipe: \(recipe)")
        }
        
        if let steps = patch.steps {
            recipe.steps = steps
            req.logger.info("New set of steps \(steps) for recipe: \(recipe)")
        }
        
        if let cuisine = patch.cuisine {
            recipe.$cuisine.id = cuisine
            req.logger.info("New UUID \(cuisine) for recipe: \(recipe)")
        }
        
        try await recipe.save(on: req.db)
        return .init(status: .noContent)
    }
    
    func index(req: Request) async throws -> Response {
        let queryItems = try req.query.decode(Recipe.QueryFilter.self)
        // MARK: When called, returns a single, random recipe
        if let random = queryItems.random,
           random == true {
            let recipes = try await Recipe.query(on: req.db).all()
            req.logger.info("Successfully fetch all the recipes")
            guard let recipe = recipes.randomElement() else {
                req.logger.info("Unable to get a random recipe")
                throw Abort(.notFound)
            }
            return try await recipe.encodeResponse(status: .ok, for: req)
        }
        // MARK: returns a specific recipe
        if let recipeID = queryItems.recipeID,
            let recipe = try await Recipe.find(recipeID, on: req.db) {
            req.logger.info("successfully fetched Recipe from DB")
            return try await recipe.encodeResponse(status: .ok, for: req)
        }
        // MARK: no query items, return all the recipes in the DB
        let recipes = try await Recipe.query(on: req.db).all()
        return try await recipes.encodeResponse(status: .ok, for: req)
    }
    
    func create(req: Request) async throws -> Response {
        let recipe = try req.content.decode(Recipe.self)
        try await recipe.save(on: req.db)
        req.logger.info("A new recipe : \(recipe.title) has been successfully saved to DB")
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
