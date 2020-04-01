//
//  MenuSliderVC.swift
//  GuideTech
//
//  Created by Valter A. Machado on 3/16/20.
//  Copyright © 2020 Valter A. Machado. All rights reserved.
//

import UIKit
import LBTATools
import Firebase

// MARK: - Global variables
var profileImageView: UIImageView = {
    let iv = UIImageView()
    iv.contentMode = .scaleAspectFill
    iv.clipsToBounds = true
    //        iv.backgroundColor = .red
    iv.image = UIImage(systemName: "person.crop.circle.fill")?.withTintColor(.rgb(red: 101, green: 183, blue: 180), renderingMode: .alwaysOriginal)
    return iv
}()

var userName: UILabel = {
    let lbl = UILabel()
    lbl.textColor = .black
    lbl.font = .boldSystemFont(ofSize: 20)
    lbl.text = "loading..."
    return lbl
}()

class MenuSliderVC: UIViewController {
    
    var delegate: homeVCDelegate?
    private let tableCellID = "cellID"

    
    
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
        tv.backgroundColor = .white
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
        checkUserIsLoggedIn()
        view.backgroundColor = .white
        self.tableView.tableFooterView = UIView()
        setupView()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//        checkUserIsLoggedIn()
//    }
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print("sliderVC")
//    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profileImageView.roundedImage()
    }
    
    
    fileprivate func checkUserIsLoggedIn(){
        if Auth.auth().currentUser == nil {
           print("User is not logged in.")
        }
        else
        {
            let uid = Auth.auth().currentUser?.uid
            let db = Database.database().reference().child("users").child(uid!)
            db.observeSingleEvent(of: .value) { (snapshot) in
                // print(snapshot)
                DispatchQueue.main.async {
                    if let dict = snapshot.value as? [String: AnyObject] {
                        userName.text = dict["username"] as? String
                        let profileUrl = dict["profileImageUrl"] as! String
                        
                        let storageRef = Storage.storage().reference(forURL: profileUrl)
                        storageRef.downloadURL{ (url, error) in
                            do {
                                guard let url = url else { return }
                                let data = try Data(contentsOf: url)
                                let image = UIImage(data: data)
                                profileImageView.image = image
                            } catch {
                                print("no image: " + error.localizedDescription)
                            }
                            
                        }
                    }
                }
                
            }
            
        }
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
        
        menuIsOn = !menuIsOn
        if !menuIsOn {
            transparentView.isHidden = true
            transparentView2.isHidden = true
            
            // hide transparentView
            UIView.animate(withDuration: 0.5, animations: {
                transparentView.alpha = 0
                transparentView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                transparentView2.alpha = 0
                transparentView2.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            })
            
        } else {
            transparentView.isHidden = false
            transparentView2.isHidden = false
        }
    }
    
}
