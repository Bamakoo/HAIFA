//
//  URLFactory.swift
//  Client
//
//  Created by Emma GAUBERT on 03/02/2024.
//

import Foundation

extension URLComponents {
    func build(
        with path: String,
        and queryItems: [URLQueryItem]?
    ) throws -> URL {
        var instance = self
        instance.scheme = "http"
        instance.host = "127.0.0.1"
        instance.port = 8080
        instance.path = path
        instance.queryItems = queryItems
        if let url = instance.url {
            return url
        } else {
            throw NetworkingError.badURL
        }
    }
}
