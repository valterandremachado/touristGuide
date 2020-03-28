//
//  HomeVCDetails.swift
//  GuideTech
//
//  Created by Valter A. Machado on 3/15/20.
//  Copyright © 2020 Valter A. Machado. All rights reserved.
//

import UIKit
import LBTATools

class HomeVCDetails: UIViewController {
    let backButton = UIBarButtonItem()

    lazy var doneBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
//                btn.setTitle("Done", for: .normal)
//        let largeConfig = UIImage.SymbolConfiguration(textStyle: .largeTitle)
//        btn.setPreferredSymbolConfiguration(largeConfig, forImageIn: .normal)
        btn.setImage(UIImage(systemName: "multiply.circle.fill"), for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 20)
//        btn.tintColor = UIColor.rgb(red: 253, green: 39, blue: 93)
        btn.tintColor = .rgb(red: 101, green: 183, blue: 180)
        btn.addTarget(self, action: #selector(doneBtnPressed), for: .touchUpInside)
        return btn
    }()
    
    lazy var imageView: UIImageView = {
        var iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        //        iv.contentMode = .scaleAspectFit
        //        iv.setRounded()
        iv.clipsToBounds = true
        
        return iv
    }()
    
    lazy var name: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        if preferredLanguage == "ar" {
            lbl.text = "Unavailable".localized("ar")
        } else {
            lbl.text = "Unavailable"
        }
        lbl.font = .boldSystemFont(ofSize: 20)

        return lbl
    }()
    
    lazy var address: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        if preferredLanguage == "ar" {
            lbl.text = "Unavailable".localized("ar")
        } else {
            lbl.text = "Unavailable"
        }
        
//        lbl.font = .boldSystemFont(ofSize: 20)
        lbl.textColor = .darkGray
        return lbl
    }()
    
    lazy var phone: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        if preferredLanguage == "ar" {
            lbl.text = "Unavailable".localized("ar")
        } else {
            lbl.text = "Unavailable"
        }
        
        lbl.textColor = .rgb(red: 101, green: 183, blue: 180)

        return lbl
    }()
    
    lazy var phoneLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        if preferredLanguage == "ar" {
            lbl.text = "Phone".localized("ar")
        } else {
            lbl.text = "Phone"
        }
        
        lbl.textColor = .lightGray
        return lbl
    }()
    
    lazy var review: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        if preferredLanguage == "ar" {
            lbl.text = "Unavailable".localized("ar")
        } else {
            lbl.text = "Unavailable"
        }
        
        lbl.textColor = .rgb(red: 101, green: 183, blue: 180)
        return lbl
    }()
    
    lazy var reviewLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        if preferredLanguage == "ar" {
            lbl.text = "Reviews".localized("ar")
        } else {
            lbl.text = "Reviews"
        }
        
        lbl.textColor = .lightGray
        return lbl
    }()
    
    
    lazy var stackView: UIStackView = {
        var sv = UIStackView(arrangedSubviews: [name, address])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.spacing = 5
        //                sv.contentMode = .scaleToFill
        sv.alignment = .leading
        sv.distribution = .equalCentering
//        sv.addBackground(color: .blue)
        
        return sv
    }()
    
    lazy var stackView2: UIStackView = {
        var sv = UIStackView(arrangedSubviews: [phoneLbl, phone])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.spacing = 5
        //                sv.contentMode = .scaleToFill
//        sv.alignment = .center
        sv.distribution = .equalCentering
//        sv.addBackground(color: .gray)
        
        return sv
    }()
    
    lazy var stackView3: UIStackView = {
        var sv = UIStackView(arrangedSubviews: [reviewLbl, review])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.spacing = 5
        //                sv.contentMode = .scaleToFill
        //        sv.alignment = .center
        sv.distribution = .equalCentering
//        sv.addBackground(color: .gray)
        
        return sv
    }()
    
    lazy var stackView4: UIStackView = {
        var sv = UIStackView(arrangedSubviews: [stackView2, stackView3])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.spacing = view.frame.width/2.5
        //                sv.contentMode = .scaleToFill
        //        sv.alignment = .center
        sv.distribution = .equalCentering
//        sv.addBackground(color: .gray)
        
        return sv
    }()
    
    
    lazy var getLocationBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        if preferredLanguage == "ar" {
            btn.setImage(UIImage(systemName: "location"), for: .normal)
            btn.setTitle("Get Directions".localized("ar"), for: .normal)
        } else {
            btn.setImage(UIImage(systemName: "location"), for: .normal)
            btn.setTitle("Get Directions", for: .normal)
        }
        
        btn.backgroundColor = .rgb(red: 101, green: 183, blue: 180)
        btn.tintColor = .black
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 8
        btn.addTarget(self, action: #selector(getDirectionPressed), for: .touchUpInside)

//        btn.alignTextBelow()
        return btn
    }()
    
    lazy var latitude: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .rgb(red: 101, green: 183, blue: 180)
        return lbl
    }()
    
    
    lazy var longitude: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .rgb(red: 101, green: 183, blue: 180)
        return lbl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
//        navigationController?.title = "Details"
        setupView()
    }
    
    @objc fileprivate func getDirectionPressed(){
        let mapVC = MapsVC()
        mapVC.navigationItem.title = name.text
        mapVC.location = "\(latitude.text! ), \(longitude.text!)"
        navigationController?.pushViewController(mapVC, animated: true)
    }
    
    func setupView(){
        [imageView, stackView, stackView4, getLocationBtn].forEach({view.addSubview($0)})
        
        imageView.image = UIImage(named: "restaurant1.jpg")
        
        // navController setup
        if preferredLanguage == "ar" {
           backButton.title = "Back".localized("ar")
        } else {
            backButton.title = "Back"
        }
        
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        let doneBtnItem = UIBarButtonItem(customView: doneBtn)
        navigationItem.leftBarButtonItem =  doneBtnItem
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.hideNavBarSeperator()
        
        
//        stackView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets.init(top: 0, left: 0, bottom: 10, right: 0))
        
        imageView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: view.frame.height/2))
        
        stackView.anchor(top: imageView.safeAreaLayoutGuide.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets.init(top: 15, left: 15, bottom: 0, right: 15))
        
        stackView4.anchor(top: stackView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets.init(top: 15, left: 15, bottom: 0, right: 15))
        
        getLocationBtn.anchor(top: stackView4.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets.init(top: 20, left: 15, bottom: 0, right: 15), size: CGSize(width: 0, height: 40))
        
//        doneBtn.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets.init(top: 10, left: 10, bottom: 0, right: 0))
               
    }
    
    @objc func doneBtnPressed(){
        dismiss(animated: true, completion: nil)
    }
}
