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
    // TODO: ratings (children)
    // TODO: Number of calories per recipe helping
    // TODO: number of helpings/people fed

    @Enum(key: "recipe_type")
    var recipeType: RecipeType
    
    @Field(key: "difficulty")
    /// the level of difficulty ie how hard the recipe is to make
    var difficulty: Int
    
    /// The estimated number of  minutes it takes to complete the recipe
    @Field(key: "time")
    var time: Int
    
    @Field(key: "ingredients")
    var ingredients: [Ingredient]
    
    @Field(key: "steps")
    var steps: [String : String]
    
    @Parent(key: "cuisine_id")
    var cuisine: Cuisine
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?
    
    @Timestamp(key: "deleted_at", on: .delete)
    var deletedAt: Date?
    
    init() {}
    
    init(id: UUID?,
         title: String,
         description: String,
         recipeType: RecipeType,
         difficulty: Int,
         time: Int,
         ingredients: [Ingredient],
         steps: [String:String],
         cuisineID: Cuisine.IDValue,
         createdAt: Date? = nil,
         updatedAt: Date? = nil,
         deletedAt: Date? = nil) {
        self.id = id
        self.title = title
        self.description = description
        self.time = time
        self.recipeType = recipeType
        self.difficulty = difficulty
        self.ingredients = ingredients
        self.steps = steps
        self.$cuisine.id = cuisineID
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.deletedAt = deletedAt
    }
}
