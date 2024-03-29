//
//  AddRecipe.swift
//  Client
//
//  Created by Emma GAUBERT on 26/11/2023.
//

import SwiftUI

struct AddRecipeView: View {
    
    @StateObject private var viewModel = AddRecipeViewModel()
    
    var body: some View {
        Form {
            Section {
                TextField("Recipe's Title",
                          text: $viewModel.recipeTitle,
                          prompt: Text("Enter the recipe's title"))
                TextField("Description",
                          text: $viewModel.recipeDescription,
                          axis: .vertical)
                .textFieldStyle(.roundedBorder)
            } header: {
                Text("The recipe's title and description")
            } footer: {
                Text("Make these as descriptive as possible so people can find your recipes")
            }
            Stepper(
                value: $viewModel.recipeDifficulty,
                in: 1...10,
                step: 1
            ) {
                Text("\(viewModel.recipeDifficulty)/10 level of difficulty")
            }
            Stepper(
                value: $viewModel.time,
                in: 1...500,
                step: 1
            ) {
                Text("\(viewModel.time) minutes to complete the recipe")
            }
            Section {
                TextField("Step 1",
                          text: $viewModel.stepOne,
                          axis: .vertical)
                .textFieldStyle(.roundedBorder)
                TextField("Step 2",
                          text: $viewModel.stepTwo,
                          axis: .vertical)
                .textFieldStyle(.roundedBorder)
                TextField("Step 3",
                          text: $viewModel.stepThree,
                          axis: .vertical)
                .textFieldStyle(.roundedBorder)
                TextField("Step 4",
                          text: $viewModel.stepFour,
                          axis: .vertical)
                .textFieldStyle(.roundedBorder)
                TextField("Step 5",
                          text: $viewModel.stepFive,
                          axis: .vertical)
                .textFieldStyle(.roundedBorder)
            }
            Picker("World Cuisine", selection: $viewModel.selectedCuisine) {
                ForEach(viewModel.cuisines, id: \.self) { cuisine in
                    if let worldCuisine = cuisine.country {
                        Text(worldCuisine)
                    }
                }
            }
            Picker("Course", selection: $viewModel.selectedRecipeType) {
                ForEach(RecipeType.allCases) { recipeType in
                    Text(recipeType.rawValue.capitalized)
                }
            }
            Section {
                TextField("First Ingredient's name",
                          text: $viewModel.ingredientOneName,
                          prompt: Text("Enter the first ingredients name"))
                Stepper(
                    value: $viewModel.ingredientOneQuantity,
                    in: 1...500,
                    step: 1
                ) {
                    Text("\(viewModel.ingredientOneQuantity) of \(viewModel.ingredientOneName)")
                }
                TextField("First Ingredient's measuring unit (ex: grams)",
                          text: $viewModel.ingredientOneUnit,
                          prompt: Text("First Ingredient's measuring unit (ex: grams)"))
            }
            Section {
                TextField("Second Ingredient's name",
                          text: $viewModel.ingredientTwoName,
                          prompt: Text("Enter the second ingredients name"))
                Stepper(
                    value: $viewModel.ingredientTwoQuantity,
                    in: 1...500,
                    step: 1
                ) {
                    Text("\(viewModel.ingredientTwoQuantity) of \(viewModel.ingredientTwoName)")
                }
                TextField("First Ingredient's measuring unit (ex: grams)",
                          text: $viewModel.ingredientTwoUnit,
                          prompt: Text("First Ingredient's measuring unit (ex: grams)"))
            }
            Button {
                Task {
                    try await viewModel.createRecipe()
                }
            } label: {
                Text("Submit recipe!")
            }
        }
        // TODO: REFACTOR remove do catch logic from views
        .task {
            do {
                try await viewModel.fetchCuisines()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

struct AddRecipe_Previews: PreviewProvider {
    static var previews: some View {
        AddRecipeView()
    }
}
