//
//  GameViewController.swift
//  WordBuzzer
//
//  Created by Onur Torna on 26/04/18.
//  Copyright © 2018 Onur Torna. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, StoryboardLoadable {

    /// Default storyboard name to conform to StoryboardLoadable protocol
    static let defaultStoryboardName = "Main"

    @IBOutlet private weak var playerOneScoreLabel: UILabel!
    @IBOutlet private weak var playerTwoScoreLabel: UILabel!
    @IBOutlet private weak var playerThreeScoreLabel: UILabel!
    @IBOutlet private weak var playerFourScoreLabel: UILabel!
    @IBOutlet private weak var askedWordLabel: UILabel!
    @IBOutlet private weak var remainingRoundLabel: UILabel!
    
    @IBOutlet private weak var playerOneBuzzerButton: UIButton!
    @IBOutlet private weak var playerTwoBuzzerButton: UIButton!
    @IBOutlet private weak var playerThreeBuzzerButton: UIButton!
    @IBOutlet private weak var playerFourBuzzerButton: UIButton!
    @IBOutlet private weak var pauseButton: UIButton!

    @IBOutlet private weak var wordContainerView: UIView!

    /// View model
    var viewModel: GameViewModel!
    var wordLabel: WordLabel?
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.stateChangeHandler = { change in
            self.applyState(change: change)
        }

        configureViews()
        viewModel.startNewRoundIfPossible()
    }

    func applyState(change: GameState.Change) {
        // TODO: To be implemented

            switch change {
            case .roundStarted(questionWord: let questionWord,
                               word: let possibleAnswerWord,
                               remainingRounds: let remainingRounds):
                sendNewWord(with: possibleAnswerWord)
                startGame(with: questionWord)

            case .gameEnded:
                break
            case .newWordSent(let word):
                sendNewWord(with: word)
            }
    }

    private func sendNewWord(with text: String) {
        // TODO: To be implemented
        wordLabel = WordLabel(superViewBound: wordContainerView.bounds,
                              text: text)
        if let wordLabel = wordLabel {
            wordLabel.delegate = self
            wordContainerView.addSubview(wordLabel)
            wordLabel.moveWithAnimation(superViewBound: wordContainerView.bounds)
        }
    }

    private func startGame(with questionWord: String) {

        // TODO: Timer can be added here
        askedWordLabel.text = questionWord
    }

    private func configureViews() {
        // TODO: To be implemented
    }

}

// MARK: - WordLabelDelegate
extension GameViewController: WordLabelDelegate {
    func animationEnded() {
        viewModel.sendNewWordIfPossible()
    }
}

// MARK: - Actions
extension GameViewController {
    // TODO: To be implemented
    @IBAction private func playerOneBuzzerButtonTapped(_ sender: Any) {
    }

    @IBAction private func playerTwoBuzzerButtonTapped(_ sender: Any) {
    }
    @IBAction private func playerThreeBuzzerButtonTapped(_ sender: Any) {
    }

    @IBAction private func playerFourBuzzerButtonTapped(_ sender: Any) {
    }
}
