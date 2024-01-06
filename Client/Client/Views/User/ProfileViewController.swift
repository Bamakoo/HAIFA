//
//  ProfileView.swift
//  Client
//
//  Created by Emma GAUBERT on 28/11/2023.
//

import UIKit

class ProfileViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        
        let label = UILabel()
        label.text = "The answer is 42"
        label.textColor = .yellow
        
        self.view.addSubview(label)
        label.frame = self.view.frame
    }
}
