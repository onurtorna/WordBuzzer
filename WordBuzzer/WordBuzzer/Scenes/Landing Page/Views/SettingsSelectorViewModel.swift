//
//  SettingsSelectorViewModel.swift
//  WordBuzzer
//
//  Created by Onur Torna on 26/04/18.
//  Copyright © 2018 Onur Torna. All rights reserved.
//

import Foundation

final class SettingsSelectorState {

    enum Change {
        case playerCountChanged(Int)
        case roundCountChanged(Int)
        case languageChanged((questionLanguage: LanguageKey, answerLanguage: LanguageKey))
        case gameStarted(Int, Int, LanguageKey, LanguageKey)
    }

    /// Possible player count list
    var playerCountList = [2, 3, 4]

    /// Possible round count list
    var roundCountList = [5, 10, 15, 20]

    /// Possible language pair tupples
    var languageList: [(LanguageKey, LanguageKey)] = [(.englishKey, .spanishKey),
                                                      (.spanishKey, .englishKey)]

    /// Change closure
    var onChange: ((SettingsSelectorState.Change) -> Void)?

    /// Selected player count
    private var selectedPlayerCount: Int = 0 {
        didSet {
            onChange?(.playerCountChanged(selectedPlayerCount))
        }
    }

    /// Selected round count
    private var selectedRoundCount: Int = 0 {
        didSet {
            onChange?(.roundCountChanged(selectedRoundCount))
        }
    }

    /// Selected languages
    var selectedLanguage: (LanguageKey, LanguageKey) = (.englishKey, .spanishKey) {
        didSet {
            onChange?(.languageChanged((questionLanguage: selectedLanguage.0,
                                        answerLanguage: selectedLanguage.1)))
        }
    }

    /// Selected player count index in the player count list
    var selectedPlayerCountIndex: Int = 0 {
        didSet {
            selectedPlayerCount = playerCountList[selectedPlayerCountIndex]
        }
    }

    /// Selected round count index in the round count list
    var selectedRoundCountIndex: Int = 0 {
        didSet {
            selectedRoundCount = roundCountList[selectedRoundCountIndex]
        }
    }

    /// Selected language pair index in the language tupple list
    var selectedLanguageIndex: Int = 0 {
        didSet {
            selectedLanguage = languageList[selectedLanguageIndex]
        }
    }

    /// Player count list size
    var playerCountListCount: Int {
        return playerCountList.count
    }

    /// Round count list size
    var roundCountListCount: Int {
        return roundCountList.count
    }

    var languageListCount: Int {
        return languageList.count
    }

}

final class SettingsSelectorViewModel {

    /// Current state of the view model
    private var state = SettingsSelectorState()

    var stateChangeHandler: ((SettingsSelectorState.Change) -> Void)? {
        get {
            return state.onChange
        }

        set {
            state.onChange = newValue
            publishInitial()
        }
    }

    /// Updates the round count by incrementing it if possible, resets it if it is not.
    func updateRoundCount() {

        if state.selectedRoundCountIndex == state.roundCountListCount - 1 {
            state.selectedRoundCountIndex = 0
        } else {
            state.selectedRoundCountIndex += 1
        }
    }

    /// Updates the player count by incrementing it if possible, resets it if it is not.
    func updatePlayerCount() {

        if state.selectedPlayerCountIndex == state.playerCountListCount - 1 {
            state.selectedPlayerCountIndex = 0
        } else {
            state.selectedPlayerCountIndex += 1
        }
    }

    func updateLanguageSelection() {

        if state.selectedLanguageIndex == state.languageListCount - 1 {
            state.selectedLanguageIndex = 0
        } else {
            state.selectedLanguageIndex += 1
        }
    }

    /// Starts the game
    func startGame() {
        stateChangeHandler?(.gameStarted(state.playerCountList[state.selectedPlayerCountIndex],
                                         state.roundCountList[state.selectedRoundCountIndex],
                                         state.selectedLanguage.0,
                                         state.selectedLanguage.1))
    }

    /// Publishes initial values for state variables
    private func publishInitial() {
        state.selectedPlayerCountIndex = 0
        state.selectedRoundCountIndex = 0
        state.selectedLanguageIndex = 0
    }
}
