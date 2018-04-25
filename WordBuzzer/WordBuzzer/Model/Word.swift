//
//  Word.swift
//  WordBuzzer
//
//  Created by Onur Torna on 25/04/18.
//  Copyright © 2018 Onur Torna. All rights reserved.
//

import Foundation

struct Word: Hashable {

    /// Word to be asked to users
    var questionWord: String

    /// Correct translation of the asked word
    var answerWord: String

    static func == (lhs: Word, rhs: Word) -> Bool {
        return lhs.questionWord == rhs.questionWord
            && lhs.answerWord == rhs.answerWord
    }
}
