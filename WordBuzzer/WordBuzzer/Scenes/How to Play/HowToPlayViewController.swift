//
//  HowToPlayViewController.swift
//  WordBuzzer
//
//  Created by Onur Torna on 30/04/18.
//  Copyright © 2018 Onur Torna. All rights reserved.
//

import UIKit

class HowToPlayViewController: UIViewController, StoryboardLoadable {

    static var defaultStoryboardName: String = "Main"

    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var instructionsLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }

    private func configureViews() {
        backButton.setTitle(StringTable.commons.localized(key: "back"), for: .normal)
        titleLabel.text = StringTable.howToPlay.localized(key: "howToPlay")
        instructionsLabel.text = StringTable.howToPlay.localized(key: "instructions")
    }

    @IBAction private func backButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
