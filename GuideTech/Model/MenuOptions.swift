//
//  MenuOptions.swift
//  GuideTech
//
//  Created by Valter A. Machado on 3/16/20.
//  Copyright © 2020 Valter A. Machado. All rights reserved.
//

import UIKit

enum MenuOptions: Int, CustomStringConvertible {
    
    case VoiceMapping
    case Settings
    case HelpCenter
    case Logout
    
    var description: String {
        switch self {
        case .VoiceMapping: return "Voice Mapping"
        case .Settings: return "Settings"
        case .HelpCenter: return "Help Center"
        case .Logout: return "Logout"
        }
    }
    
    var image: UIImage {
        switch self {
        case .VoiceMapping: return UIImage(systemName: "map") ?? UIImage()
        case .Settings: return UIImage(systemName: "gear") ?? UIImage()
        case .HelpCenter: return UIImage(systemName: "questionmark.circle.fill") ?? UIImage()
        case .Logout: return UIImage(systemName: "return") ?? UIImage()
        }
    }
    
    
}
