//
//  TrashBinCode.swift
//  GuideTech
//
//  Created by Valter A. Machado on 3/10/20.
//  Copyright © 2020 Valter A. Machado. All rights reserved.
//

import Foundation

// MARK: OLD VOICEMAPPINGVC
//class VoiceMappingVC: UIViewController {
//
//
//    // MARK: - Properties
//    let regionInMeters: Double = 10000
//
//    let locationDictionary = ["Statu of Liberty": FlyoverAwesomePlace.newYorkStatueOfLiberty, "New York": FlyoverAwesomePlace.newYork]
//
//    lazy var mapView: MKMapView = {
//        let mp = MKMapView()
//        mp.showsUserLocation = true
//        mp.delegate = self
//        mp.userLocation.title = "Me"
//        return mp
//    }()
//
//    lazy var placeLbl: UILabel = {
//        let lbl = UILabel()
//        lbl.textColor = .darkGray
//        lbl.font = .boldSystemFont(ofSize: 18)
//        lbl.text = "Dummy text"
//        return lbl
//    }()
//
//    lazy var startTourBtn: UIButton = {
//        let btn = UIButton(type: .system)
//        btn.translatesAutoresizingMaskIntoConstraints = false
//        btn.setTitle("Start", for: .normal)
//        btn.titleLabel?.font = .boldSystemFont(ofSize: 20)
//        btn.tintColor = .rgb(red: 101, green: 183, blue: 180)
//        btn.addTarget(self, action: #selector(startTourBtnPressed), for: .touchUpInside)
//        return btn
//    }()
//
//    lazy var cancelBtn: UIButton = {
//        let btn = UIButton(type: .system)
//        btn.translatesAutoresizingMaskIntoConstraints = false
//        btn.setImage(UIImage(systemName: "multiply.circle.fill"), for: .normal)
//        btn.titleLabel?.font = .boldSystemFont(ofSize: 20)
//        btn.tintColor = .rgb(red: 101, green: 183, blue: 180)
//        btn.addTarget(self, action: #selector(cancelBtnPressed), for: .touchUpInside)
//        return btn
//    }()
//
//    lazy var stackView: UIStackView = {
//        var sv = UIStackView(arrangedSubviews: [mapView, startTourBtn, placeLbl])
//        sv.translatesAutoresizingMaskIntoConstraints = false
//        sv.axis = .vertical
//        sv.spacing = 5
//        //   sv.contentMode = .scaleToFill
//        sv.alignment = .center
//        sv.distribution = .equalSpacing
//        //  sv.addBackground(color: .gray)
//        return sv
//    }()
//
//    // MARK: - Init
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//        setupView()
//        setupMap()
//    }
//
//    // MARK: - Handlers (functions/methods)
//    @objc func cancelBtnPressed(){
//        dismiss(animated: true, completion: nil)
//    }
//
//    @objc fileprivate func startTourBtnPressed(){
//        print("123")
////        let rand = locationDictionary.randomElement()
//        let eiffelTower = CLLocationCoordinate2D(latitude: 16.411339, longitude: 120.594360)
//
//        let camera = FlyoverCamera(mapView: mapView, configuration: FlyoverCamera.Configuration(duration: 6.0, altitude: 10, pitch: 45.0, headingStep: 40.0))
//        camera.start(flyover: eiffelTower)
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(6)) {
//            camera.stop()
//        }
////        placeLbl.text = "\(eiffelTower ?? 0.0)"
//    }
//
//    func setupView(){
//        [stackView].forEach({view.addSubview($0)})
//        let cancelBtnItem = UIBarButtonItem(customView: cancelBtn)
//        navigationItem.leftBarButtonItem =  cancelBtnItem
//        navigationItem.title = "Voice Mapping"
////        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
////        navigationController?.navigationBar.hideNavBarSeperator()
//        mapView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: CGSize(width: 0, height: view.frame.height/1.3))
//    }
//
//}
//
//extension VoiceMappingVC: MKMapViewDelegate {
//
//    fileprivate func setupMap(){
//        self.mapView.mapType = .hybridFlyover
//        self.mapView.showsBuildings = true
//        self.mapView.isZoomEnabled = true
//        self.mapView.isScrollEnabled = true
//    }
//
//}

//**




//// hotel arrays
//    let imageArray = ["image1.jpg", "image2.jpg", "image3.jpg"]
////    let nameArray = ["Venis", "CityLights", "Porta Vaga", "m"]
//    var nameArray = [String: AnyObject]()
//    let addressArray = ["Address", "Address", "Address"]
//    let priceArray = ["$100", "$100", "$100"]
//    let reviewArray = [String: AnyObject]()
//
//    // tourist Spot arrays
//    let imageArray2 = ["park1.jpg", "park2.jpg", "park3.jpg"]
//    let nameArray2 = ["Burnham Park", "Session Road", "The Mansion"]
//    let descriptionArray = ["is a historic urban park located in downtown Baguio.", "The road forms part of the National Route 231 of the Philippine highway network.", "The mansion is located in the summer capital of the country."]
//    let reviewArray2 = ["5 ★", "5 ★", "5 ★"]
//    let addressArray2 = ["Address", "Address", "Address"]
//
//    // restaurant arrays
//    let imageArray3 = ["restaurant1.jpg", "restaurant2.jpg", "restaurant3.jpg"]
//    let nameArray3 = ["Craft 1945", "Le Chef", "Secret Garden"]
//    let descriptionArray2 = ["is a historic urban park located in downtown Baguio.", "The road forms part of the National Route 231 of the Philippine highway network.", "The mansion is located in the summer capital of the country."]
//    let reviewArray3 = ["5 ★", "5 ★", "5 ★"]
//    let addressArray3 = ["Address", "Address", "Address"]
//    

//    var textlabel = UILabel()
//
//    var images = [[String: AnyObject]]()
//
//    //    var images: [String]? {
//    //        didSet{
//    //           collectionView.reloadData()
//    //        }
//    //    }
//    //    let names2 = ["Venis", "CityLights", "Porta Vaga", "m", "er"]
//
//    //    var names: [String: Any]? {
//    //        didSet{
//    //           collectionView.reloadData()
//    //        }
//    //    }
//    var names = [[String: AnyObject]]()
//
//    //    var addresses: [String]? {
//    //        didSet{
//    //           collectionView.reloadData()
//    //        }
//    //    }
//    var addresses = [[String: AnyObject]]()
//
//    var prices: [String]? {
//        didSet{
//            collectionView.reloadData()
//        }
//    }
//
//    var reviews = [[String: AnyObject]]()
//
//    //    var reviews: [String]? {
//    //        didSet{
//    //           collectionView.reloadData()
//    //        }
//    //    }
//
//    var reviewStars: Int? = nil


//        let parameter = [
//            "locale": "en_US",
//               "children1": "5%2C11",
//               "currency": "USD",
//               "checkOut": "2020-01-15",
//               "adults1": "1",
//               "checkIn": "2020-01-08",
//               "id": "424023"
//
//        ]
        // MARK: API ongoing
//        let url = "http://engine.hotellook.com/api/v2/lookup.json?query=baguio&lang=ph&lookFor=hotel&limit=1&token=3d8bb509add7ca310546f2b400129cc2"
        
//        let url2 = "https://hotels4.p.rapidapi.com/properties/get-details"

//                    print(json["businesses"])
                    
//                    print(json["hotels"][100]["name"])
//                    if let hotels = json["hotels"] as? JSON{
////                        if let name = hotels["name"] as? JSON{
//                            print(hotels)
////                        }
//                    }
//
//                    for (_, subJson) in json["hotels"] {
//                        if let title = subJson["name"]["en"].string {
//                            print(title)
////                            self.names = title
//////                            print(hotelDetails)
////                            if self.names.count > 0 {
////                                self.collectionView.reloadData()
////                            }
//                        }
//                    }


//                if let JSONObject = response.value as? [String:AnyObject] {
//                print(JSON["pois"] as Any)
//                let hotelDetails = JSON["results"]!["hotels"]!!

//                let hotelDetails = JSON["hotels"]

/// Getting hotel [name] request
//                    for hotelNames in (JSONObject["hotels"]?.dictionaryWithValues(forKeys: ["name"]))!{
//                        self.names = hotelNames.value as! [[String : AnyObject]]
////                                            print(self.names)
////                        self.names = hotelDetails as! [[String : AnyObject]]
//                        if self.names.count > 0 {
//                            self.collectionView.reloadData()
//                        }
//                    }
/// Getting hotel [address] request
//                    for hotelAddresses in (JSONObject["hotels"]?.dictionaryWithValues(forKeys: ["address"]))!{
//                        self.addresses = hotelAddresses.value as! [[String : AnyObject]]
////                        print(hotelAddresses)
//                        if self.addresses.count > 0 {
//                            self.collectionView.reloadData()
//                        }
//                    }
/// Getting hotelList
//                    let hotelStars = JSONObject["hotels"]
////                                            print(hotelStars)
//                    self.reviews = hotelStars as! [[String : AnyObject]]
//                    if self.reviews.count > 0 {
//                        self.collectionView.reloadData()
//                    }


// works slightly
//                    for hotelImages in (JSONObject["hotels"]?.dictionaryWithValues(forKeys: ["photos"]))!{
//                        self.images = hotelImages.value as! [[String : AnyObject]]
//                        let tryout = JSON(hotelImages.value)
//                        self.images = tryout.dictionary
//                        debugPrint(hotelImages)
//                    }


//                }

//        if let imageName = images?[indexPath.row]{
//            cell.coverImageView.image = UIImage(named: imageName)
//        }
//        let index = names[indexPath.row]
//        let index2 = addresses[indexPath.row]
//        let index3 = reviews[indexPath.row]
//        collectionView.backgroundColor = .red

//        let arrayOfNames = names[indexPath.row]

//        let starsInt = index3["stars"] as? Int
////        if starsInt ?? 0 >= 2 {
//        cell.name.text = (index["en"] as? String)?.maxLength(length: 20)
//        cell.address.text = (index2["en"] as? String)?.maxLength(length: 20)
//        cell.review.text = "\(starsInt ?? 0) ★"
//        cell.coverImageView.image = UIImage(named: imageName)

//        }

//    func fetchJSONData(){
//
//        //        let header = [
//        //            "cityName": "Baguio",
//        //            "countryCode": "PH",
//        //            "countryName": "Philippines",
//        //        ]
//        //
//        //        let parameters: Parameters = [
//        //            //            "id": "424023"
//        //            "countryName": "Philippines"
//        //        ]
//        //
//        // MARK: API ongoing
//        let url = "http://engine.hotellook.com/api/v2/lookup.json?query=baguiocity&lang=ph&lookFor=both&limit=1&token=PasteYourTokenHere"
//
//
//        Alamofire.request(url, method: .get)
//            .responseJSON { (response) in
//                //                debugPrint(response)
//                if let responseValue = response.result.value as! [String: Any]?{
//                    //                    print(responseValue)
//                    if let responseHotels = responseValue["results"] as! [String:Any]?{
////                        self.nameArray = responseHotels
////                        print(responseHotels)
//                    }
//                }
//        }
//
//    }




//        let headers: HTTPHeaders = [
////            "x-rapidapi-host": "tripadvisor1.p.rapidapi.com",
////            "x-rapidapi-key": "d681da975cmsh96f870b28c81334p15a2a3jsna9db3bed0d9a"
////            "Content-Type": "application/json",
////            "Accept": "application/json",
//            "x-rapidapi-host": "hotels4.p.rapidapi.com",
//            "x-rapidapi-key": "d681da975cmsh96f870b28c81334p15a2a3jsna9db3bed0d9a"
//        ]


//                if let data = response.data {
//                    print(String(data: data, encoding: .utf8) ?? "")
//                }
//                if let JSON = response.result.value{
//                    var jsonObject = JSON as! [String:Any]
////                    var origin = jsonObject["origin"] as! String
////                    var url = jsonObject["url"] as! String
//                    print("JSON: \(jsonObject)")
////                    print("Origin:\(origin)")
//                    print("Request:\(url)")
//                }
//                 print("Response.result.value \(response.result.value!)")



//            .responseJSON { (response) in
//                switch response.result {
//                case .success(let value):
//                    if let JSON = value as? [String: Any] {
//                        let status = JSON["status"] as! String
//                        print(status)
//                    }
//                case .failure(let error): break
//                    // error handling
//                }
//
//        // 2
//
//    }
//    request.responseJSON { (data) in
//        print(data)
//
//    }
//        let headers = [
//            "x-rapidapi-host": "hotels4.p.rapidapi.com",
//            "x-rapidapi-key": "d681da975cmsh96f870b28c81334p15a2a3jsna9db3bed0d9a"
//        ]
//
//        let request = NSMutableURLRequest(url: NSURL(string: "https://hotels4.p.rapidapi.com/properties/get-details?locale=en_US&children1=5%252C11&currency=USD&checkOut=2020-01-15&adults1=1&checkIn=2020-01-08&id=424023")! as URL,
//                                                cachePolicy: .useProtocolCachePolicy,
//                                            timeoutInterval: 10.0)
//        // Specify the body
////        let jsonObject = ["data":""]
////        request.httpMethod = "GET"
////        request.allHTTPHeaderFields = headers
////
////        do{
////            let requestBody = try JSONSerialization.data(withJSONObject: jsonObject, options: .fragmentsAllowed)
////            request.httpBody = requestBody
////        }
////        catch{
////            print("error object json")
////        }
//
//        let session = URLSession.shared
//        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
//            if (error != nil) {
//                print(error)
//            } else {
//                let httpResponse = response as? HTTPURLResponse
//                print(httpResponse)
//            }
//        })
//
//        dataTask.resume()



//        // URL
//        let url = URL(string: "https://hotels4.p.rapidapi.com/properties/list?currency=USD&starRatings=2%252C3&checkIn=2020-01-08&children1=5%252C11&locale=en_US&checkOut=2020-01-15&sortOrder=PRICE&destinationId=1506246&type=CITY&pageNumber=1&pageSize=25&adults1=1")
//
//        guard url != nil else {
//            print("Error creating url object")
//            return
//        }
//
//        // URL Request
//        var request = URLRequest(url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
//
//        // Specify the header
//        let header = [
//        "x-rapidapi-host": "hotels4.p.rapidapi.com",
//        "x-rapidapi-key": "d681da975cmsh96f870b28c81334p15a2a3jsna9db3bed0d9a",
//        "content-type": "application/json"
//        ]
//
//        request.allHTTPHeaderFields = header
//
//        // Specify the body
//        let jsonObject = ["url": "https://hotels4.p.rapidapi.com/properties/list"]
//
//        do{
//            let requestBody = try JSONSerialization.data(withJSONObject: jsonObject, options: .fragmentsAllowed)
//            request.httpBody = requestBody
//        }
//        catch{
//            print("error object json")
//        }
//        // Set the resquest type
//        request.httpMethod = "GET"
//
//        // Get URLSession
//        let session = URLSession.shared
//
//        // Create the data task
//        let dataTask = session.dataTask(with: request) { (data, response, error) in
//            if error == nil && data != nil {
//                do{
//                    let dictionary = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String: Any]
//                    print(dictionary)
//                }
//                catch{
//                    print("response error")
//                }
//            }
//        }
//
//        // Fire off the data task
//        dataTask.resume()
