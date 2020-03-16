//
//  SettingsVC.swift
//  GuideTech
//
//  Created by Valter A. Machado on 3/16/20.
//  Copyright © 2020 Valter A. Machado. All rights reserved.
//

import UIKit
import LBTATools

class SettingsVC: UIViewController {
    
    // MARK: - Properties
    lazy var cancelBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
//        btn.setTitle("Cancel", for: .normal)
        //        let largeConfig = UIImage.SymbolConfiguration(textStyle: .largeTitle)
        //        btn.setPreferredSymbolConfiguration(largeConfig, forImageIn: .normal)
        btn.setImage(UIImage(systemName: "multiply.circle.fill"), for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 20)
        //        btn.tintColor = UIColor.rgb(red: 253, green: 39, blue: 93)
        btn.tintColor = .rgb(red: 101, green: 183, blue: 180)
        btn.addTarget(self, action: #selector(cancelBtnPressed), for: .touchUpInside)
        return btn
    }()
    
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        //        backButton.title = "Back"
        //        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        setupView()
    }
    
    // MARK: - Handlers (functions/methods)
    @objc func cancelBtnPressed(){
        dismiss(animated: true, completion: nil)
    }
    
    func setupView(){
//        [cancelBtn].forEach({view.addSubview($0)})
        let cancelBtnItem = UIBarButtonItem(customView: cancelBtn)
        navigationItem.leftBarButtonItem =  cancelBtnItem
        navigationItem.title = "Settings"

//        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        navigationController?.navigationBar.hideNavBarSeperator()
    }
}
