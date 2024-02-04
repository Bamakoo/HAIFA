//
//  CuisineSidebar.swift
//  Client
//
//  Created by Emma GAUBERT on 21/11/2023.
//

import SwiftUI

/// A list of world cuisines to choose from, clicking on a particular country will lead you to the countries list of available recipes
struct CuisineListView: View {

    @StateObject private var viewModel = CuisineViewModel()
    @Binding var selectedCuisine: Cuisine?

    var body: some View {
        List(viewModel.cuisines, selection: $selectedCuisine) { cuisine in
            NavigationLink(value: cuisine) {
                CuisineRowView(cuisine: cuisine)
            }
            .listRowBackground(
                Color.clear
                    .ignoresSafeArea()
            )
            .listRowSeparator(
                .hidden,
                edges: .bottom
            )
            .listRowInsets(
                EdgeInsets.init(
                    top: 0,
                    leading: 10,
                    bottom: 0,
                    trailing: 10
                )
            )
        }
        .scrollContentBackground(.hidden)
        .environment(\.defaultMinListRowHeight, 90)
        .navigationTitle("World Cuisines")
        .task {
            do {
                try await viewModel.fetchCuisines()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}


