//
//  LandingPageViewController.swift
//  WordBuzzer
//
//  Created by Onur Torna on 25/04/18.
//  Copyright © 2018 Onur Torna. All rights reserved.
//

import UIKit

class LandingPageViewController: UIViewController {

    @IBOutlet private weak var startGameButton: UIButton!
    @IBOutlet private weak var howToPlayButton: UIButton!
    @IBOutlet private weak var switchLanguageButton: UIButton!

    /// Settings view to be shown to customers
    private var settingsView: SettingsSelectorView?

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViews()
    }

    private func configureViews() {
        // TODO: To be implemented

        setTitlesForViews()
    }

    private func setTitlesForViews() {
        switchLanguageButton.setTitle(StringTable.landingPage.localized(key: "language"), for: .normal)
        howToPlayButton.setTitle(StringTable.landingPage.localized(key: "howToPlay"), for: .normal)
        startGameButton.setTitle(StringTable.landingPage.localized(key: "startGame"), for: .normal)
    }
}

// MARK: - Actions
extension LandingPageViewController {

    @IBAction private func didTapHowToPlayButton(_ sender: UIButton) {
        // TODO: To be implemented
    }

    @IBAction private func didTapStartGameButton(_ sender: UIButton) {
        settingsView = SettingsSelectorView.show(in: self)
    }

    @IBAction private func switchLanguageButtonTapped(_ sender: UIButton) {
        LocalizationManager.shared.switchLanguage()
        setTitlesForViews()
    }
}

// MARK: - SettingsSelectorViewDelegate
extension LandingPageViewController: SettingsSelectorViewDelegate {

    func startGame(playerCount: Int, roundCount: Int) {
        let viewController = GameViewController.loadFromStoryboard()
        let viewModel = GameViewModel(playerCount: playerCount,
                                      totalRoundCount: roundCount)
        viewController.viewModel = viewModel
        present(viewController, animated: true) {
            self.settingsView?.dismiss()
        }
    }
}
