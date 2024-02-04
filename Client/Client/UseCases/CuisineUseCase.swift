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
            let urlComponents = URLComponents()
            let url = try urlComponents.build(
                with: "/cuisines",
                and: nil
            )
            let urlRequest = RequestFactory.build(
                from: url,
                with: .get,
                and: nil
            )
            return URLSession
                .shared
                .dataTaskPublisher(for: urlRequest)
                .map(\.data)
                .decode(type: Cuisines.self, decoder: JSONDecoder())
                .eraseToAnyPublisher()
        }
    }
}
