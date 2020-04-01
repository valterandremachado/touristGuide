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
        case .VoiceMapping:
            let iconImage = UIImage(systemName: "map")
            let flippedIconImage = UIImage(systemName: "map")?.imageFlippedForRightToLeftLayoutDirection()
            
            if preferredLanguage == "ar" {
                return flippedIconImage ?? UIImage()
            }
            
            return iconImage ?? UIImage()
            
        case .Settings:
            let iconImage = UIImage(systemName: "gear")
            let flippedIconImage = UIImage(systemName: "gear")?.imageFlippedForRightToLeftLayoutDirection()
            
            if preferredLanguage == "ar" {
                return flippedIconImage ?? UIImage()
            }
            
            return iconImage ?? UIImage()
            
        case .HelpCenter:
            let iconImage = UIImage(systemName: "questionmark.circle.fill")
            let flippedIconImage = UIImage(systemName: "questionmark.circle.fill")?.imageFlippedForRightToLeftLayoutDirection()
            
            if preferredLanguage == "ar" {
                return flippedIconImage ?? UIImage()
            }
            
            return iconImage ?? UIImage()

        case .Logout:
            let iconImage = UIImage(systemName: "return")
            let flippedIconImage = UIImage(systemName: "return")?.imageFlippedForRightToLeftLayoutDirection()
            
            if preferredLanguage == "ar" {
                return flippedIconImage ?? UIImage()
            }

            return iconImage ?? UIImage()
        }
    }
    
    
}
