//
//  Enum.swift
//  GuideTech
//
//  Created by Valter A. Machado on 3/22/20.
//  Copyright © 2020 Valter A. Machado. All rights reserved.
//

// need to create separate file for each lang

//import UIKit
//
//enum LocalizationLanguage: String, Codable {
//
//    case en = "EN"
//    case ar = "AR"
//    case none = "none"
//
//    var index: Int {
//
//        switch self {
//        case .en: return 0
//        case .ar: return 1
//        case .none: return 2
//
//        }
//    }
//}
//
//extension LocalizationLanguage {
//
//    enum CodingKeys: String, CodingKey {
//        case rawValue
//    }
//
//    enum CodingError: Error {
//        case unknownValue
//    }
//
//    init(from decoder: Decoder) throws {
//
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        let rawValue = try container.decode(String.self, forKey: .rawValue)
//
//        switch rawValue {
//        case "EN": self = .en
//        case "AR": self = .ar
//        case "none": self = .none
//        default:
//            throw CodingError.unknownValue
//        }
//    }
//
//    func encode(to encoder: Encoder) throws {
//
//        var container = encoder.container(keyedBy: CodingKeys.self)
//
//        switch self{
//        case .en:
//            try container.encode("EN", forKey: .rawValue)
//        case .ar:
//            try container.encode("AR", forKey: .rawValue)
//        case .none:
//            try container.encode("none", forKey: .rawValue)
//        }
//    }
//
//
//}
//
//
//extension String {
//
//    func localized2() -> String{
//        let languageManager = LanguageManager.shared
//
//        if let currentLang = languageManager.getCurrentLanguage() as? LocalizationLanguage {
//            guard currentLang != LocalizationLanguage.ar else { return self }
//
//            if let url = Bundle.main.url(forResource: "\(currentLang.rawValue)", withExtension: "String"),
//                let stringDic = NSDictionary(contentsOf: url) as? [String: String],
//                let localizedString = stringDic[self]{
//                return localizedString
//            }
//            return self
//        }
//        else
//        {
//            return self
//        }
//    }
//}
//
//
//class LanguageManager {
//
//    static let shared = LanguageManager()
//    let userDefaults = UserDefaults.standard
//
//    func setCurrentLanguage(to lang: LocalizationLanguage) {
//
//        let jsonEncoder = JSONEncoder()
//        if let encodedData = try? jsonEncoder.encode(lang)
//        {
//            userDefaults.set(encodedData, forKey: "lang")
//            userDefaults.synchronize()
//        }
//        else
//        {
//            print("cannot save the language")
//        }
//    }
//
//    func getCurrentLanguage() -> LocalizationLanguage? {
//
//        if let currentLangData = try? userDefaults.value(forKey: "lang") as? Data
//        {
//            let jsonDecoder = JSONDecoder()
//            do
//            {
//                let currentLang = try jsonDecoder.decode(LocalizationLanguage.self, from: currentLangData)
//                return currentLang
//            }
//            catch
//            {
//                print(error.localizedDescription)
//            }
//        }
//
//        return nil
//
//    }
//}
