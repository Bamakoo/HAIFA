//
//  IngredientsUseCase.swift
//  Client
//
//  Created by Emma GAUBERT on 11/12/2023.
//

import Foundation
import Combine

extension UseCase {
    struct Ingredient {
        static func fetchIngredients(for url: URL) async throws -> some Publisher<[String], Error> {
            return URLSession
                .shared
                .dataTaskPublisher(for: url)
                .map(\.data)
                .decode(type: [String].self, decoder: JSONDecoder())
                .eraseToAnyPublisher()
        }
    }
}
