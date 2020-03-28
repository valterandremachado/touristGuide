//
//  MenuSliderVC.swift
//  GuideTech
//
//  Created by Valter A. Machado on 3/16/20.
//  Copyright © 2020 Valter A. Machado. All rights reserved.
//

import UIKit
import LBTATools

private let tableCellID = "cellID"

class MenuSliderVC: UIViewController {
    
    var delegate: homeVCDelegate?

    lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.backgroundColor = .red
        iv.image = UIImage(named: "image1.jpg")
        return iv
    }()
    
    lazy var userName: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = .boldSystemFont(ofSize: 20)
        lbl.text = "User Name"
        return lbl
    }()
    
    lazy var stackView: UIStackView = {
        var sv = UIStackView(arrangedSubviews: [profileImageView, userName])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.spacing = 10
        //                sv.contentMode = .scaleToFill
        //        sv.alignment = .center
        sv.distribution = .equalCentering
//                sv.addBackground(color: .gray)
        return sv
    }()
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
//        tv.backgroundColor = .white
        //        tv.separatorColor = .gray
        tv.isScrollEnabled = false
        tv.separatorStyle = .none
        tv.rowHeight = 50
        tv.delegate = self
        tv.dataSource = self
        tv.register(MenuSliderCell.self, forCellReuseIdentifier: tableCellID)
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profileImageView.roundedImage()
    }
    
    fileprivate func setupView(){
        [stackView ,tableView].forEach({view.addSubview($0)})
        
        profileImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing:  nil, padding: UIEdgeInsets(top: 15, left: 15, bottom: 0, right: 0), size: CGSize(width: 35, height: 35))
        
        tableView.anchor(top: stackView.safeAreaLayoutGuide.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0))
    }
    
}


extension MenuSliderVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableCellID, for: indexPath) as! MenuSliderCell
        
        let menuOptions = MenuOptions(rawValue: indexPath.row)
        
        if preferredLanguage == "ar" {
            cell.descriptionLbl.text = menuOptions?.description.localized("ar")
        } else {
            cell.descriptionLbl.text = menuOptions?.description
        }
        
        cell.iconImageView.image = menuOptions?.image
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let menuOptions = MenuOptions(rawValue: indexPath.row)
        delegate?.handleMenuToggle(forMenuOption: menuOptions)
    }
    
}
