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
        case gameStarted(removePlayerCount: Int)
        case roundStarted(questionWord: String,
            word: String,
            remainingRounds: Int)
        case pointsUpdated([Int])
        case wordGuessStatusChanged(Bool)
        case newWordSent(word: String)
        case gameEnded(winnerNumber: Int, point: Int)
    }

    var onChange: ((GameState.Change) -> Void)?

    /// Players' points respectively
    var points: [Int] = [0, 0, 0, 0] {
        didSet {
            onChange?(.pointsUpdated(points))
        }
    }

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

    /// Indexes of the asked words in word list
    var askedWordIndexList: [Int] = []

    /// Asked word in the current state
    var currentQuestionWord: Word?

    /// Current round's word list to ask. Last word is the answer.
    var roundsWordList: [Word]?

    /// Number of the words asked in the round
    var currentRoundWordCount = 0

    // Determines if the game is active
    var isGameActive = true

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

    /// Starts a new game
    func startNewGame() {
        let removePlayerCount = Global.Game.maximumPLayers - state.playerCount
        stateChangeHandler?(.gameStarted(removePlayerCount: removePlayerCount))
        stateChangeHandler?(.pointsUpdated(state.points))
        startNewRoundIfPossible()
    }

    /// Sends a new word to users if possible, tries to start new round otherwise
    func sendNewWordIfPossible() {

        guard let roundWordList = state.roundsWordList,
            state.currentRoundWordCount + 1 <= roundWordList.count,
            state.isGameActive
            else {
                startNewRoundIfPossible()
                return
        }

        let nextWord = roundWordList[state.currentRoundWordCount]
        state.currentRoundWordCount += 1
        stateChangeHandler?(.newWordSent(word: nextWord.answerWord))
    }

    /// Triggers when current shown word is guessed as the correct answer
    ///
    /// - Parameter playerNumber: Guessed player number
    func wordGuessed(by playerNumber: Int) {
        let playerIndex = playerNumber - 1
        let currentRoundWordIndex = state.currentRoundWordCount - 1
        let isGuessCorrect: Bool
        if state.roundsWordList?[currentRoundWordIndex] == state.currentQuestionWord {
            state.points[playerIndex] += Global.Game.correctAnswerPoint
            isGuessCorrect = true
        } else {
            state.points[playerIndex] += Global.Game.wrongAnswerPoint
            isGuessCorrect = false
        }

        stateChangeHandler?(.wordGuessStatusChanged(isGuessCorrect))
        startNewRoundIfPossible()
    }

    func restartGame() {
        state.points = [0, 0, 0, 0]
        state.remainingRoundCount = state.totalRoundCount
        state.isGameActive = true
        startNewGame()
    }
}

// MARK: - Helpers
private extension GameViewModel {

    func publishInitial() {
        loadWords()
    }

    /// Loads words with file reader
    func loadWords() {
        if let jsonList = FileReader.readJsonList(resource: Global.File.jsonFolderPath) {
            state.wordList = WordGenerator.generateWordList(with: jsonList,
                                                            questionLanguage: state.questionLanguage,
                                                            answerLanguage: state.answerLanguage)
        }
    }

    /// Starts a new round by sending a question if possible, ends game otherwise
    func startNewRoundIfPossible() {

        guard state.remainingRoundCount - 1 >= 0,
            let wordList = state.wordList
            else {
                endGame()
                return
        }

        state.remainingRoundCount -= 1
        state.currentQuestionWord = WordGenerator.generateWord(from: wordList,
                                                               excluding: state.askedWordIndexList)
        if let currentQuestionWord = state.currentQuestionWord,
            let currentQuestionWordIndex = wordList.index(of: currentQuestionWord) {
            state.askedWordIndexList.append(currentQuestionWordIndex)
            var decoyList = WordGenerator.generateWordList(from: wordList,
                                                           excludeIndex: currentQuestionWordIndex)
            decoyList.append(currentQuestionWord)
            state.roundsWordList = decoyList
            state.currentRoundWordCount = 1
            stateChangeHandler?(.roundStarted(questionWord: currentQuestionWord.questionWord,
                                              word: decoyList.first?.answerWord ?? "",
                                              remainingRounds: state.remainingRoundCount))
        }

    }

    func endGame() {
        guard state.isGameActive else { return }
        state.isGameActive = false

        // Do not include players that are not currently playing
        let subPoints = state.points[0..<state.playerCount]
        if let maximumNumber = subPoints.max(),
            let winnerIndex = state.points.index(of: maximumNumber) {
            stateChangeHandler?(.gameEnded(winnerNumber: winnerIndex + 1,
                                           point: maximumNumber))
        }
    }
}
