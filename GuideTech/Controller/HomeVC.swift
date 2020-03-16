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
//import ShimmerSwift

let hotelsCellID = "hotelsCell"
let touristSpotsCellID = "touristSpotsCell"
let restaurantsCellID = "restaurantsCell"
let busStopCellID = "busStopCell"
let headerID = "header"

class HomeVC: UIViewController, UISearchBarDelegate {
    
    var delegate: homeVCDelegate?
    
    let colorArray = [UIColor.blue, UIColor.green, UIColor.blue, UIColor.gray, UIColor.yellow]
    
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
        
        
        view.backgroundColor = .white
        setView()
        //        fetchJSONData()
    }
    
    
    fileprivate func setView(){
        [collectionView].forEach({view.addSubview($0)})
//        let profileImage = UIImage.init(named: "image1.jpg")
        
//        let profileBtn = UIButton(type: .custom)
////        profileBtn.imageView?.contentMode = .scaleAspectFill
////        profileBtn.setImage(profileImage, for: .normal)
//        profileBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
//        profileBtn.layer.cornerRadius = profileBtn.frame.size.height/2
//        profileBtn.layer.masksToBounds = false
//        profileBtn.clipsToBounds = true
//        profileBtn.backgroundColor = .red
//        //        profileBtn.layer.borderWidth = 1.5
//        profileBtn.sizeToFit()
//        let widthConstraint = profileBtn.widthAnchor.constraint(equalToConstant: 30)
//        let heightConstraint = profileBtn.heightAnchor.constraint(equalToConstant: 30)
//        heightConstraint.isActive = true
//        widthConstraint.isActive = true
//
//        let profileItem = UIBarButtonItem(customView: profileBtn)
//        navigationItem.leftBarButtonItem =  profileItem
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "slider.horizontal.3"), style: .plain, target: self, action: #selector(menuSlidePressed))
        navigationItem.leftBarButtonItem?.tintColor = .rgb(red: 101, green: 183, blue: 180)
        navigationItem.title = "GuideTech"
//        mainSearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 0))
//        self.navigationItem.titleView = mainSearchBar
//        mainSearchBar.placeholder = "Search places in baguio..."
        
        //        mainSearchBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15))
        collectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0))
        //        searchBars = UISearchBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 0))
    }
    
    @objc fileprivate func menuSlidePressed(){
        delegate?.handleMenuToggle(forMenuOption: nil)
    }
    
   
    
}


extension HomeVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    
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
            header.sectionTitle.text = "Hotels"
            header.seeAllBtn.isHidden = false
            return header
        case 1:
            header.sectionTitle.text = "Tourist Spots"
            return header
        case 2:
            header.sectionTitle.text = "Restaurants"
            return header
        case 3:
            header.sectionTitle.text = "Bus Stop"
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



