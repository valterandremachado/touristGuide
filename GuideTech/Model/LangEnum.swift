//
//  LangEnum.swift
//  GuideTech
//
//  Created by Valter A. Machado on 3/21/20.
//  Copyright © 2020 Valter A. Machado. All rights reserved.
//

import UIKit

enum LangEnum: Int, CustomStringConvertible {
    
    case English
    case Arabic
    
    var description: String {
        switch self {
        case .English: return "English"
        case .Arabic: return "Arabic"
        }
    }
    
}
