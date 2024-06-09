//
//  BaseNavigationController.swift
//  TheMovie
//
//  Created by Vu Phong on 24/05/2024.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let barAppearance = UINavigationBarAppearance()
        barAppearance.backgroundColor = UIColor(named: "PrimaryColor")
        navigationBar.standardAppearance = barAppearance
        navigationBar.scrollEdgeAppearance = barAppearance
        navigationBar.compactAppearance = barAppearance
    }
}
