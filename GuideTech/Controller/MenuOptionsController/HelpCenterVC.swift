
//
//  HelpCenterVC.swift
//  GuideTech
//
//  Created by Valter A. Machado on 3/16/20.
//  Copyright © 2020 Valter A. Machado. All rights reserved.
//

import UIKit
import LBTATools

class HelpCenterVC: UIViewController {
    
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
    
    lazy var sendFeedbackBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Send Email", for: .normal)
        //        let largeConfig = UIImage.SymbolConfiguration(textStyle: .largeTitle)
        //        btn.setPreferredSymbolConfiguration(largeConfig, forImageIn: .normal)
//        btn.setImage(UIImage(systemName: "multiply.circle.fill"), for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 20)
        //        btn.tintColor = UIColor.rgb(red: 253, green: 39, blue: 93)
        btn.backgroundColor = .rgb(red: 101, green: 183, blue: 180)
        btn.addTarget(self, action: #selector(sendFeedbackBtnPressed), for: .touchUpInside)
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
    
    @objc func sendFeedbackBtnPressed(){
//        showMailComposer()
    }
    
   
    
    func setupView(){
        [sendFeedbackBtn].forEach({view.addSubview($0)})
        let cancelBtnItem = UIBarButtonItem(customView: cancelBtn)
        navigationItem.leftBarButtonItem =  cancelBtnItem
        navigationItem.title = "Help Center"
//        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        navigationController?.navigationBar.hideNavBarSeperator()
        
        sendFeedbackBtn.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20), size: CGSize(width: 50, height: 50))
    }
    
}





