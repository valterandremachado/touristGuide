//
//  HomeVC.swift
//  GuideTech
//
//  Created by Valter A. Machado on 3/7/20.
//  Copyright © 2020 Valter A. Machado. All rights reserved.
//
import UIKit
import LBTATools
import Alamofire
import Firebase

let hotelsCellID = "hotelsCell"
let touristSpotsCellID = "touristSpotsCell"
let restaurantsCellID = "restaurantsCell"
let busStopCellID = "busStopCell"
let headerID = "header"

var customView = UIView()
let transparentView = UIView()
let transparentView2 = UIView()
var menuIsOn = false

let colorArray = [UIColor.blue, UIColor.green, UIColor.blue, UIColor.gray, UIColor.yellow]

class HomeVC: UIViewController, UISearchBarDelegate {
    
    var delegate: homeVCDelegate?
    
    // check whenever menu is pressed
    
    
    // bus stop arrays
    let nameArray4 = ["Victory Liner Bus Terminal", "Gov. Pack Road Bus Terminal"]
//    let reviewArray4 = ["5 ★", "5 ★", "5 ★"]
    let addressArray4 = ["Utility Rd", "Gov. Pack Road"]
    
    var filteredArray = [String]()
    var isSearching = false
    lazy var mainSearchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.translatesAutoresizingMaskIntoConstraints = false
        
        sb.layer.shadowColor = UIColor.black.cgColor
        sb.layer.shadowRadius = 20
        sb.layer.shadowOpacity = 1.0
        sb.layer.shadowOffset = CGSize(width: 10, height: 10)
        sb.layer.masksToBounds = false
        //        sb.clipsToBounds = false
        sb.backgroundImage = UIImage()
        sb.placeholder = "Search"
        
        sb.returnKeyType = UIReturnKeyType.done
        sb.delegate = self
        
        return sb
    }()
    
    let sections = ["Hotels", "Tourist Spots", "Restaurants", "Bus Stop"]
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        //        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 16
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.delegate = self
        cv.dataSource = self
        cv.register(HotelsCell.self, forCellWithReuseIdentifier: hotelsCellID)
        cv.register(TouristSpotsCell.self, forCellWithReuseIdentifier: touristSpotsCellID)
        cv.register(RestaurantsCell.self, forCellWithReuseIdentifier: restaurantsCellID)
        cv.register(BusStopCell.self, forCellWithReuseIdentifier: busStopCellID)
        // header
        cv.register(Header.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerID)
        return cv
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let arr = NSArray(objects: "en")
//        UserDefaults.standard.set(arr, forKey: "AppleLanguages")
        view.backgroundColor = .white
