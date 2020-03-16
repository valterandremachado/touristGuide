//
//  BusStopCell.swift
//  GuideTech
//
//  Created by Valter A. Machado on 3/7/20.
//  Copyright © 2020 Valter A. Machado. All rights reserved.
//

import UIKit
import LBTATools


protocol CellSubclassDelegate: class {
    func buttonTapped(cell: BusStopCell)
}

class BusStopCell: UICollectionViewCell {
    

    // name
    lazy var name: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        //        lbl.backgroundColor = .blue
        
        return lbl
    }()
    // address
    lazy var address: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        //        lbl.backgroundColor = .purple
        lbl.textColor = .lightGray
        
        return lbl
    }()
    // stars (convert it from string to int)
    lazy var review: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var getLocationBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(systemName: "location"), for: .normal)
        btn.setTitle("Get Directions", for: .normal)
        btn.tintColor = .rgb(red: 101, green: 183, blue: 180)
//        btn.addTarget(self, action: #selector(getDirectionPressed), for: .touchUpInside)
        btn.alignTextBelow()
        return btn
    }()
    
    lazy var stackView2: UIStackView = {
        var sv = UIStackView(arrangedSubviews: [name, address])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.spacing = 0
        //        sv.alignment = .center
        sv.distribution = .equalSpacing
        //        sv.addBackground(color: .green)
        
        return sv
    }()

    lazy var stackView1: UIStackView = {
        var sv = UIStackView(arrangedSubviews: [stackView2, getLocationBtn])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.spacing = 0
        //        sv.alignment = .center
        sv.distribution = .equalSpacing
        //        sv.addBackground(color: .green)
        
        return sv
    }()
    weak var delegate: CellSubclassDelegate?

    override init(frame: CGRect) {
        super.init(frame: .zero)

        setupView()
//        contentView.backgroundColor = .purple
        //        contentView.backgroundColor = .red
        self.layer.cornerRadius = 15
        //                self.layer.borderWidth = 1.0
        //                self.layer.borderColor = UIColor.lightGray.cgColor
        //
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 1.0
        self.layer.masksToBounds = false
    }
    
    @objc fileprivate func getDirectionPressed(sender: UIButton){
//        self.delegate!.buttonTapped(cell: self)
        
    }
    
    // 1: 16.406084, 120.602619
    // 2: 16.410375, 120.598629
    private func setupView(){
        [stackView1].forEach({contentView.addSubview($0)})
        
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 15
        
        stackView1.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor, padding:  UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        
//        stackView2.anchor(top: stackView1.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 105))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
