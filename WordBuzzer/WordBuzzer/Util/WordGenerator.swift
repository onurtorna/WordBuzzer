//
//  WordGenerator.swift
//  WordBuzzer
//
//  Created by Onur Torna on 25/04/18.
//  Copyright © 2018 Onur Torna. All rights reserved.
//

import Foundation

/// Generates words from given json file for given languages
class WordGenerator {

    /// Generate word list from given json array
    ///
    /// - Parameters:
    ///   - jsonArray: Json list object
    ///   - questionLanguage: Language to prepare question meaning of the word
    ///   - answerLanguage: Language to prepare answer meaning of the word
    /// - Returns: Word list object with given question and answer meanings.
    static func generateWordList(with jsonArray: [[String: String]],
                                 questionLanguage: LanguageKey,
                                 answerLanguage: LanguageKey) -> [Word] {

        var wordSet = Set<Word>()
        for json in jsonArray {

            if let word = generateWord(with: json,
                                       questionLanguage: questionLanguage,
                                       answerLanguage: answerLanguage) {
                wordSet.insert(word)
            }
        }

        return Array(wordSet)
    }

    /// Generate single word from given json
    ///
    /// - Parameters:
    ///   - json: Json dictionaray
    ///   - questionLanguage: Language to prepare question meaning of the word
    ///   - answerLanguage: Language to prepare answer meaning of the word
    /// - Returns: Word object with given question and answer meanings.
    static func generateWord(with json: [String: String],
                             questionLanguage: LanguageKey,
                             answerLanguage: LanguageKey) -> Word? {
        guard let questionWordValue = json[questionLanguage.rawValue],
            let answerWordValue = json[answerLanguage.rawValue] else {
                return nil
        }

        return Word(questionWord: questionWordValue,
                    answerWord: answerWordValue)
    }

}
