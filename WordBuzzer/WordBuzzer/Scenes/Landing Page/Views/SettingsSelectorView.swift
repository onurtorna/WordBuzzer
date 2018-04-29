//
//  SettingsSelectorView.swift
//  WordBuzzer
//
//  Created by Onur Torna on 26/04/18.
//  Copyright © 2018 Onur Torna. All rights reserved.
//

import UIKit

protocol SettingsSelectorViewDelegate {
    func startGame(playerCount: Int,
                   roundCount: Int,
                   questionLanguage: LanguageKey,
                   answerLanguage: LanguageKey)
}

final class SettingsSelectorView: UIView, NibLoadable {

    @IBOutlet weak var languageSelectButton: UIButton!
    @IBOutlet private weak var playerCountSelectButton: UIButton!
    @IBOutlet private weak var roundCountSelectButton: UIButton!
    @IBOutlet private weak var cancelButton: UIButton!
    @IBOutlet private weak var startButton: UIButton!

    var viewModel = SettingsSelectorViewModel()

    /// Delegate
    var delegate: SettingsSelectorViewDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()

        translatesAutoresizingMaskIntoConstraints = false

        startButton.setTitle(StringTable.commons.localized(key: "start"), for: .normal)
        cancelButton.setTitle(StringTable.commons.localized(key: "cancel"), for: .normal)

        viewModel.stateChangeHandler = { change in
            self.applyState(change: change)
        }

        ButtonCustomizer.applyBorderStyleTo(button: playerCountSelectButton)
        ButtonCustomizer.applyBorderStyleTo(button: roundCountSelectButton)
        ButtonCustomizer.applyBorderStyleTo(button: languageSelectButton)
        ButtonCustomizer.applyBorderStyleTo(button: cancelButton)
        ButtonCustomizer.applyBorderStyleTo(button: startButton)
    }

    @discardableResult static func show(in viewController: UIViewController) -> SettingsSelectorView {
        let settingsSelectorView = SettingsSelectorView.loadFromNib()
        settingsSelectorView.delegate = viewController as? SettingsSelectorViewDelegate
        viewController.view.addSubview(settingsSelectorView)
        viewController.view.embed(childView: settingsSelectorView,
                                  constant: 0)
        return settingsSelectorView
    }

    private func applyState(change: SettingsSelectorState.Change) {

        switch change {
        case .playerCountChanged(let playerCount):
            let title = StringTable.landingPage.localized(key: "players") + " \(playerCount)"
            playerCountSelectButton.setTitle(title, for: .normal)

        case .roundCountChanged(let roundCount):
            let title = StringTable.landingPage.localized(key: "rounds") + " \(roundCount)"
            roundCountSelectButton.setTitle(title, for: .normal)

        case .languageChanged(questionLanguage: let questionLanguage,
                              answerLanguage: let answerLanguage):
            let title = StringTable.commons.localized(key: questionLanguage.localizationKey)
                + " -> "
                + StringTable.commons.localized(key: answerLanguage.localizationKey)
            languageSelectButton.setTitle(title, for: .normal)

        case .gameStarted(let playerCount,
                          let roundCount,
                          let questionLanguage,
                          let answerLanguage):
            delegate?.startGame(playerCount: playerCount,
                                roundCount: roundCount,
                                questionLanguage: questionLanguage,
                                answerLanguage: answerLanguage)
        }
    }

    /// Removes the instance from superview
    func dismiss() {
        removeFromSuperview()
    }

    @IBAction private func playerCountSelectButtonTapped(_ sender: Any) {
        viewModel.updatePlayerCount()
    }

    @IBAction private func roundCountSelectButtonTapped(_ sender: Any) {
        viewModel.updateRoundCount()
    }
    
    @IBAction func languageSelectButtonTapped(_ sender: Any) {
        viewModel.updateLanguageSelection()
    }

    @IBAction private func cancelButtonTapped(_ sender: Any) {
        removeFromSuperview()
    }

    @IBAction private func startButtonTapped(_ sender: Any) {
        viewModel.startGame()
    }
}
