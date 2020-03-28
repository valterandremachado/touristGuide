//
//  LanguageVC.swift
//  GuideTech
//
//  Created by Valter A. Machado on 3/21/20.
//  Copyright © 2020 Valter A. Machado. All rights reserved.
//

import UIKit

let preferredLanguage = NSLocale.preferredLanguages[0]


let langID = "cellID"

class LanguageVC: UIViewController {

    let isLangSelectedKey = "checkmarks"
    var selectedIndexPath: IndexPath? = IndexPath(row: 0, section: 0)
    fileprivate var defaults = UserDefaults.standard
    
    let langsArray = ["en", "ar"]

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
        tv.register(LanguageCell.self, forCellReuseIdentifier: langID)
        
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if preferredLanguage == "ar" {
//            print("this is Arabic")
            navigationItem.title = "Language".localized("ar")
        } else {
//            print("this is english")
            navigationItem.title = "Language"
        }
        
        view.backgroundColor = .rgb(red: 240, green: 240, blue: 240)
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
        super.viewWillAppear(animated)
        
        /// Disable selected cell highlight after click on it.
        if let index = tableView.indexPathForSelectedRow{
            tableView.deselectRow(at: index, animated: animated)
        }
    }
    
    fileprivate func setupView(){
        [tableView].forEach({view.addSubview($0)})
        
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20), size: CGSize(width: 0, height: 99))
    }
    
}

extension LanguageVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: langID, for: indexPath) as! LanguageCell
        //        cell.backgroundColor = .init(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5)
        
        if indexPath == selectedIndexPath {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        let langEnum = LangEnum(rawValue: indexPath.row)
        cell.textLabel?.text = langEnum?.description
        
        if preferredLanguage == "ar" {
            cell.textLabel?.text = langEnum?.description.localized("ar")
        } else {
            cell.textLabel?.text = langEnum?.description
            
        }
        
//        cell.textLabel?.text = langEnum?.description.localized("en")
    
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

        let langEnum = LangEnum(rawValue: selectedIndexPath!.row)
//        let homeVC = HomeVC()
        switch langEnum {
        case .English:
            print("english")
            
            if preferredLanguage == "ar"{
                let alertController = UIAlertController(title: "Language".localized("ar"), message: "We will close your app to change language completely,  please reopen your app after so.".localized("ar"), preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "Ok".localized("ar"), style: .default) {
                    UIAlertAction in
                    let arr = NSArray(objects: self.langsArray[0])
                    self.defaults.set(arr, forKey: "AppleLanguages")
                    
                    NSLog("OK Pressed")
                    exit(0)
                }
                let cancelAction = UIAlertAction(title: "Cancel".localized("ar"), style: .cancel) {
                    UIAlertAction in
                    NSLog("Cancel Pressed")
                }
                alertController.view.tintColor = .rgb(red: 101, green: 183, blue: 180)
                alertController.addAction(okAction)
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true, completion: nil)
            }
            else {
                
                let alertController = UIAlertController(title: "Language", message: "We will close your app to change language completely,  please reopen your app after so.", preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "Ok", style: .default) {
                    UIAlertAction in
                    let arr = NSArray(objects: self.langsArray[0])
                    self.defaults.set(arr, forKey: "AppleLanguages")
                    
                    NSLog("OK Pressed")
                    exit(0)
                }
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) {
                    UIAlertAction in
                    NSLog("Cancel Pressed")
                }
                
                alertController.view.tintColor = .rgb(red: 101, green: 183, blue: 180)
                alertController.addAction(okAction)
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true, completion: nil)
                
            }

            
        case .Arabic:
            print("Arabic")
            
            if preferredLanguage == "ar"{
                let alertController = UIAlertController(title: "Language".localized("ar"), message: "We will close your app to change language completely,  please reopen your app after so.".localized("ar"), preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "Ok".localized("ar"), style: .default) {
                    UIAlertAction in
                    let arr = NSArray(objects: self.langsArray[1])
                    self.defaults.set(arr, forKey: "AppleLanguages")
                    
                    NSLog("OK Pressed")
                    exit(0)
                }
                let cancelAction = UIAlertAction(title: "Cancel".localized("ar"), style: .cancel) {
                    UIAlertAction in
                    NSLog("Cancel Pressed")
                }
                alertController.view.tintColor = .rgb(red: 101, green: 183, blue: 180)
                alertController.addAction(okAction)
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true, completion: nil)
            }
            else {
                
                let alertController = UIAlertController(title: "Language", message: "We will close your app to change language completely,  please reopen your app after so.", preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "Ok", style: .default) {
                    UIAlertAction in
                    let arr = NSArray(objects: self.langsArray[1])
                    self.defaults.set(arr, forKey: "AppleLanguages")
                    
                    NSLog("OK Pressed")
                    exit(0)
                }
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) {
                    UIAlertAction in
                    NSLog("Cancel Pressed")
                }
                
                alertController.view.tintColor = .rgb(red: 101, green: 183, blue: 180)
                alertController.addAction(okAction)
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true, completion: nil)
                
            }
            
        default: break
        }
       
        // stores the selected indexPath with the checkmark
        storeData()
        
    }


    fileprivate func storeData(){
        try! defaults.set(NSKeyedArchiver.archivedData(withRootObject: selectedIndexPath!, requiringSecureCoding: true), forKey: isLangSelectedKey)
        defaults.synchronize()
    }
    
    fileprivate func getData(){
       if let checks = defaults.value(forKey: isLangSelectedKey) as? NSData {
        selectedIndexPath = (NSKeyedUnarchiver.unarchiveObject(with: checks as Data) as! IndexPath)
        }
    }
}
