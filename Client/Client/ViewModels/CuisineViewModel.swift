//
//  CuisineListViewModel.swift
//  Client
//
//  Created by Emma GAUBERT on 17/11/2023.
//

import Foundation
import Combine

final class CuisineViewModel: ObservableObject {
    @Published var cuisines = [Cuisine]()
        
    func fetchCuisines() async throws {

        try await UseCase.Cuisine.fetchCuisines()
            .receive(on: DispatchQueue.main)
            .replaceError(with: [])
            .assign(to: &$cuisines)
    }
}
