import Fluent

struct CreateRecipe: AsyncMigration {
    func prepare(on database: Database) async throws {
        
        let recipeType = try await database.enum("recipe_type").read()

        try await database.schema("recipes")
            .id()
            .field("title", .string, .required)
            .field("description", .string, .required)
            .field("recipe_type", recipeType, .required)
            .field("time", .double, .required)
            // TODO: Once fix is pushed to production used custom Array
            .field("ingredients", .sql(raw: "JSONB[]"), .required)
            .field("steps", .dictionary, .required)
            .field("cuisine_id", .uuid, .required, .references("cuisines", "id"))
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("recipes").delete()
    }
}
