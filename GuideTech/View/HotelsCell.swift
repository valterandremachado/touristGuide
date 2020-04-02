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
import AlamofireImage
import Firebase


class HotelsCell: UICollectionViewCell {
    weak var delegate:HomeVCDetails?

    var hotelsData: [HotelsModel] = []
    
    private let cellID = "cellId"

    
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
    
    var scheduledTimer: Timer? //.scheduledTimer(timeInterval: 0.4, target: self,selector: #selector(fetchJSONData), userInfo: nil, repeats: true)
    private var indicator: ProgressIndicatorLarge?

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupActivityIndicator()
        setupView()
        fetchJSONData()
    }
    
    func startTimer () {
      guard scheduledTimer == nil else { return }

      scheduledTimer =  Timer.scheduledTimer(
          timeInterval: TimeInterval(1),
          target      : self,
          selector    : #selector(fetchJSONData),
          userInfo    : nil,
          repeats     : true)
        hotelsData.removeAll()
        print("startTimer")
    }
    
    func stopTimerTest() {
        scheduledTimer?.invalidate()
        scheduledTimer = nil
        print("stopTimerTest")
        
    }
    
    fileprivate func setupActivityIndicator(){
        // Setting up activity indicator
        indicator = ProgressIndicatorLarge(inview: self,loadingViewColor: UIColor.clear, indicatorColor: UIColor.black, msg: "")
//        indicator?.isHidden = true
    }
    
    
    fileprivate  func setupView(){
        [collectionView, indicator!].forEach({contentView.addSubview($0)})
        
        let screenRect = UIScreen.main.bounds
        let screenWidth = screenRect.size.width
        //        let screenHeight = screenRect.size.height
        
        indicator?.anchor(top: collectionView.topAnchor, leading: contentView.leadingAnchor, bottom: collectionView.bottomAnchor, trailing: contentView.trailingAnchor, padding: UIEdgeInsets(top: 110, left: screenWidth/2 - 14, bottom: 110, right: screenWidth/2 - 14))
        
        collectionView.anchor(top: contentView.safeAreaLayoutGuide.topAnchor, leading: contentView.leadingAnchor, bottom: contentView.safeAreaLayoutGuide.bottomAnchor, trailing: contentView.trailingAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HotelsCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    @objc func fetchJSONData(){
        indicator?.start()
        let headers = [
            // API Key (required)
            "Authorization": "Bearer wQKtA45T2f-q8QSMNFqLWS742ZbSig_f7FyMO63Pg9SMwLa7SocGyC1fpqnfI0hnaLjUKB5JPNFKwzXLClt7EXm5p1haIxFrjBQ79CMxGvFB9QqpFzkdvwAxHdxsXnYx"
        ]
        
        let param = ["location": "baguiocity",
                     "term": "hotels" ]
        
        let url = "https://api.yelp.com/v3/businesses/search"
//        let url = "https://api.yelp.com/v3/businesses/search?find_desc=hotels&location=Baguio%2C%20Benguet%2C%20Philippines&start=20"
        
//        DispatchQueue.main.async {
//            let manager = Alamofire.SessionManager.default
//            manager.session.configuration.timeoutIntervalForRequest = 2
        
        Alamofire.request(url, method: .get, parameters: param, headers: headers)
                .responseJSON { response in
                   
                    //    guard let data = response.data else {return}
                    //    print(data)
                    //    print(response.result.value)
                    
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        
                        json["businesses"].array?.forEach({ (hotels) in
                            let hotelLocationNested = hotels["location"]["address1"]
                            
                            let hotelLat = hotels["coordinates"]["latitude"]
                            let hotelLong = hotels["coordinates"]["longitude"]
                            //                        print(nested)
                            let hotelsDetails = HotelsModel(name: hotels["name"].stringValue, location: hotelLocationNested.stringValue, rating: hotels["rating"].double, image_url: hotels["image_url"].stringValue, price: hotels["price"].stringValue, phone: hotels["phone"].stringValue, latitude: hotelLat.float, longitude: hotelLong.float)
                            
                            self.hotelsData.append(hotelsDetails)
                            //                        print(hotels)
                        })
                        self.indicator?.stop()
                        self.stopTimerTest()
                        self.collectionView.reloadData()
                        
                    case .failure(let error):
                        //                        let errorCode = error._code
                        //                        let errorDomain = error._domain
                        ////                        let userInfo = error._userInfo
                        //                        print("Request failed with error: \(error), code: \(errorCode), domain: \(errorDomain)")
                        ////                        failure(error)
                        self.indicator?.start()
                        self.startTimer()
                        print(error)
                    }
//            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return min(15, hotelsData.count) 
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! HotelIconsCell
        
        cell.name.text = self.hotelsData[indexPath.item].name
        
        DispatchQueue.main.async {
            if let imageUrl = self.hotelsData[indexPath.item].image_url{
                Alamofire.request(imageUrl).responseImage { (response) in
                    if let image = response.result.value {
                        cell.coverImageView.image = image
                    }
                }
            }
        }
        
        cell.rating.text = "\(self.hotelsData[indexPath.item].rating ?? 0) ★"
        cell.address.text = self.hotelsData[indexPath.item].location?.maxLength(length: 18)
        cell.pricePerNight.text = self.hotelsData[indexPath.item].price
        
//        cell.pricePerNight.text = self.hotelsData[indexPath.item].price
//        cell.pricePerNight.text = self.hotelsData[indexPath.item].price

//        cell.delegate = self

//        }
        
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
        if let imageUrl = hotelsData[indexPath.item].image_url{
            Alamofire.request(imageUrl).responseImage { (response) in
                if let image = response.result.value {
                    homeVCDetails.imageView.image = image
                }
            }
        }

        homeVCDetails.name.text = hotelsData[indexPath.item].name
        homeVCDetails.address.text = hotelsData[indexPath.item].location
        homeVCDetails.phone.text = hotelsData[indexPath.item].phone
        homeVCDetails.review.text = "\(hotelsData[indexPath.item].rating ?? 0) ★"
        
        homeVCDetails.latitude.text = "\(hotelsData[indexPath.item].latitude ?? 0)"
        homeVCDetails.longitude.text = "\(hotelsData[indexPath.item].longitude ?? 0)"
        
        let navigationController = UINavigationController(rootViewController: homeVCDetails)
        self.window?.rootViewController?.present(navigationController, animated: true, completion: nil)
//        self.window?.rootViewController?.navigationController?.pushViewController(navigationController, animated: true)

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
        //        lbl.textColor = .lightGray
        lbl.numberOfLines = 0 // 0 = as many lines as the label needs
        lbl.frame.origin.x = 32
        lbl.frame.origin.y = 32
        lbl.frame.size.width = self.bounds.width - 64
        lbl.font = UIFont.boldSystemFont(ofSize: 13) // my UIFont extension
        lbl.textColor = UIColor.lightGray
        lbl.sizeToFit()
        
        return lbl
    }()
    // price per night (convert it from string to int)
    lazy var pricePerNight: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .rgb(red: 101, green: 183, blue: 180)
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
        sv.spacing = 2
        //        sv.alignment = .center
        sv.distribution = .equalSpacing
        //        sv.addBackground(color: .green)
        
        return sv
    }()
    
    lazy var stackView2: UIStackView = {
        var sv = UIStackView(arrangedSubviews: [pricePerNight, rating])
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
