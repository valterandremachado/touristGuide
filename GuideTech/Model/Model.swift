//
//  Model.swift
//  GuideTech
//
//  Created by Valter A. Machado on 3/8/20.
//  Copyright © 2020 Valter A. Machado. All rights reserved.
//

import UIKit


struct HotelsModel {
    var name: String?
    var location: String?
    var rating: Double?
    var image_url: String?
    var price: String?
    var phone: String?
    var latitude: Float?
    var longitude: Float?
}

struct TouristSpotModel {
    var name: String?
    var location: String?
    var rating: Double?
    var image_url: String?
    var latitude: Float?
    var longitude: Float?
}

struct RestaurantModel {
    var name: String?
    var location: String?
    var rating: Double?
    var image_url: String?
    var phone: String?
    var coordinates: Float?
    var latitude: Float?
    var longitude: Float?
}

struct BusStopModel {
    var name: String?
    var location: String?
}