//        checkUserIsLoggedIn()
        setView()
        setupTransparentView()
    }
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//    }
    
    fileprivate func checkUserIsLoggedIn(){
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let loginVC = LoginVC()
                let navigationController = UINavigationController(rootViewController: loginVC)
                navigationController.modalPresentationStyle = .fullScreen
                self.present(navigationController, animated: false, completion: nil)
                return
            }
        } else {
            print("is Logged in")
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
    
    fileprivate func setView(){
        [collectionView, transparentView2].forEach({view.addSubview($0)})
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "slider.horizontal.3"), style: .plain, target: self, action: #selector(menuSlidePressed))
        navigationItem.leftBarButtonItem?.tintColor = .rgb(red: 101, green: 183, blue: 180)
        navigationItem.title = "GuideTech"
//        mainSearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 0))
//        self.navigationItem.titleView = mainSearchBar
//        mainSearchBar.placeholder = "Search places in baguio..."
        
        //        mainSearchBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15))
        collectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0))
        //        searchBars = UISearchBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 0))
        
        transparentView2.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
    }
    
    func setupTransparentView() {
        transparentView.backgroundColor =  UIColor.black.withAlphaComponent(0.3)
        transparentView2.backgroundColor =  UIColor.black.withAlphaComponent(0.3)
        transparentView.translatesAutoresizingMaskIntoConstraints = false
        transparentView2.translatesAutoresizingMaskIntoConstraints = false

        navigationController?.navigationBar.addSubview(transparentView)
        
        transparentView.isHidden = true
        transparentView2.isHidden = true
        transparentView.isUserInteractionEnabled = true
        transparentView2.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideSlider))
        transparentView.addGestureRecognizer(tapGesture)
        
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(hideSlider2))
        transparentView2.addGestureRecognizer(tapGesture2)
        
        NSLayoutConstraint.activate([
            transparentView.widthAnchor
                .constraint(equalToConstant: self.view.bounds.width),
            transparentView.heightAnchor
                .constraint(equalToConstant: self.view.bounds.height + 50),
            transparentView.topAnchor
                .constraint(equalTo: (navigationController?.navigationBar.topAnchor)!, constant: -(navigationController?.navigationBar.frame.height)!),
            transparentView.trailingAnchor
                .constraint(equalTo: (navigationController?.navigationBar.trailingAnchor)!, constant: 0)
        ])
        
        customView = transparentView
        
    }
    
    @objc fileprivate func menuSlidePressed(){
        DispatchQueue.main.async {
            self.delegate?.handleMenuToggle(forMenuOption: nil)
        }

        menuIsOn = !menuIsOn
        if !menuIsOn {
            view.isUserInteractionEnabled = true
            customView.isHidden = true
            transparentView2.isHidden = true

            // hide transparentView
            UIView.animate(withDuration: 0.5, animations: {
                transparentView.alpha = 0
                transparentView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                transparentView2.alpha = 0
                transparentView2.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            }) { (_) in
                transparentView.removeFromSuperview()
                transparentView2.removeFromSuperview()
            }

        } else {
//            view.isUserInteractionEnabled = false
            customView.isHidden = false
            transparentView2.isHidden = false

            // show transparentView
            transparentView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            transparentView.alpha = 0
            transparentView2.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            transparentView2.alpha = 0
            UIView.animate(withDuration: 0.5) {
                transparentView.alpha = 1
                transparentView.transform = CGAffineTransform.identity
                transparentView2.alpha = 1
                transparentView2.transform = CGAffineTransform.identity
            }
        }
//        print("menuSlidePressed: \(menuIsOn)")
    }
    
    @objc func hideSlider() {
        self.delegate?.handleMenuToggle(forMenuOption: nil)

        menuIsOn = !menuIsOn
        if !menuIsOn {
            view.isUserInteractionEnabled = true
            customView.isHidden = true
            transparentView2.isHidden = true
            
            // hide transparentView
            UIView.animate(withDuration: 0.5, animations: {
                transparentView.alpha = 0
                transparentView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                transparentView2.alpha = 0
                transparentView2.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            })

        } else {
//            view.isUserInteractionEnabled = false
            customView.isHidden = false
            transparentView2.isHidden = false
        }
    }
    
    @objc func hideSlider2(){
        self.delegate?.handleMenuToggle(forMenuOption: nil)
        
        menuIsOn = !menuIsOn
        if !menuIsOn {
            view.isUserInteractionEnabled = true
            customView.isHidden = true
            transparentView2.isHidden = true
            
            // hide transparentView
            UIView.animate(withDuration: 0.5, animations: {
                transparentView.alpha = 0
                transparentView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                transparentView2.alpha = 0
                transparentView2.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            })
            
        } else {
            //            view.isUserInteractionEnabled = false
            customView.isHidden = false
            transparentView2.isHidden = false
        }
    }
    
}

