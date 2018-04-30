//
//  GameUITests.swift
//  WordBuzzerUITests
//
//  Created by Onur Torna on 30/04/18.
//  Copyright © 2018 Onur Torna. All rights reserved.
//

import XCTest

class GameUITests: XCTestCase {

    let app = XCUIApplication()

    override func setUp() {
        super.setUp()

        continueAfterFailure = false
        app.launch()
    }

    override func tearDown() {
        super.tearDown()
    }

    func test_game_start() {
        app.buttons["startGameButton"].tap()
        app.buttons["startButton"].tap()
        let gameViewControllerView = app.otherElements["gameViewControllerView"]
        XCTAssert(gameViewControllerView.exists)
    }

    func test_word_guess_score() {
        app.buttons["startGameButton"].tap()
        app.buttons["startButton"].tap()

        let initialPlayerOneScore = app.staticTexts["playerOneScoreLabel"].label
        app.buttons["playerOneBuzzerButton"].tap()
        let finalPlayerOneScore = app.staticTexts["playerOneScoreLabel"].label

        XCTAssertNotEqual(initialPlayerOneScore, finalPlayerOneScore)
    }

    func test_word_guess_asked_word() {
        app.buttons["startGameButton"].tap()
        app.buttons["startButton"].tap()

        let initialAskedWord = app.staticTexts["askedWordLabel"].label
        app.buttons["playerOneBuzzerButton"].tap()
        let finalAskedWord = app.staticTexts["askedWordLabel"].label

        XCTAssertNotEqual(initialAskedWord, finalAskedWord)
    }

    func test_word_guess_round_count() {
        app.buttons["startGameButton"].tap()
        app.buttons["startButton"].tap()

        let initialAskedWord = app.staticTexts["askedWordLabel"].label
        app.buttons["playerOneBuzzerButton"].tap()
        let finalAskedWord = app.staticTexts["askedWordLabel"].label

        XCTAssertNotEqual(initialAskedWord, finalAskedWord)
    }

    func test_two_player_game_components() {

        app.buttons["startGameButton"].tap()
        app.buttons["startButton"].tap()

        let playerOneBuzzerButton = app.buttons["playerOneBuzzerButton"]
        let playerTwoBuzzerButton = app.buttons["playerTwoBuzzerButton"]
        let playerThreeBuzzerButton = app.buttons["playerThreeBuzzerButton"]
        let playerFourBuzzerButton = app.buttons["playerFourBuzzerButton"]
        let pauseButton = app.buttons["pauseButton"]

        let playerOneScoreLabel = app.staticTexts["playerOneScoreLabel"]
        let playerTwoScoreLabel = app.staticTexts["playerTwoScoreLabel"]
        let playerThreeScoreLabel = app.staticTexts["playerThreeScoreLabel"]
        let playerFourScoreLabel = app.staticTexts["playerFourScoreLabel"]
        let remainingRoundLabel = app.staticTexts["remainingRoundLabel"]

        XCTAssertTrue(playerOneBuzzerButton.exists)
        XCTAssertTrue(playerTwoBuzzerButton.exists)
        XCTAssertFalse(playerThreeBuzzerButton.exists)
        XCTAssertFalse(playerFourBuzzerButton.exists)

        XCTAssertTrue(playerOneScoreLabel.exists)
        XCTAssertTrue(playerTwoScoreLabel.exists)
        XCTAssertFalse(playerThreeScoreLabel.exists)
        XCTAssertFalse(playerFourScoreLabel.exists)

        XCTAssertTrue(pauseButton.exists)
        XCTAssertTrue(remainingRoundLabel.exists)
    }

    func test_three_player_game_components() {

        app.buttons["startGameButton"].tap()
        app.buttons["playerCountSelectButton"].tap()
        app.buttons["startButton"].tap()

        let playerOneBuzzerButton = app.buttons["playerOneBuzzerButton"]
        let playerTwoBuzzerButton = app.buttons["playerTwoBuzzerButton"]
        let playerThreeBuzzerButton = app.buttons["playerThreeBuzzerButton"]
        let playerFourBuzzerButton = app.buttons["playerFourBuzzerButton"]
        let pauseButton = app.buttons["pauseButton"]

        let playerOneScoreLabel = app.staticTexts["playerOneScoreLabel"]
        let playerTwoScoreLabel = app.staticTexts["playerTwoScoreLabel"]
        let playerThreeScoreLabel = app.staticTexts["playerThreeScoreLabel"]
        let playerFourScoreLabel = app.staticTexts["playerFourScoreLabel"]
        let remainingRoundLabel = app.staticTexts["remainingRoundLabel"]

        XCTAssertTrue(playerOneBuzzerButton.exists)
        XCTAssertTrue(playerTwoBuzzerButton.exists)
        XCTAssertTrue(playerThreeBuzzerButton.exists)
        XCTAssertFalse(playerFourBuzzerButton.exists)

        XCTAssertTrue(playerOneScoreLabel.exists)
        XCTAssertTrue(playerTwoScoreLabel.exists)
        XCTAssertTrue(playerThreeScoreLabel.exists)
        XCTAssertFalse(playerFourScoreLabel.exists)

        XCTAssertTrue(pauseButton.exists)
        XCTAssertTrue(remainingRoundLabel.exists)
    }

    func test_four_player_game_components() {

        app.buttons["startGameButton"].tap()
        app.buttons["playerCountSelectButton"].tap()
        app.buttons["playerCountSelectButton"].tap()
        app.buttons["startButton"].tap()

        let playerOneBuzzerButton = app.buttons["playerOneBuzzerButton"]
        let playerTwoBuzzerButton = app.buttons["playerTwoBuzzerButton"]
        let playerThreeBuzzerButton = app.buttons["playerThreeBuzzerButton"]
        let playerFourBuzzerButton = app.buttons["playerFourBuzzerButton"]
        let pauseButton = app.buttons["pauseButton"]

        let playerOneScoreLabel = app.staticTexts["playerOneScoreLabel"]
        let playerTwoScoreLabel = app.staticTexts["playerTwoScoreLabel"]
        let playerThreeScoreLabel = app.staticTexts["playerThreeScoreLabel"]
        let playerFourScoreLabel = app.staticTexts["playerFourScoreLabel"]
        let remainingRoundLabel = app.staticTexts["remainingRoundLabel"]

        XCTAssertTrue(playerOneBuzzerButton.exists)
        XCTAssertTrue(playerTwoBuzzerButton.exists)
        XCTAssertTrue(playerThreeBuzzerButton.exists)
        XCTAssertTrue(playerFourBuzzerButton.exists)

        XCTAssertTrue(playerOneScoreLabel.exists)
        XCTAssertTrue(playerTwoScoreLabel.exists)
        XCTAssertTrue(playerThreeScoreLabel.exists)
        XCTAssertTrue(playerFourScoreLabel.exists)

        XCTAssertTrue(pauseButton.exists)
        XCTAssertTrue(remainingRoundLabel.exists)
    }
}
