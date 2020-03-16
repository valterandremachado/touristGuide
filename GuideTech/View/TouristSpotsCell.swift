//
//  TouristSpotsCell.swift
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

class TouristSpotsCell: UICollectionViewCell {

    private let cellID = "cellId"
    
    var touristSpotData: [TouristSpotModel] = []
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.showsHorizontalScrollIndicator = false
        cv.delegate = self
        cv.dataSource = self
        cv.register(TouristSpotIconsCell.self, forCellWithReuseIdentifier: cellID)
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
            setupView()
//        contentView.backgroundColor = .blue
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

extension TouristSpotsCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    
    func fetchJSONData(){
        
        let headers = [
            // API Key (required)
            "Authorization": "Bearer wQKtA45T2f-q8QSMNFqLWS742ZbSig_f7FyMO63Pg9SMwLa7SocGyC1fpqnfI0hnaLjUKB5JPNFKwzXLClt7EXm5p1haIxFrjBQ79CMxGvFB9QqpFzkdvwAxHdxsXnYx"
        ]
        
        let url = "https://api.yelp.com/v3/businesses/search?location=baguiocity&term=tours"
        
        DispatchQueue.main.async {
            
            Alamofire.request(url, method: .get, headers: headers)
                .responseJSON { response in
                    
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        json["businesses"].array?.forEach({ (spots) in
                            let spotsLocationNested = spots["location"]["address1"]
                            
                            let spotLat = spots["coordinates"]["latitude"]
                            let spotLong = spots["coordinates"]["longitude"]
                            
                            //                        print(nested)
                            let spotsDetails = TouristSpotModel(name: spots["name"].stringValue, location: spotsLocationNested.stringValue, rating: spots["rating"].double, image_url: spots["image_url"].stringValue, latitude: spotLat.float, longitude: spotLong.float)
                            
                            self.touristSpotData.append(spotsDetails)
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
        return touristSpotData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! TouristSpotIconsCell
       
        cell.name.text = self.touristSpotData[indexPath.item].name?.maxLength(length: 15)
        
        if let imageUrl = self.touristSpotData[indexPath.item].image_url{
            Alamofire.request(imageUrl).responseImage { (response) in
                if let image = response.result.value {
                    cell.coverImageView.image = image
                }
            }
        }
        cell.rating.text = "\(self.touristSpotData[indexPath.item].rating ?? 0) ★"
        cell.address.text = self.touristSpotData[indexPath.item].location?.maxLength(length: 15)
//        cell.pricePerNight.text = self.touristSpotData[indexPath.item].price
        
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
        if let imageUrl = touristSpotData[indexPath.item].image_url{
            Alamofire.request(imageUrl).responseImage { (response) in
                if let image = response.result.value {
                    homeVCDetails.imageView.image = image
                }
            }
        }
        
        homeVCDetails.name.text = touristSpotData[indexPath.item].name
        homeVCDetails.address.text = touristSpotData[indexPath.item].location
//        homeVCDetails.hotelPhone.text = touristSpotData[indexPath.item].phone
        homeVCDetails.review.text = "\(touristSpotData[indexPath.item].rating ?? 0) ★"
        
        homeVCDetails.latitude.text = "\(touristSpotData[indexPath.item].latitude ?? 0)"
        homeVCDetails.longitude.text = "\(touristSpotData[indexPath.item].longitude ?? 0)"
        
        let navigationController = UINavigationController(rootViewController: homeVCDetails)
        self.window?.rootViewController?.present(navigationController, animated: true, completion: nil)
        print("Tourist: \(indexPath.item)")
    }
}


// tourist spots icons cell
class TouristSpotIconsCell: UICollectionViewCell {
    // image
    lazy var coverImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
//        iv.backgroundColor = .blue
//        iv.contentMode = .scaleAspectFit
        iv.sizeToFit()
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
        lbl.textColor = .lightGray
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0 // 0 = as many lines as the label needs
        lbl.frame.origin.x = 32
        lbl.frame.origin.y = 32
        lbl.frame.size.width = self.bounds.width - 64
        lbl.font = UIFont.boldSystemFont(ofSize: 13) // my UIFont extension
        lbl.sizeToFit()
        lbl.text = "Baguio City"
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
//        lbl.backgroundColor = .yellow
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
        //    contentView.backgroundColor = .red
        self.layer.cornerRadius = 15
        //  self.layer.borderWidth = 1.0
        //     self.layer.borderColor = UIColor.lightGray.cgColor
    
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
