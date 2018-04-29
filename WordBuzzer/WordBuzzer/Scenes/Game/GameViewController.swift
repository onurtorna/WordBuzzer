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

    /// Components to hide if there is less than maximum player number
    private lazy var removeablePlayerComponents: [(UILabel, UIButton)] = {
        return [(playerFourScoreLabel, playerFourBuzzerButton),
                (playerThreeScoreLabel, playerThreeBuzzerButton)]
    }()

    /// View model
    var viewModel: GameViewModel!

    /// Current shown possible answer label
    private var wordLabel: WordLabel?

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.stateChangeHandler = { change in
            self.applyState(change: change)
        }

        configureViews()
        viewModel.startNewGame()
    }

    func applyState(change: GameState.Change) {
        // TODO: To be implemented

            switch change {
            case .gameStarted(removePlayerCount: let removePlayerCount):
                for index in 0..<removePlayerCount {
                    removeablePlayerComponents[index].0.isHidden = true
                    removeablePlayerComponents[index].1.isHidden = true
                }
            case .roundStarted(questionWord: let questionWord,
                               word: let possibleAnswerWord,
                               remainingRounds: let remainingRounds):
                sendNewWord(with: possibleAnswerWord)
                startGame(with: questionWord)

            case .newWordSent(let word):
                sendNewWord(with: word)

            case .gameEnded:
                break
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
        pauseButton.setTitle(StringTable.commons.localized(key: "pause"),
                             for: .normal)
        ButtonCustomizer.applyBuzzerStyleTo(button: playerOneBuzzerButton,
                                            color: UIColor.red)
        ButtonCustomizer.applyBuzzerStyleTo(button: playerTwoBuzzerButton,
                                            color: UIColor.blue)
        ButtonCustomizer.applyBuzzerStyleTo(button: playerThreeBuzzerButton,
                                            color: UIColor.purple)
        ButtonCustomizer.applyBuzzerStyleTo(button: playerFourBuzzerButton,
                                            color: UIColor.yellow)
    }

}

// MARK: - WordLabelDelegate
extension GameViewController: WordLabelDelegate {
    func animationEnded() {
        viewModel.sendNewWordIfPossible()
    }
}

// MARK: - Actions
private extension GameViewController {
    // TODO: To be implemented
    @IBAction func playerOneBuzzerButtonTapped(_ sender: Any) {
    }

    @IBAction func playerTwoBuzzerButtonTapped(_ sender: Any) {
        wordLabel?.layer.pause()
    }

    @IBAction func playerThreeBuzzerButtonTapped(_ sender: Any) {

    }

    @IBAction func playerFourBuzzerButtonTapped(_ sender: Any) {
        
    }

    @IBAction func pauseButtonTapped(_ sender: Any) {

        wordLabel?.layer.pause()
        let alertController = UIAlertController.init(title: StringTable.game.localized(key: "gamePaused"),
                                                     message: "",
                                                     preferredStyle: .alert)

        let resumeAction = UIAlertAction(title: StringTable.game.localized(key: "resume"),
                                         style: .default) { (_) in
                                            self.wordLabel?.layer.resume()
        }

        let exitAction = UIAlertAction(title: StringTable.game.localized(key: "exitGame"),
                                       style: .destructive) { (_) in
                                        self.dismiss(animated: true,
                                                     completion: nil)
        }

        alertController.addAction(resumeAction)
        alertController.addAction(exitAction)
        show(alertController, sender: nil)
    }
    
}