extension HomeVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //        if mainSearchBar.text == nil || mainSearchBar.text == ""{
        //            isSearching = false
        //            view.endEditing(true)
        //            collectionView.reloadData()
        //        }else{
        //            isSearching = true
        //            filteredArray = nameArray.filter({$0.range(of: mainSearchBar.text!, options: .caseInsensitive) != nil })
        //            collectionView.reloadData()
        //        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind:
        String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier:
            headerID, for: indexPath) as! Header
        //        header.backgroundColor = .yellow
        //        header.seeAllBtn.addTarget(self, action: #selector(seeAllBtnPressed), for: .touchUpInside)
        
        
        switch indexPath.section {
        case 0:
            
            if preferredLanguage == "ar" {
                header.sectionTitle.text = "Hotels".localized("ar")
            } else {
                header.sectionTitle.text = "Hotels"
            }
            header.seeAllBtn.isHidden = false
            return header
            
        case 1:
            if preferredLanguage == "ar" {
                header.sectionTitle.text = "Tourist Spots".localized("ar")
            } else {
                header.sectionTitle.text = "Tourist Spots"
            }
            return header
            
        case 2:
            if preferredLanguage == "ar" {
                header.sectionTitle.text = "Restaurants".localized("ar")
            } else {
                print("this is Arabic")
                header.sectionTitle.text = "Restaurants"
            }
            return header
            
        case 3:
            if preferredLanguage == "ar" {
                header.sectionTitle.text = "Bus Stop".localized("ar")
            } else {
                print("this is Arabic")
                header.sectionTitle.text = "Bus Stop"
            }
            header.seeAllBtn.isHidden = true
            return header
            
        default:
            header.seeAllBtn.isHidden = false
            break
        }
        return header
    }
    
    @objc func seeAllBtnPressed(){
        //        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: hotelsCellID, for: indexPath) as! HotelsCell
        //        collectionView.numberOfItems(inSection: cell.names.count)
        print("123")
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section <= 2
        {
            //            if isSearching {
            //                return filteredArray.count
            //            }
            return 1
        }
        //        else
        //        {
        //
        //        }
        return nameArray4.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: hotelsCellID, for: indexPath) as! HotelsCell
        
        switch indexPath.section {
        case 0:
            return cell
        case 1:
            // tourist spots cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: touristSpotsCellID, for: indexPath) as! TouristSpotsCell
           
            return cell
        case 2:
            // restaurants cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: restaurantsCellID, for: indexPath) as! RestaurantsCell
          
            return cell
        case 3:
            // bus stop cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: busStopCellID, for: indexPath) as! BusStopCell
            
            cell.name.text = nameArray4[indexPath.item]
            cell.address.text = addressArray4[indexPath.item]
            
            cell.getLocationBtn.addTarget(self, action: #selector(getDirectionPressed), for: .touchUpInside)
            return cell
        default:
            break
        }
        return cell
    }
    
    @objc func getDirectionPressed(sender: UIButton) {
        
        let mapVC = MapsVC()
        if let indexPath = self.collectionView.indexPathForView(sender) {
            print("Button tapped at indexPath \(indexPath)")
            switch indexPath.item {
            case 0:
                mapVC.location = "16.406084, 120.602619"
                mapVC.navigationItem.title = nameArray4[0]
                navigationController?.pushViewController(mapVC, animated: true)
//                present(mapVC, animated: true)
            case 1:
                mapVC.location = "16.410375, 120.598629"
                mapVC.navigationItem.title = nameArray4[1]
                navigationController?.pushViewController(mapVC, animated: true)
//                present(mapVC, animated: true)
            default:
                break
            }
        }
        else {
            print("Button indexPath not found")
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section <= 2
        {
            return CGSize(width: view.frame.width, height: 250)
        }
        return CGSize(width: view.frame.width - 19, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section <= 2
        {
            return UIEdgeInsets(top: 5, left: 0, bottom: 8, right: 0)
        }
        return UIEdgeInsets(top: 20, left: 8, bottom: 8, right: 8)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 20)
    }
    
    //        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
    //            return CGSize(width: 60.0, height: 30.0)
    //    }
}


