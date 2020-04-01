//
//  AboutVC.swift
//  GuideTech
//
//  Created by Valter A. Machado on 3/25/20.
//  Copyright © 2020 Valter A. Machado. All rights reserved.
//

import UIKit

class AboutVC: UIViewController {
    
    var textView: UITextView = {
        var tv = UITextView()
        tv.translatesAutoresizingMaskIntoConstraints = false
//        tv.backgroundColor = .red
        tv.textAlignment = .justified
        tv.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .rgb(red: 101, green: 183, blue: 180)
        view.backgroundColor = .white
        
        if preferredLanguage == "ar" {
            navigationItem.title = "About".localized("ar")
        } else {
            navigationItem.title = "About"
        }
        
        setupView()
    }
    
    fileprivate func setupView(){
        view.addSubview(textView)
        
        textView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
    }
}
