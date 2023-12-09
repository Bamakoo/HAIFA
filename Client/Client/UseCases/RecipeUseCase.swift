//
//  RecipeUseCase.swift
//  Client
//
//  Created by Emma GAUBERT on 25/11/2023.
//

import Foundation
import Combine

// TODO: Implement a proper Combine architecture  

extension UseCase {
    struct CuisineRecipe {
        static func fetchRecipes(for url: URL) async throws -> some Publisher<Recipes, Error> {
            let decoder = JSONDecoder()
            return URLSession
                .shared
                .dataTaskPublisher(for: url)
                .map(\.data)
                .decode(type: Recipes.self, decoder: decoder)
                .eraseToAnyPublisher()
        }
    }
}
