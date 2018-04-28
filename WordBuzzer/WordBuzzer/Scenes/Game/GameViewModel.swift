//
//  GameViewModel.swift
//  WordBuzzer
//
//  Created by Onur Torna on 26/04/18.
//  Copyright © 2018 Onur Torna. All rights reserved.
//

import Foundation

class GameState {

    enum Change {
        case gameStarted
        case gameActivateStateChanged(Bool)
    }

    var onChange: ((GameState.Change) -> Void)?

    /// Total number of players
    var playerCount: Int

    /// Language of the question words
    var questionLanguage: LanguageKey

    /// Language of the possible answer words
    var answerLanguage: LanguageKey

    /// Total number of rounds to play
    var totalRoundCount: Int

    /// Remaining round count
    var remainingRoundCount: Int

    /// Word list to play with
    var wordList: [Word]?

    init(playerCount: Int,
         totalRoundCount: Int,
         questionLanguage: LanguageKey,
         answerLanguage: LanguageKey) {
        self.playerCount = playerCount
        self.totalRoundCount = totalRoundCount
        self.questionLanguage = questionLanguage
        self.answerLanguage = answerLanguage
        remainingRoundCount = totalRoundCount
    }
}

class GameViewModel {

    /// Game state
    private var state: GameState

    /// State change handler
    var stateChangeHandler: ((GameState.Change) -> Void)? {
        get {
            return state.onChange
        }

        set {
            state.onChange = newValue
            publishInitial()
        }
    }

    init(playerCount: Int,
         totalRoundCount: Int,
         questionLanguage: LanguageKey,
         answerLanguage: LanguageKey) {
        state = GameState(playerCount: playerCount,
                          totalRoundCount: totalRoundCount,
                          questionLanguage: questionLanguage,
                          answerLanguage: answerLanguage)
    }

    private func publishInitial() {
        loadWords()
    }

    /// Loads words with file reader
    private func loadWords() {
        if let jsonList = FileReader.readJsonList(resource: Global.File.jsonFolderPath) {
            state.wordList = WordGenerator.generateWordList(with: jsonList,
                                                            questionLanguage: state.questionLanguage,
                                                            answerLanguage: state.answerLanguage)
        }
    }
}
