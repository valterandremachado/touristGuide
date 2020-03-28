//
//  AboutVC.swift
//  GuideTech
//
//  Created by Valter A. Machado on 3/25/20.
//  Copyright © 2020 Valter A. Machado. All rights reserved.
//

import UIKit

class AboutVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .rgb(red: 101, green: 183, blue: 180)
        view.backgroundColor = .green
        
        if preferredLanguage == "ar" {
            navigationItem.title = "About".localized("ar")
        } else {
            navigationItem.title = "About"
        }
        
    }
}
