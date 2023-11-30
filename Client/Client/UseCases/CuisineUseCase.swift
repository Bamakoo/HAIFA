//
//  CuisineUseCase.swift
//  Client
//
//  Created by Emma GAUBERT on 25/11/2023.
//

import Foundation
import Combine

extension UseCase {
    struct Cuisine {
        static func fetchCuisines() throws -> some Publisher<Cuisines, Error> {
            
            guard let url = URL(string: "http://127.0.0.1:8080/cuisines") else {
                throw NetworkingError.badURL
            }
            
            let decoder = JSONDecoder()
            return URLSession
                .shared
                .dataTaskPublisher(for: url)
                .map(\.data)
                .decode(type: Cuisines.self, decoder: decoder)
                .eraseToAnyPublisher()
        }
    }
}
