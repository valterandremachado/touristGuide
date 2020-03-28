//
//  LanguageCell.swift
//  GuideTech
//
//  Created by Valter A. Machado on 3/21/20.
//  Copyright © 2020 Valter A. Machado. All rights reserved.
//
import UIKit

class LanguageCell: UITableViewCell {
    
    lazy var descriptionLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .darkGray
        lbl.font = .boldSystemFont(ofSize: 18)
        lbl.text = "Dummy text"
        return lbl
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //        setupView()
        
        /// Adding tableView right indicator
//        self.accessoryType = .disclosureIndicator
//        /// Changing selection style
//        self.selectionStyle = .blue
        
    }
    
  
    fileprivate func setupView(){
        //        [stackView].forEach({contentView.addSubview($0)})
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


