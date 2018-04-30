//
//  WordGeneratorTests.swift
//  WordBuzzerTests
//
//  Created by Onur Torna on 30/04/18.
//  Copyright © 2018 Onur Torna. All rights reserved.
//

import XCTest
@testable import WordBuzzer

class WordGeneratorTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func test_generate_word_list() {
        let sampleJsonList = [["text_eng":"primary school",
                               "text_spa":"escuela primaria"],
                              ["text_eng":"holidays",
                               "text_spa":"vacaciones"],
                              ["text_eng":"class",
                               "text_spa":"curso"]]
        let wordList = WordGenerator.generateWordList(with: sampleJsonList,
                                                      questionLanguage: .englishKey,
                                                      answerLanguage: .spanishKey)

        let primarySchoolWord = Word(questionWord: "primary school",
                                     answerWord: "escuela primaria")
        let holidaysWord = Word(questionWord: "holidays",
                                answerWord: "vacaciones")
        let classWord = Word(questionWord: "class",
                             answerWord: "curso")
        let sampleWordList: [Word] = [primarySchoolWord, holidaysWord, classWord]

        XCTAssertTrue(wordList.count == 3)

        XCTAssertTrue(wordList.first == primarySchoolWord)
        XCTAssertTrue(wordList[1] == holidaysWord)
        XCTAssertTrue(wordList.last == classWord)

        XCTAssertTrue(wordList == sampleWordList)

        XCTAssertFalse(wordList == [])

        XCTAssertFalse(wordList == [classWord])
    }

    func test_generate_word() {
        let sampleJson = ["text_eng":"primary school",
                          "text_spa":"escuela primaria"]

        let sampleEnglishWord = Word(questionWord: "primary school",
                                     answerWord: "escuela primaria")
        let word = WordGenerator.generateWord(with: sampleJson,
                                              questionLanguage: .englishKey,
                                              answerLanguage: .spanishKey)
        XCTAssertTrue(word == sampleEnglishWord)

        let sampleWrongWord = Word(questionWord: "wrong",
                                   answerWord: "wrong")
        XCTAssertFalse(word == sampleWrongWord)

        let sampleEmptyWord = Word(questionWord: "",
                                   answerWord: "")
        XCTAssertFalse(word == sampleEmptyWord)

        let sampleOppositeWord = Word(questionWord: "escuela primaria",
                                      answerWord: "primary school")
        XCTAssertFalse(word == sampleOppositeWord)
    }

}
