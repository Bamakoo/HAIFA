import Fluent

struct CreateCuisine: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("cuisines")
            .id()
            .field("country", .string, .required)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("cuisines").delete()
    }
}
