import Fluent
import Vapor

struct CuisineController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let cuisines = routes.grouped("cuisines")
        cuisines.get(use: index)
        cuisines.post(use: create)
        cuisines.group(":cuisineID") { cuisine in
            cuisine.get("recipes", use: cuisinesRecipes)
            cuisine.patch(use: patch)
            cuisine.delete(use: delete)
        }
    }
    
    func cuisinesRecipes(req: Request) async throws -> [Recipe] {
        guard let cuisine = try await Cuisine.find(req.parameters.get("cuisineID"), on: req.db) else {
            throw Abort(.notFound)
        }
        return try await cuisine.$recipes.get(on: req.db)
    }

    func index(req: Request) async throws -> [Cuisine] {
        try await Cuisine.query(on: req.db).all()
    }
    
    func create(req: Request) async throws -> Response {
        let cuisine = try req.content.decode(Cuisine.self)
        guard try await canAddNewCuisine(cuisine.country, req: req) else {
            req.logger.info("Couldn't add a new Cuisine to DB")
            throw Abort(.notFound)
        }
        try await cuisine.save(on: req.db)
        // TODO: implement Logging on a larger scale
        req.logger.info("\(cuisine.country) has been successfully saved to DB")
        return try await cuisine.encodeResponse(status: .created, for: req)
    }

    func patch(req: Request) async throws -> Response {
        let patch = try req.content.decode(PatchCuisine.self)
        req.logger.info("Implementing PATCH Request on cuisine. Received \(patch)")
        guard let cuisine = try await Cuisine.find(req.parameters.get("cuisineID"), on: req.db) else {
            req.logger.info("HTTP PATCH failed, unable to find the cuisine in the DB")
            throw Abort(.notFound)
        }
        
        if let country = patch.country {
            cuisine.country = country
            req.logger.info("PATCHED cuisine.country. New value => \(country)")
        }

        try await cuisine.save(on: req.db)
        req.logger.info("PATCH successful!")
        return .init(status: .noContent)
    }
    
    func delete(req: Request) async throws -> Response {
        guard let cuisine = try await Cuisine.find(req.parameters.get("cuisineID"), on: req.db) else {
            req.logger.info("HTTP DELETE failed: unable to locate Cuisine")
            throw Abort(.notFound)
        }
        try await cuisine.delete(on: req.db)
        return .init(status: .ok)
    }
}
