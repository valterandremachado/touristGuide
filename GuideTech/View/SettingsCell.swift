//
//  SettingsCell.swift
//  GuideTech
//
//  Created by Valter A. Machado on 3/21/20.
//  Copyright © 2020 Valter A. Machado. All rights reserved.
//

import UIKit

class SettingsCell: UITableViewCell {
    
    
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
        backgroundColor = .rgb(red: 240, green: 240, blue: 240)

        /// Adding tableView right indicator
        self.accessoryType = .disclosureIndicator
        /// Changing selection style
        self.selectionStyle = .blue

    }
    
//    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
//        super.setHighlighted(highlighted, animated: animated)
//
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: false)
//        let viewForHighlight = UIView()
//        self.selectedBackgroundView = viewForHighlight
//        if self.isSelected {
//            viewForHighlight.backgroundColor = UIColor.gray
//        } else {
//            viewForHighlight.backgroundColor = UIColor.clear
//        }
//    }
    
    fileprivate func setupView(){
//        [stackView].forEach({contentView.addSubview($0)})
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

