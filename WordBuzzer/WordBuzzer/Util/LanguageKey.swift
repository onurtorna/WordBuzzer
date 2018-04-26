//
//  LanguageKey.swift
//  WordBuzzer
//
//  Created by Onur Torna on 25/04/18.
//  Copyright © 2018 Onur Torna. All rights reserved.
//

import Foundation

/// Language keys used in word generation.
/// Add additional keys and update json file to support more language
enum LanguageKey: String {
    case englishKey = "text_eng"
    case spanishKey = "text_spa"

    var localizationKey: String {
        switch self {
        case .englishKey:
            return "english"
        case .spanishKey:
            return "spanish"
        }
    }
}
