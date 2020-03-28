//
//  AppearEnum.swift
//  GuideTech
//
//  Created by Valter A. Machado on 3/21/20.
//  Copyright © 2020 Valter A. Machado. All rights reserved.
//

import UIKit

enum AppearEnum: Int, CustomStringConvertible {
    
    case Automatic
    case Dark
    case Light

    var description: String {
        switch self {
        case .Automatic: return "Automatic"
        case .Dark: return "Dark"
        case .Light: return "Light"
        }
    }
    
}
