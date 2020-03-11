//
//  HotelsCell.swift
//  GuideTech
//
//  Created by Valter A. Machado on 3/7/20.
//  Copyright © 2020 Valter A. Machado. All rights reserved.
//

import UIKit
import LBTATools
import Alamofire
import SwiftyJSON

struct Hotels: Decodable {
    let id: Int
    let fullName: String
    let label: String
    
}

class HotelsCell: UICollectionViewCell {
    
    var nameArray = [String:Any]()

    private let cellID = "cellId"
    var textlabel = UILabel()
    
    var images: [String]? {
        didSet{
           collectionView.reloadData()
        }
    }
//    let names2 = ["Venis", "CityLights", "Porta Vaga", "m", "er"]

//    var names: [String: Any]? {
//        didSet{
//           collectionView.reloadData()
//        }
//    }
    var names = [[String: AnyObject]]()
    
    var addresses: [String]? {
        didSet{
           collectionView.reloadData()
        }
    }
    var prices: [String]? {
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
//        cv.layer.shadowColor = UIColor.black.cgColor
//        cv.layer.shadowOffset = CGSize(width: 0, height: 1)
//        cv.layer.shadowOpacity = 1
//        cv.layer.shadowRadius = 1.0
//        cv.clipsToBounds = false
//        cv.layer.masksToBounds = false
        
        cv.backgroundColor = .clear
        cv.delegate = self
        cv.dataSource = self
        cv.register(HotelIconsCell.self, forCellWithReuseIdentifier: cellID)
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
            setupView()
//        contentView.backgroundColor = .blue
        fetchJSONData()
    }
        
   fileprivate  func setupView(){
        [collectionView].forEach({contentView.addSubview($0)})

        collectionView.anchor(top: contentView.safeAreaLayoutGuide.topAnchor, leading: contentView.leadingAnchor, bottom: contentView.safeAreaLayoutGuide.bottomAnchor, trailing: contentView.trailingAnchor)
    }
        
    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
}
}

extension HotelsCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func fetchJSONData(){
        
        let parameter = [
            "locale": "en_US",
               "children1": "5%2C11",
               "currency": "USD",
               "checkOut": "2020-01-15",
               "adults1": "1",
               "checkIn": "2020-01-08",
               "id": "424023"
            
        ]
        // MARK: API ongoing
        let url = "http://engine.hotellook.com/api/v2/lookup.json?query=baguio&lang=ph&lookFor=hotel&limit=1&token=3d8bb509add7ca310546f2b400129cc2"
        
//        let url2 = "https://hotels4.p.rapidapi.com/properties/get-details"
//        let headers = [
//            "x-rapidapi-host": "hotels4.p.rapidapi.com",
//             "x-rapidapi-key": "d681da975cmsh96f870b28c81334p15a2a3jsna9db3bed0d9a"
//        ]
        
        let url3 = "http://engine.hotellook.com/api/v2/static/hotels.json?locationId=24530&token=3d8bb509add7ca310546f2b400129cc2"
        
        Alamofire.request(url3, method: .get, encoding: JSONEncoding.default)
            .responseJSON { (response) in

               if let JSON = response.result.value as? [String:AnyObject] {
//                print(JSON["pois"] as Any)
//                let hotelDetails = JSON["results"]!["hotels"]!!
                let hotelDetails = JSON["hotels"]
//
                self.names = hotelDetails as! [[String : AnyObject]]
//                if let nestedDictionary1 = JSON["results"] as? [String: AnyObject] {
//                    // access individual value in dictionary
//
//                    if let views = nestedDictionary1["hotels"] as? String {
//                         print(JSON)
//                    }
//                }
                }
//                if let responseValue = response.result.value as! [String: AnyObject]?{
//
//                    if let responseHotels = responseValue["results"] as! [String: AnyObject]? {
////                        self.names = [responseHotels]
//                        for dic in self.names {
//                               let agreementId = dic["hotels"] as? String ?? "N/A"//Set default value instead N/A
//                               print(agreementId)
//                               //access the other key-value same way
//                           }
//
//                    }
//
                    if self.names.count > 0 {
//                        print(self.names)
                        self.collectionView.reloadData()
                    }
//                }
        }
        
    }
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return names.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! HotelIconsCell
        
//        if let imageName = images?[indexPath.item]{
//            cell.coverImageView.image = UIImage(named: imageName)
//        }
        let index = names[indexPath.row]
        
//        let arrayOfNames = names[indexPath.row]
        
        let starsInt = index["stars"] as? Int
        if starsInt ?? 0 >= 3 {
        cell.name.text = index["checkIn"] as? String
        cell.review.text = "\(starsInt ?? 0) ★"
        }
//        print(arrayOfNames["name"] as? String)
//         let names = names[indexPath.item]
//            cell.name.text = names


//        if self.names.count > 0 {
//            let eachHotel = self.names[indexPath.row]
//            cell.name.text = (eachHotel["label"] as? String) ?? "N/A"
//            print(eachHotel)
//        }
        
//        if let addresses = addresses?[indexPath.item]{
//            cell.address.text = addresses
//        }
        
//        if let prices = prices?[indexPath.item]{
//            cell.pricePerNight.text = prices
//        }
//
//        if let reviews = reviews?[indexPath.item]{
//            cell.review.text = reviews
//        }
//        cell.coverImageView.backgroundColor = .blue
//        cell.name.backgroundColor = .blue
//        cell.address.backgroundColor = .blue
//        cell.stackView1.addBackground(color: stackViewColor)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 135, height: frame.height - 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Hotels:\(indexPath.item)")
    }
}




// MARK: icons cell (cell that will provide the data)
class HotelIconsCell: UICollectionViewCell {
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
        lbl.textColor = UIColor.black
        lbl.sizeToFit()
        return lbl
    }()
    // address
    lazy var address: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
//        lbl.backgroundColor = .purple
        lbl.textColor = .lightGray

        return lbl
    }()
    // price per night (convert it from string to int)
    lazy var pricePerNight: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    // stars (convert it from string to int)
    lazy var review: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var stackView1: UIStackView = {
        var sv = UIStackView(arrangedSubviews: [name, address, stackView2])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.spacing = 2
        //        sv.alignment = .center
        sv.distribution = .equalSpacing
//        sv.addBackground(color: .green)
        
        return sv
    }()
    
    lazy var stackView2: UIStackView = {
        var sv = UIStackView(arrangedSubviews: [pricePerNight, review])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.spacing = -10
        //        sv.alignment = .center
        sv.distribution = .equalSpacing
//        sv.addBackground(color: .lightGray)
        
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
        [stackView1, coverImageView].forEach({contentView.addSubview($0)})
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 15
        stackView1.anchor(top: coverImageView.bottomAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor, padding:  UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        
        coverImageView.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 105))
        
//        name.anchor(top: coverImageView.bottomAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 25))
//
//        address.anchor(top: name.bottomAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 25))
//
//        stackView2.anchor(top: address.bottomAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0))
//        name.anchor(top: coverImageView.bottomAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 0))
//        coverImageView.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
