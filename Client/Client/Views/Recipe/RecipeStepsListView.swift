//
//  RecipeStepsListView.swift
//  Client
//
//  Created by Emma GAUBERT on 29/11/2023.
//

import SwiftUI

struct RecipeStepsListView: View {
    
    let steps: Dictionary<String, String>
    
    var body: some View {
        Text(steps["step1"]?.capitalized ?? String())
        Text(steps["step2"]?.capitalized ?? String())
        Text(steps["step3"]?.capitalized ?? String())
    }
}

struct RecipeStepsListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeStepsListView(steps: Dictionary<String, String>())
    }
}



