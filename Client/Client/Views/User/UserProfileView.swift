//
//  UserProfileView.swift
//  Client
//
//  Created by Emma GAUBERT on 25/11/2023.
//

import Foundation
import UIKit
import SwiftUI

struct UserProfileView: UIViewRepresentable {
    typealias UIViewType = ProfileView

    func makeUIView(context: Context) -> ProfileView {
        ProfileView()
    }
    
    func updateUIView(_ uiView: ProfileView, context: Context) {
    }
}


