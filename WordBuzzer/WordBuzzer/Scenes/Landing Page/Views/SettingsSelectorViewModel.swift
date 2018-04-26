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
        case gameStarted(Int, Int)
    }

    /// Possible player count list
    private var playerCountList = [2, 3, 4]

    /// Possible round count list
    private var roundCountList = [5, 10, 15, 20]

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

    /// Player count list size
    var playerCountListCount: Int {
        return playerCountList.count
    }

    /// Round count list size
    var roundCountListCount: Int {
        return roundCountList.count
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

    /// Starts the game
    func startGame() {
        stateChangeHandler?(.gameStarted(state.selectedPlayerCountIndex,

            state.selectedRoundCountIndex))
    }

    /// Publishes initial values for state variables
    private func publishInitial() {
        state.selectedPlayerCountIndex = 0
        state.selectedRoundCountIndex = 0
    }
}
