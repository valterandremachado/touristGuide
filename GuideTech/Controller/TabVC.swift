//
//  TabVC.swift
//  GuideTech
//
//  Created by Valter A. Machado on 3/15/20.
//  Copyright © 2020 Valter A. Machado. All rights reserved.
//

import UIKit

class TabVC: UITabBarController {
    
    let homeVC = HomeVC()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupVCs()
    }
    
    fileprivate func setupVCs(){
//        tabBar.barTintColor =  UIColor.rgb(red: 22, green: 23, blue: 27)
        tabBar.tintColor = .rgb(red: 101, green: 183, blue: 180)
        
        viewControllers = [createControllers(title: "", imageName: "house.fill", vc: homeVC)]
    }
    fileprivate func createControllers(title: String, imageName: String, vc: UIViewController) -> UINavigationController{
        let recentVC = UINavigationController(rootViewController: vc)
        recentVC.tabBarItem.title = title
        recentVC.tabBarItem.image = UIImage(systemName: imageName)
        return recentVC
    }
}
