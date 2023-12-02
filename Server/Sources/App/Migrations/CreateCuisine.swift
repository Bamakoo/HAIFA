import Fluent

struct CreateCuisine: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("cuisines")
            .id()
            .field("country", .string, .required)
            .field("created_at", .date)
            .field("updated_at", .date)
            .field("deleted_at", .date)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("cuisines").delete()
    }
}
