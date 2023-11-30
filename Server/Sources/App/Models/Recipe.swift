import Fluent
import Vapor

/// A model representing every Recipe stored in the DB
final class Recipe: Model, Content {
    
    static let schema = "recipes"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "title")
    var title: String
    
    @Field(key: "description")
    var description: String
    
    // TODO: Add Users + Auth Models, Controllers and Migrations
    // TODO: Add Comments + Likes Models, Controllers and Migrations
    
    @Enum(key: "recipe_type")
    var recipeType: RecipeType
    
    /// The estimated number of  minutes it takes to complete the recipe
    @Field(key: "time")
    var time: Double

    @Field(key: "ingredients")
    var ingredients: [Ingredient]
    
    @Field(key: "steps")
    var steps: [String : String]
    
    @Parent(key: "cuisine_id")
    var cuisine: Cuisine
    
    // TODO: add createdAt, updatedAt and deletedAt
    
    init() {}
    
    init(id: UUID?,
         title: String,
         description: String,
         recipeType: RecipeType,
         time: Double,
         ingredients: [Ingredient],
         steps: [String:String],
         cuisineID: Cuisine.IDValue) {
        self.id = id
        self.title = title
        self.description = description
        self.time = time
        self.recipeType = recipeType
        self.ingredients = ingredients
        self.steps = steps
        self.$cuisine.id = cuisineID
    }
}
