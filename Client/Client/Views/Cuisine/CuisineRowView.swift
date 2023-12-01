//
//  CuisineRow.swift
//  Client
//
//  Created by Emma GAUBERT on 23/11/2023.
//

import SwiftUI

struct CuisineRowView: View {
    let cuisine: Cuisine
    var body: some View {
        if let cuisineCountry = cuisine.country {
            Text(cuisineCountry)
                .font(.system(size: 30, weight: .regular, design: .rounded))
        }
    }
}
