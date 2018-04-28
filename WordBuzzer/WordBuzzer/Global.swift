//
//  Global.swift
//  WordBuzzer
//
//  Created by Onur Torna on 25/04/18.
//  Copyright © 2018 Onur Torna. All rights reserved.
//

import Foundation

enum Global {

    enum File {
        static let jsonFolderPath = "words"

        enum Extension {
            static let json = "json"
        }
    }

    enum Game {
        static let maximumDecoyWords = 10
    }
    
}
