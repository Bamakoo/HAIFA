//
//  Errors.swift
//  Client
//
//  Created by Emma GAUBERT on 21/11/2023.
//

import Foundation

// MARK: Networking Error
enum NetworkingError: Error {
    case badURL
}

// MARK: Unwrapping Error
enum UnwrappingError: Error {
    case failed
}
