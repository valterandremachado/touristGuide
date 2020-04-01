//
//  RestaurantsCell.swift
//  GuideTech
//
//  Created by Valter A. Machado on 3/7/20.
//  Copyright © 2020 Valter A. Machado. All rights reserved.
//

import UIKit
import LBTATools
import SwiftyJSON
import Alamofire
import AlamofireImage

class RestaurantsCell: UICollectionViewCell {
    private let cellID = "cellId"
    var restaurantData: [RestaurantModel] = []

    var images: [String]? {
        didSet{
            collectionView.reloadData()
        }
    }
    var names: [String]? {
        didSet{
            collectionView.reloadData()
        }
    }
    var addresses: [String]? {
        didSet{
            collectionView.reloadData()
        }
    }
    var descriptions: [String]? {
        didSet{
            collectionView.reloadData()
        }
    }
    var reviews: [String]? {
        didSet{
            collectionView.reloadData()
        }
    }
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        
        cv.backgroundColor = .clear
        cv.delegate = self
        cv.dataSource = self
        cv.register(RestaurantIconsCell.self, forCellWithReuseIdentifier: cellID)
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
        //             contentView.backgroundColor = .blue
        fetchJSONData()
    }
    
    fileprivate func setupView(){
        [collectionView].forEach({contentView.addSubview($0)})
        
        collectionView.anchor(top: contentView.safeAreaLayoutGuide.topAnchor, leading: contentView.leadingAnchor, bottom: contentView.safeAreaLayoutGuide.bottomAnchor, trailing: contentView.trailingAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RestaurantsCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func fetchJSONData(){
        
        let headers = [
            // API Key (required)
            "Authorization": "Bearer wQKtA45T2f-q8QSMNFqLWS742ZbSig_f7FyMO63Pg9SMwLa7SocGyC1fpqnfI0hnaLjUKB5JPNFKwzXLClt7EXm5p1haIxFrjBQ79CMxGvFB9QqpFzkdvwAxHdxsXnYx"
        ]
        
        let url = "https://api.yelp.com/v3/businesses/search?location=baguiocity&term=restaurants"
        
        DispatchQueue.main.async {
            
            Alamofire.request(url, method: .get, headers: headers)
                .responseJSON { response in
                    
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        json["businesses"].array?.forEach({ (restaurant) in
                            let spotsLocationNested = restaurant["location"]["address1"]
                            
                            let restaurantLat = restaurant["coordinates"]["latitude"]
                            let restaurantLong = restaurant["coordinates"]["longitude"]
                            
                            //                        print(nested)
                            let restaurantDetails = RestaurantModel(name: restaurant["name"].stringValue, location: spotsLocationNested.stringValue, rating: restaurant["rating"].double, image_url: restaurant["image_url"].stringValue, phone: restaurant["phone"].stringValue, latitude: restaurantLat.float, longitude: restaurantLong.float)
                            
                            self.restaurantData.append(restaurantDetails)
                            //                        print(hotels)
                        })
                        self.collectionView.reloadData()
                        
                        
                    case .failure(let error):
                        print(error)
                    }
            }
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return restaurantData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! RestaurantIconsCell
        
        cell.name.text = self.restaurantData[indexPath.item].name?.maxLength(length: 15)
        
        DispatchQueue.main.async {
            if let imageUrl = self.restaurantData[indexPath.item].image_url{
                Alamofire.request(imageUrl).responseImage { (response) in
                    if let image = response.result.value {
                        cell.coverImageView.image = image
                    }
                }
            }
        }
        cell.rating.text = "\(self.restaurantData[indexPath.item].rating ?? 0) ★"
        cell.address.text = self.restaurantData[indexPath.item].location?.maxLength(length: 18)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 125, height: frame.height - 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let homeVCDetails = HomeVCDetails()
        
        //        homeVCDetails.hotelName.text = "Hotels:\(indexPath.item)"
        if let imageUrl = restaurantData[indexPath.item].image_url{
            Alamofire.request(imageUrl).responseImage { (response) in
                if let image = response.result.value {
                    homeVCDetails.imageView.image = image
                }
            }
        }
        
        homeVCDetails.name.text = restaurantData[indexPath.item].name
        homeVCDetails.address.text = restaurantData[indexPath.item].location
        homeVCDetails.phone.text = restaurantData[indexPath.item].phone
        homeVCDetails.review.text = "\(restaurantData[indexPath.item].rating ?? 0) ★"
        
        homeVCDetails.latitude.text = "\(restaurantData[indexPath.item].latitude ?? 0)"
        homeVCDetails.longitude.text = "\(restaurantData[indexPath.item].longitude ?? 0)"

        let navigationController = UINavigationController(rootViewController: homeVCDetails)
        self.window?.rootViewController?.present(navigationController, animated: true, completion: nil)
        print("Restaurants:\(indexPath.item)")
    }
}

// restaurant icons cell
class RestaurantIconsCell: UICollectionViewCell {
    // image
    lazy var coverImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        //        iv.backgroundColor = .blue
        //        iv.contentMode = .scaleAspectFill
        //        iv.sizeToFit()
        //        iv.contentMode = .scaleToFill
        
        return iv
    }()
    // name
    lazy var name: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
//        lbl.backgroundColor = .blue
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0 // 0 = as many lines as the label needs
        lbl.frame.origin.x = 32
        lbl.frame.origin.y = 32
        lbl.frame.size.width = self.bounds.width - 64
        lbl.font = UIFont.boldSystemFont(ofSize: 13) // my UIFont extension
        lbl.sizeToFit()
        
        return lbl
    }()
    // address
    lazy var address: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
