//
//  SearchViewModel.swift
//  Client
//
//  Created by Emma GAUBERT on 09/12/2023.
//

import Foundation

final class SearchViewModel: ObservableObject {
    @Published var randomRecipe = Recipe(id: nil,
                                         title: "",
                                         description: "",
                                         recipeType: .mainCourse,
                                         time: 23,
                                         difficulty: 2, ingredients: [.init(name: "", quantity: 23, unit: "")],
                                         steps: ["step1": "eat food"], cuisine: Cuisine(id: nil, country: "Ethiopia"))
    
    let anotherRandomRecipe = Recipe(id: nil,
                                     title: "",
                                     description: "",
                                     recipeType: .mainCourse,
                                     time: 23,
                                     difficulty: 2, ingredients: [.init(name: "", quantity: 23, unit: "")],
                                     steps: ["step1": "eat food"], cuisine: Cuisine(id: nil, country: "Ethiopia"))
    
    func fetchRandomRecipe() async throws {
        do {
            guard let url = URL(string: "http://127.0.0.1:8080/recipes/random") else {
                throw NetworkingError.badURL
            }
            // TODO: better error handling
            try await UseCase.CuisineRecipe.fetchRecipe(for: url)
                .receive(on: DispatchQueue.main)
                .replaceError(with: anotherRandomRecipe)
                .assign(to: &$randomRecipe)
        } catch {
            print(error.localizedDescription)
        }
    }
}
