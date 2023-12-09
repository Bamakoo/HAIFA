import Fluent
import Vapor

/// Data model for World Cuisines, this table stores all the world cuisines
final class Cuisine: Model, Content {
    /// the schema, ie the table's name.
    static let schema = "cuisines"
    
    @ID(key: .id)
    /// a UUID, given by the DB
    var id: UUID?

    @Field(key: "country")
    /// The name of the country who's cuisine we're going to enjoy
    var country: String
    
    // TODO: country description: a description of the country's cuisine
    
    @Children(for: \.$cuisine)
    var recipes: [Recipe]
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?
    
    @Timestamp(key: "deleted_at", on: .delete)
    var deletedAt: Date?
    
    init() { }

    init(id: UUID? = nil,
         country: String,
         createdAt: Date? = nil,
         updatedAt: Date? = nil,
         deletedAt: Date? = nil) {
        self.id = id
        self.country = country
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.deletedAt = deletedAt
    }
}
