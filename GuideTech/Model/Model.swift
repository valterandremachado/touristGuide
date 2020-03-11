//
//  Model.swift
//  GuideTech
//
//  Created by Valter A. Machado on 3/8/20.
//  Copyright © 2020 Valter A. Machado. All rights reserved.
//

import UIKit

struct Hotel: Decodable {
    let id: Int
    let name: String
    let imageUrl: String
    let address: String
    let price: Int
    let rate: Int
}

struct TouristSpot: Decodable {
    let id: Int
    let name: String
    let imageUrl: String
    let address: String
    let rate: Int
}

struct Restaurant: Decodable {
    let id: Int
    let name: String
    let imageUrl: String
    let address: String
    let rate: Int
}

struct BusStop: Decodable {
    let id: Int
    let name: String
    let address: String
    let rate: Int
}
