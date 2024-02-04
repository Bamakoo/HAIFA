//
//  RequestBuilder.swift
//  Client
//
//  Created by Emma GAUBERT on 03/02/2024.
//

import Foundation

struct RequestFactory {
    static func build(
        from url: URL,
        with httpMethod: HTTPMethod,
        and body: Data?
    ) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        switch httpMethod {
        case .get, .delete:
            urlRequest.httpMethod = httpMethod.rawValue
        case .post, .patch:
            urlRequest.httpMethod = httpMethod.rawValue
            urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
            urlRequest.httpBody = body
        }
        return urlRequest
    }
}
