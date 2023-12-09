import Fluent

struct CreateRecipe: AsyncMigration {
    func prepare(on database: Database) async throws {
        
        let recipeType = try await database.enum("recipe_type").read()

        try await database.schema("recipes")
            .id()
            .field("title", .string, .required)
            .field("description", .string, .required)
            .field("recipe_type", recipeType, .required)
            .field("difficulty", .int, .required)
            .field("time", .int, .required)
            // TODO: Once fix is pushed to production used custom Array ie => .array(of: .custom(Ingredient.self))
            .field("ingredients", .sql(raw: "JSONB[]"), .required)
            .field("steps", .dictionary, .required)
            .field("cuisine_id", .uuid, .required, .references("cuisines", "id"))
            .field("created_at", .date)
            .field("updated_at", .date)
            .field("deleted_at", .date)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("recipes").delete()
    }
}
