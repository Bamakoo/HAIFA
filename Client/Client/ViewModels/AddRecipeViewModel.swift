//
//  AddRecipeViewModel.swift
//  Client
//
//  Created by Emma GAUBERT on 02/12/2023.
//

import Foundation
import Combine

final class AddRecipeViewModel: ObservableObject {
    
    @Published var recipeTitle = String()
    @Published var recipeDescription = String()
    // TODO: time w/ INT
    // TODO: add a level of difficulty for the recipe
    @Published var time: Double = 0.1
    @Published var cuisines = [Cuisine]()
    // TODO: fix selectedCuisine
    @Published var selectedCuisine = Cuisine(id: nil,
                                             country: "Peru")
    @Published var stepOne = String()
    @Published var stepTwo = String()
    @Published var stepThree = String()
    @Published var stepFour = String()
    @Published var stepFive = String()
    @Published var selectedRecipeType: RecipeType = .mainCourse
    @Published var ingredientOneName = String()
    @Published var ingredientOneQuantity: Double = 1.0
    @Published var ingredientOneUnit = String()
    
    var storage = Set<AnyCancellable>()

    func fetchCuisines() async throws {
        
        try await UseCase.Cuisine.fetchCuisines()
            .receive(on: DispatchQueue.main)
            .replaceError(with: [])
            .assign(to: &$cuisines)
    }
    
    func createRecipe() async throws {
        let recipe: Recipe = .init(id: nil,
                                   title: recipeTitle,
                                   description: recipeDescription,
                                   recipeType: selectedRecipeType,
                                   time: time,
                                   ingredients: [.init(name: ingredientOneName, quantity: ingredientOneQuantity, unit: ingredientOneUnit)],
                                   steps: ["step1": stepOne,
                                           "step2": stepTwo,
                                           "step3": stepThree,
                                           "step4": stepFour,
                                           "step5": stepFive],
                                   cuisine: selectedCuisine)
        guard let url = URL(string: "http://127.0.0.1:8080/recipes") else {
            throw NetworkingError.badURL
        }
        
        guard !recipe.title.isEmpty else { return }
        // TODO: add validation logic to make sure that the recipe object isn't empty
        // TODO: all steps + more ingredients in Recipe object
        let encoder = JSONEncoder()
        let requestBody = try encoder.encode(recipe)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = requestBody
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        // TODO: API Layer + URLComponents and function to execute network requests with URLRequest as param like in HERZLIYA
        URLSession.shared.dataTaskPublisher(for: request)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    ()
                case .failure(let error):
                    print("Failed to Send POST Request \(error.localizedDescription)")
                }
            }, receiveValue: { _, response in
                let statusCode = (response as! HTTPURLResponse).statusCode

                if statusCode == 200 || statusCode == 201 {
                    print("SUCCESS")
                } else {
                    print("FAILURE")
                }
            })
                .store(in:&self.storage)
    }
}
