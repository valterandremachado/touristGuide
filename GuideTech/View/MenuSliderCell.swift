//
//  MenuSliderCell.swift
//  GuideTech
//
//  Created by Valter A. Machado on 3/16/20.
//  Copyright © 2020 Valter A. Machado. All rights reserved.
//

import UIKit

class MenuSliderCell: UITableViewCell {
    
    lazy var iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
//        iv.backgroundColor = .red
        iv.tintColor = .rgb(red: 101, green: 183, blue: 180)
        return iv
    }()
    
    lazy var descriptionLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .darkGray
        lbl.font = .boldSystemFont(ofSize: 18)
        lbl.text = "Dummy text"
        return lbl
    }()

    lazy var stackView: UIStackView = {
        var sv = UIStackView(arrangedSubviews: [iconImageView, descriptionLbl])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.spacing = 10
        //                sv.contentMode = .scaleToFill
        //        sv.alignment = .center
        sv.distribution = .equalCentering
//        sv.addBackground(color: .gray)
        return sv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    fileprivate func setupView(){
        [stackView].forEach({contentView.addSubview($0)})
        selectionStyle = .none
        iconImageView.anchor(top: self.safeAreaLayoutGuide.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 10, left: 40, bottom: 0, right: 0), size: CGSize(width: 30, height: 30))
        
//        descriptionLbl.anchor(top: self.safeAreaLayoutGuide.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0), size: CGSize(width: 25, height: 25))

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
