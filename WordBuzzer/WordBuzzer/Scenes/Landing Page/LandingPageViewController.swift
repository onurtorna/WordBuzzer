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
}
