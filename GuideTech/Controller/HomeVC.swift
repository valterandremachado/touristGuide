//
//  HomeVC.swift
//  GuideTech
//
//  Created by Valter A. Machado on 3/7/20.
//  Copyright © 2020 Valter A. Machado. All rights reserved.
//
import UIKit
import LBTATools

let hotelsCellID = "hotelsCell"
let touristSpotsCellID = "touristSpotsCell"
let restaurantsCellID = "restaurantsCell"
let busStopCellID = "busStopCell"
let headerID = "header"

class HomeVC: UIViewController {
    
    let colorArray = [UIColor.blue, UIColor.green, UIColor.blue, UIColor.gray, UIColor.yellow]
    // hotel arrays
    let imageArray = ["image1.jpg", "image2.jpg", "image3.jpg"]
    let nameArray = ["Venis", "CityLights", "Porta Vaga"]
    let addressArray = ["Address", "Address", "Address"]
    let priceArray = ["₱5,000", "₱5,000", " ₱5,000"]
    let reviewArray = ["5 ★", "5 ★", "5 ★"]
    
    // tourist Spot arrays
    let imageArray2 = ["park1.jpg", "park2.jpg", "park3.jpg"]
    let nameArray2 = ["Burnham Park", "Session Road", "The Mansion"]
    let descriptionArray = ["is a historic urban park located in downtown Baguio.", "The road forms part of the National Route 231 of the Philippine highway network.", "The mansion is located in the summer capital of the country."]
    let reviewArray2 = ["5 ★", "5 ★", "5 ★"]
    let addressArray2 = ["Address", "Address", "Address"]
    
    // restaurant arrays
    let imageArray3 = ["restaurant1.jpg", "restaurant2.jpg", "restaurant3.jpg"]
    let nameArray3 = ["Craft 1945", "Le Chef", "Secret Garden"]
    let descriptionArray2 = ["is a historic urban park located in downtown Baguio.", "The road forms part of the National Route 231 of the Philippine highway network.", "The mansion is located in the summer capital of the country."]
    let reviewArray3 = ["5 ★", "5 ★", "5 ★"]
    let addressArray3 = ["Address", "Address", "Address"]
    
    // bus stop arrays
    let nameArray4 = ["Victory Liner Bus Terminal", "Genesis Bus Terminal", "Victory Liner"]
    let reviewArray4 = ["5 ★", "5 ★", "5 ★"]
    let addressArray4 = ["Address", "Address", "Address"]
    
    var filteredArray = [String]()
    var isSearching = false
    lazy var searchBar: UISearchBar = {
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
        // Do any additional setup after loading the view.
//        navigationController?.title = "HomeVC"
//        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.backgroundColor = .white
        setView()
    }

    fileprivate func setView(){
        [collectionView, searchBar].forEach({view.addSubview($0)})
        
        searchBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15))
        collectionView.anchor(top: searchBar.bottomAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
//        searchBars = UISearchBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 0))
    }

}

extension HomeVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section <= 2
        {
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
            // hotels cell
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: hotelsCellID, for: indexPath) as! HotelsCell
//             cell.iconCell.coverImageView.backgroundColor = .blue
             cell.images = imageArray
             cell.names = nameArray
             cell.addresses = addressArray
             cell.prices = priceArray
             cell.reviews = reviewArray

             return cell
        case 1:
            // tourist spots cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: touristSpotsCellID, for: indexPath) as! TouristSpotsCell
            
            cell.images = imageArray2
            cell.names = nameArray2
//            cell.descriptions = descriptionArray
            cell.reviews = reviewArray2
            cell.addresses = addressArray2
            
            return cell
        case 2:
            // restaurants cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: restaurantsCellID, for: indexPath) as! RestaurantsCell
            
            cell.images = imageArray3
            cell.names = nameArray3
//            cell.descriptions = descriptionArray
            cell.reviews = reviewArray3
            cell.addresses = addressArray3
            
            return cell
        case 3:
            // bus stop cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: busStopCellID, for: indexPath) as! BusStopCell
            
            cell.name.text = nameArray4[indexPath.item]
            cell.review.text = reviewArray4[indexPath.item]
            cell.address.text = addressArray4[indexPath.item]
            
            return cell
        default:
            break
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section <= 2
        {
            return CGSize(width: view.frame.width, height: 250)
        }
        return CGSize(width: view.frame.width - 19, height: 80)
    }
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section <= 2
        {
            return UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0)
        }
        return UIEdgeInsets(top: 20, left: 8, bottom: 8, right: 8)

    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind:
               String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier:
                       headerID, for: indexPath) as! Header
//        header.backgroundColor = .yellow

        switch indexPath.section {
        case 0:
            header.sectionTitle.text = "Hotels"
            return header
        case 1:
            header.sectionTitle.text = "Tourist Spots"
            return header
        case 2:
            header.sectionTitle.text = "Restaurants"
            return header
        case 3:
            header.sectionTitle.text = "Bus Stop"
            return header
        default:
            break
        }
        return header
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
            return CGSize(width: collectionView.frame.width, height: 20)
    }
    
//        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
//            return CGSize(width: 60.0, height: 30.0)
//    }
}



