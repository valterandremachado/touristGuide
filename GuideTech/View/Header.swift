//
//  Header.swift
//  GuideTech
//
//  Created by Valter A. Machado on 3/7/20.
//  Copyright © 2020 Valter A. Machado. All rights reserved.
//
import UIKit

class Header: UICollectionReusableView {

    lazy var sectionTitle: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .boldSystemFont(ofSize: 20)

        return lbl
    }()
    
    lazy var seeAllBtn: UIButton = {
        var btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
//        btn.backgroundColor = UIColor(displayP3Red: 235/255, green: 51/255, blue: 72/255, alpha: 1)
        btn.setTitle("See All", for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 20)
        btn.layer.cornerRadius = 10
        btn.tintColor = .rgb(red: 101, green: 183, blue: 180)

//        btn.addTarget(self, action: #selector(loginBtnPressed), for: .touchUpInside)
        return btn
    }()
    
    lazy var stackView: UIStackView = {
        var sv = UIStackView(arrangedSubviews: [sectionTitle])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.spacing = 5
        //        sv.alignment = .center
        sv.distribution = .equalCentering
//        sv.addBackground(color: .lightGray)
        
        return sv
    }()
    
   override init(frame: CGRect) {
       super.init(frame: frame)
//       self.backgroundColor = UIColor.purple
        setupView()
    }
    
    fileprivate func setupView(){
        self.addSubview(stackView)
        
        stackView.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14))
    }
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)

    }
}
