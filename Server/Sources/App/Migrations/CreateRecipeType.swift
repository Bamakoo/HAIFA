import Fluent

struct CreateRecipeType: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.enum("recipe_type")
            .case("dessert")
            .case("snack")
            .case("lunch")
            .case("dinner")
            .case("starter")
            .case("mainCourse")
            .case("breakfast")
            .create()
    }
    func revert(on database: Database) async throws {
        try await database.enum("recipe_type").delete()
    }
}
