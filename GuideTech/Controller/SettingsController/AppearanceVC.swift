//
//  AppearanceVC.swift
//  GuideTech
//
//  Created by Valter A. Machado on 3/21/20.
//  Copyright © 2020 Valter A. Machado. All rights reserved.
//

import UIKit
import LBTATools

let appearID = "cellID"
class AppearanceVC: UIViewController {
    
    var isDarkMode = UITraitCollection.current.userInterfaceStyle

    let isAppearSelectedKey = "appearanceCheckmarks"
    var selectedIndexPath: IndexPath? = IndexPath(row: 0, section: 0)
    fileprivate var defaults = UserDefaults.standard

//    var delegate2: AppearanceVCDelegate?

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
        tv.register(AppearanceCell.self, forCellReuseIdentifier: appearID)
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Add Observers
        NotificationCenter.default.addObserver(self, selector: #selector(darkModeEnabled(_:)), name: .darkModeEnabled, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(darkModeDisabled(_:)), name: .darkModeDisabled, object: nil)
        
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .rgb(red: 101, green: 183, blue: 180)

        setupView()
        getData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        getData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        storeData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        /// Disable selected cell highlight after click on it.
        if let index = self.tableView.indexPathForSelectedRow{
            self.tableView.deselectRow(at: index, animated: true)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .darkModeEnabled, object: nil)
        NotificationCenter.default.removeObserver(self, name: .darkModeDisabled, object: nil)
    }
    
    fileprivate func setupView(){
        [tableView].forEach({view.addSubview($0)})
        
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20), size: CGSize(width: 0, height: 149))
    }
    
}

extension AppearanceVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: appearID, for: indexPath) as! AppearanceCell
        //        cell.backgroundColor = .init(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5)
        
        if indexPath == selectedIndexPath {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        let appearEnum = AppearEnum(rawValue: indexPath.row)
        cell.textLabel?.text = appearEnum?.description
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        // do nothing if the cell is checked already
        if indexPath == selectedIndexPath {
            return
        }
        
        // toggle old one off and the new one on
        let newCell = tableView.cellForRow(at: indexPath)
        if newCell?.accessoryType == UITableViewCell.AccessoryType.none
        {
            newCell?.accessoryType = .checkmark
        }
        
        let oldCell = tableView.cellForRow(at: selectedIndexPath!)
        if oldCell?.accessoryType == .checkmark
        {
            oldCell?.accessoryType = .none
        }

        // save the selected index path
        selectedIndexPath = indexPath
        
        let Appear = AppearEnum(rawValue: selectedIndexPath!.row)
//        delegate2?.handleModeToggle(forMode: Appear)
        switch Appear {
        case .Automatic:
            print("Automatic")
        case .Dark:
            let homeVC = HomeVC() 
            homeVC.overrideUserInterfaceStyle = .dark
//            overrideUserInterfaceStyle = .dark
//            view.backgroundColor = .lightGray
//            isDarkMode = .dark
            print("Dark")
            NotificationCenter.default.post(name: .darkModeEnabled, object: nil)
//            homeVC.handleModeToggle(forMode: Appear)
        case .Light:
            let homeVC = HomeVC()
            homeVC.overrideUserInterfaceStyle = .light
//            view.overrideUserInterfaceStyle = .light
//            view.backgroundColor = .rgb(red: 240, green: 240, blue: 240)
            print("Light")
        default: break
        }
        // stores the selected indexPath with the checkmark
        storeData()
        
    }
    
    func darkMode(){
        overrideUserInterfaceStyle = .dark
    }
    
    @objc private func darkModeEnabled(_ notification: Notification) {
        // Write your dark mode code here
        let homeVC = HomeVC()
        homeVC.overrideUserInterfaceStyle = .dark
    }
    @objc private func darkModeDisabled(_ notification: Notification) {
        // Write your non-dark mode code here
    }
    
    fileprivate func storeData(){
        try! defaults.set(NSKeyedArchiver.archivedData(withRootObject: selectedIndexPath!, requiringSecureCoding: true), forKey: isAppearSelectedKey)
        defaults.synchronize()
    }
    
    fileprivate func getData(){
        if let checks = defaults.value(forKey: isAppearSelectedKey) as? NSData {
            selectedIndexPath = (NSKeyedUnarchiver.unarchiveObject(with: checks as Data) as! IndexPath)
        }
    }
    
}
