//
//  SettingsEnum.swift
//  GuideTech
//
//  Created by Valter A. Machado on 3/21/20.
//  Copyright © 2020 Valter A. Machado. All rights reserved.
//

import UIKit

enum SettingsEnum: Int, CustomStringConvertible {
    
    case Language
    case About
    
    var description: String {
        switch self {
        case .Language: return "Language"
        case .About: return "About"
        }
    }
    
}
