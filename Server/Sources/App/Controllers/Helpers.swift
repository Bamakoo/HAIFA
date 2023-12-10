import Fluent
import Vapor

extension CuisineController {
    /// Helper function used to ascertain wether a new world cuisine can be added
    /// - Parameters:
    ///   - newCuisine: the proposed new cuisine
    ///   - req: the incoming HTTP POST request
    /// - Returns: a true Boolean if the new cuisine can be added to the DB because it doesn't already exist, false if it can't.
    func canAddNewCuisine(_ newCuisine: String, req: Request) async throws -> Bool {
        let cuisines = try await Cuisine.query(on: req.db).all()
        for cuisine in cuisines where cuisine.country == newCuisine {
                return false
        }
        return true
    }
}

extension Recipe {
    /// The struct used to decode the query filters. 
    struct QueryFilter: Content {
        let random: Bool?
    }
}
