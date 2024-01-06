//
//  UserProfileView.swift
//  Client
//
//  Created by Emma GAUBERT on 25/11/2023.
//

import Foundation
import UIKit
import SwiftUI

struct UserProfileView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        ProfileViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
    
    typealias UIViewControllerType = UIViewController

}


