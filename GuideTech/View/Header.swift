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
    
   override init(frame: CGRect) {
       super.init(frame: frame)
//       self.backgroundColor = UIColor.purple
        setupView()
    }
    
    fileprivate func setupView(){
        self.addSubview(sectionTitle)
        
        sectionTitle.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: nil, padding: UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 0))
    }
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)

    }
}