//        lbl.backgroundColor = .purple
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0 // 0 = as many lines as the label needs
        lbl.frame.origin.x = 32
        lbl.frame.origin.y = 32
        lbl.frame.size.width = self.bounds.width - 64
        lbl.font = UIFont.boldSystemFont(ofSize: 13) // my UIFont extension
        lbl.textColor = UIColor.lightGray
        lbl.sizeToFit()
        
        return lbl
    }()
    // place info
    lazy var placeDescription: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0 // 0 = as many lines as the label needs
        lbl.frame.origin.x = 32
        lbl.frame.origin.y = 32
        lbl.frame.size.width = self.bounds.width - 64
        lbl.font = UIFont.boldSystemFont(ofSize: 13) // my UIFont extension
        lbl.textColor = UIColor.lightGray
        lbl.sizeToFit()
        //        lbl.backgroundColor = .systemPink
        
        return lbl
    }()
    // stars (convert it from string to int)
    lazy var rating: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .rgb(red: 101, green: 183, blue: 180)

        return lbl
    }()
    
    lazy var stackView1: UIStackView = {
        var sv = UIStackView(arrangedSubviews: [name, address])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.spacing = 0
        //        sv.alignment = .center
        sv.distribution = .equalSpacing
        //        sv.addBackground(color: .green)
        
        return sv
    }()
    
    lazy var stackView2: UIStackView = {
        var sv = UIStackView(arrangedSubviews: [coverImageView])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.spacing = 0
        //        sv.alignment = .center
        sv.distribution = .equalSpacing
        //        sv.addBackground(color: .green)
        
        return sv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
        //        contentView.backgroundColor = .red
        self.layer.cornerRadius = 15
        //                self.layer.borderWidth = 1.0
        //                self.layer.borderColor = UIColor.lightGray.cgColor
        //
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 1.0
        self.layer.masksToBounds = false
    }
    
    fileprivate func setupView(){
        [stackView1, stackView2].forEach({contentView.addSubview($0)})
        
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 15
        
        stackView2.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 105))
        
        stackView1.anchor(top: stackView2.bottomAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor, padding:  UIEdgeInsets(top: 10, left: 10, bottom: 15, right: 10))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
