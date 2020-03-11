//
//  TrashBinCode.swift
//  GuideTech
//
//  Created by Valter A. Machado on 3/10/20.
//  Copyright © 2020 Valter A. Machado. All rights reserved.
//

import Foundation

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
