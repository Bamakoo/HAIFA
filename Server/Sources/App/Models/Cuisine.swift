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
    
    @Children(for: \.$cuisine)
    var recipes: [Recipe]
    
    // TODO: add createdAt, updatedAt and deletedAt 

    init() { }

    init(id: UUID? = nil, country: String) {
        self.id = id
        self.country = country
    }
}
