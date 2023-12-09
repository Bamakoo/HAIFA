//
//  RecipeViewModel.swift
//  Client
//
//  Created by Emma GAUBERT on 21/11/2023.
//

import Foundation
import Combine

final class RecipeViewModel: ObservableObject {
    @Published var recipes = [Recipe]()

    // TODO: a real Combine Architecture is implemented
    // TODO: leverage URL Components
    func fetchRecipes(for cuisine : Cuisine?) async throws {
        guard let cuisine = cuisine,
              let cuisineID = cuisine.id else {
           throw UnwrappingError.failed
        }
        
        guard let url = URL(string: "http://127.0.0.1:8080/cuisines/\(cuisineID)/recipes") else {
            throw NetworkingError.badURL
        }
        
        try await UseCase.CuisineRecipe.fetchRecipes(for: url)
            .receive(on: DispatchQueue.main)
            .replaceError(with: [])
            .assign(to: &$recipes)
    }
}
