//
//  HTTP.swift
//  Client
//
//  Created by Emma GAUBERT on 03/02/2024.
//

import Foundation
import Combine

enum APIError: Error {
    case invalidResponse
}

struct HTTP {
    static func execute (
        request: URLRequest,
        with session: URLSession = .shared
    ) -> some Publisher<(Data, URLResponse), Error> {
        return session.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .tryMap { data, response -> (Data, URLResponse) in
                return (data, response)
            }
            .eraseToAnyPublisher()
    }
    
    static func dataHandler<T: Decodable>(_ data: Data?) throws -> T {
        let decoder = JSONDecoder()
        let decodedT = try decoder.decode(T.self, from: data ?? Data())
        return decodedT
    }
    
    static func responseHandler(_ response: HTTPURLResponse) {
        print(response)
    }
}


