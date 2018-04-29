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
        static let correctAnswerPoint = 10
        static let wrongAnswerPoint = -5
        static let maximumDecoyWords = 10
        static let maximumPLayers = 4
    }
}
