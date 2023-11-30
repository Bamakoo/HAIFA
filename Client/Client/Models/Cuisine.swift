//
//  Cuisine.swift
//  Client
//
//  Created by Emma GAUBERT on 17/11/2023.
//

import Foundation
import Combine

typealias Cuisines = [Cuisine]

struct Cuisine: Hashable, Codable, Identifiable {
    let id: UUID?
    let country: String?
}
