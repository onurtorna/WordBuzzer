//
//  LandingPageUITests.swift
//  WordBuzzerUITests
//
//  Created by Onur Torna on 30/04/18.
//  Copyright © 2018 Onur Torna. All rights reserved.
//

import XCTest

class LandingPageUITests: XCTestCase {

    let app = XCUIApplication()

    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_component_existance() {
        XCTAssert(app.buttons["howToPlayButton"].exists)
        XCTAssert(app.buttons["startGameButton"].exists)
        XCTAssert(app.buttons["switchLanguageButton"].exists)
    }

    func test_language_switch() {
        let firstLanguageLabel = app.buttons["switchLanguageButton"].label
        let firstStartGameLabel = app.buttons["startGameButton"].label
        let firstHowToPlayButtonLabel = app.buttons["howToPlayButton"].label
        app.buttons["switchLanguageButton"].tap()
        let switchedLanguageLabel = app.buttons["switchLanguageButton"].label
        let switchedStartGameLabel = app.buttons["startGameButton"].label
        let switchedHowToPlayButtonLabel = app.buttons["howToPlayButton"].label

        XCTAssertTrue(firstLanguageLabel != switchedLanguageLabel)
        XCTAssertTrue(firstStartGameLabel != switchedStartGameLabel)
        XCTAssertTrue(firstHowToPlayButtonLabel != switchedHowToPlayButtonLabel)
    }

    func test_navigate_how_to_play() {
        app.buttons["howToPlayButton"].tap()
        let howToPlayView = app.otherElements["howToPlayViewControllerView"]
        XCTAssert(howToPlayView.exists)
    }

    func test_open_start_menu() {
        app.buttons["startGameButton"].tap()
        let settingsSelectorView = app.otherElements["settingsSelectorView"]
        XCTAssert(settingsSelectorView.exists)
    }
}
