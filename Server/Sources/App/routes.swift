import Fluent
import Vapor

func routes(_ app: Application) throws {
    try app.register(collection: CuisineController())
    try app.register(collection: RecipeController())
}
