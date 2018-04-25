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
        // TODO: To be implemented
    }

    @IBAction private func switchLanguageButtonTapped(_ sender: UIButton) {
        LocalizationManager.shared.switchLanguage()
        setTitlesForViews()
    }
}
