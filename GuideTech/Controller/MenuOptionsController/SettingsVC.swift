//
//  SettingsVC.swift
//  GuideTech
//
//  Created by Valter A. Machado on 3/16/20.
//  Copyright © 2020 Valter A. Machado. All rights reserved.
//

import UIKit
import LBTATools

let settingsID = "cellID"

class SettingsVC: UIViewController {
    
//    var delegate2: AppearanceVCDelegate?
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
    

    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
//                tv.backgroundColor = .gray
        //        tv.separatorColor = .gray
//        tv.separatorStyle = .none
        tv.isScrollEnabled = false
        tv.showsVerticalScrollIndicator = false
        tv.layer.cornerRadius = 15
        tv.clipsToBounds = true
        tv.tableFooterView = UIView()
        tv.rowHeight = 50
        tv.delegate = self
        tv.dataSource = self
        tv.register(SettingsCell.self, forCellReuseIdentifier: settingsID)
        return tv
    }()
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .rgb(red: 240, green: 240, blue: 240)
        //        backButton.title = "Back"
        //        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        setupView()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        /// Disable selected cell highlight after click on it.
//        if let index = self.tableView.indexPathForSelectedRow{
//            self.tableView.deselectRow(at: index, animated: true)
//        }
//    }
    
    // MARK: - Handlers (functions/methods)
    @objc func cancelBtnPressed(){
        dismiss(animated: true, completion: nil)
    }
    
    func setupView(){
        [tableView].forEach({view.addSubview($0)})
        let cancelBtnItem = UIBarButtonItem(customView: cancelBtn)
        navigationItem.leftBarButtonItem =  cancelBtnItem
        
        if preferredLanguage == "ar" {
            navigationItem.title = "Settings".localized("ar")
        } else {
            navigationItem.title = "Settings"
        }

        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20), size: CGSize(width: 0, height: 99))
//        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        navigationController?.navigationBar.hideNavBarSeperator()
    }
}


extension SettingsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: settingsID, for: indexPath) as! SettingsCell
//        cell.backgroundColor = .init(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5)

        let settingsEnum = SettingsEnum(rawValue: indexPath.row)

        if preferredLanguage == "ar" {
            cell.textLabel?.text = settingsEnum?.description.localized("ar")
        } else {
            cell.textLabel?.text = settingsEnum?.description
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /// Disable selected cell highlight after click on it.
        tableView.deselectRow(at: indexPath, animated: true)

        let settingsEnum = SettingsEnum(rawValue: indexPath.row)
        
        switch settingsEnum {
        case .Language:
//            let appearanceVC = AppearanceVC()
//            appearanceVC.navigationItem.title = "Appearance"
//            navigationController?.pushViewController(appearanceVC, animated: true)
            let langVC = LanguageVC()
            langVC.navigationItem.title = "Language"
            navigationController?.pushViewController(langVC, animated: true)
            
        case .About:
            let aboutVC = AboutVC()
            navigationController?.pushViewController(aboutVC, animated: true)        case .none:
            print("none")
        }
    }
    
//    fileprivate func menuSlidePressed(){
//        delegate2?.handleModeToggle(forMode: nil)
//        print("123")
//    }
    
}
