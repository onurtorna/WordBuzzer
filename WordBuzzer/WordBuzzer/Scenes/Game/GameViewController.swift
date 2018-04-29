//
//  GameViewController.swift
//  WordBuzzer
//
//  Created by Onur Torna on 26/04/18.
//  Copyright © 2018 Onur Torna. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, StoryboardLoadable {

    private enum Constants {
        static let feedbackTime: Double = 1.0
    }

    /// Default storyboard name to conform to StoryboardLoadable protocol
    static let defaultStoryboardName = "Main"

    @IBOutlet private weak var playerOneScoreLabel: UILabel!
    @IBOutlet private weak var playerTwoScoreLabel: UILabel!
    @IBOutlet private weak var playerThreeScoreLabel: UILabel!
    @IBOutlet private weak var playerFourScoreLabel: UILabel!
    @IBOutlet private weak var askedWordLabel: UILabel!
    @IBOutlet private weak var remainingRoundLabel: UILabel!
    @IBOutlet private weak var feedBackLabel: UILabel!

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

            switch change {
            case .gameStarted(removePlayerCount: let removePlayerCount):
                for index in 0..<removePlayerCount {
                    removeablePlayerComponents[index].0.isHidden = true
                    removeablePlayerComponents[index].1.isHidden = true
                }

            case .pointsUpdated(let pointsList):
                if pointsList.count > 3 {
                    playerOneScoreLabel.text = "\(pointsList[0])"
                    playerTwoScoreLabel.text = "\(pointsList[1])"
                    playerThreeScoreLabel.text = "\(pointsList[2])"
                    playerFourScoreLabel.text = "\(pointsList[3])"
                }

            case .roundStarted(questionWord: let questionWord,
                               word: let possibleAnswerWord,
                               remainingRounds: let remainingRounds):
                remainingRoundLabel.text = StringTable.landingPage.localized(key: "rounds") + " \(remainingRounds)"
                wordLabel?.removeFromSuperview()
                sendNewWord(with: possibleAnswerWord)
                startGame(with: questionWord)

            case .wordGuessStatusChanged(let isGuessCorrect):
                if isGuessCorrect {
                    feedBackLabel.textColor = UIColor.green
                    feedBackLabel.text = StringTable.game.localized(key: "correct")
                } else {
                    feedBackLabel.textColor = UIColor.red
                    feedBackLabel.text = StringTable.game.localized(key: "wrong")
                }

                UIView.animate(withDuration: Constants.feedbackTime,
                               animations: {
                    self.feedBackLabel.alpha = 1
                }) { (_) in
                    self.feedBackLabel.alpha = 0
                }

            case .newWordSent(let word):
                sendNewWord(with: word)

            case .gameEnded(winnerNumber: let winnerNumber,
                            point: let winnerPoint):
                let rawText = StringTable.game.localized(key: "winner")
                let endGameFeedBack = String(format: rawText, "\(winnerNumber)", "\(winnerPoint)")
                feedBackLabel.text = endGameFeedBack
                endGame(with: endGameFeedBack)
            }
    }

    private func sendNewWord(with text: String) {
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

    private func endGame(with feedback: String) {

        wordLabel?.removeFromSuperview()

        let alertController = UIAlertController(title: StringTable.game.localized(key: "gameOver"),
                                                message: feedback,
                                                preferredStyle: .alert)

        let exitAction = UIAlertAction(title: StringTable.game.localized(key: "exitGame"),
                                       style: .destructive) { (_) in
                                        self.dismiss(animated: true, completion: nil)
        }

        let rematchAction = UIAlertAction(title: StringTable.game.localized(key: "rematch"),
                                          style: .default) { (_) in
                                            self.viewModel.restartGame()
        }
        alertController.addAction(exitAction)
        alertController.addAction(rematchAction)
        show(alertController, sender: nil)
    }

    private func configureViews() {
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

        playerOneBuzzerButton.setTitle("#1", for: .normal)
        playerTwoBuzzerButton.setTitle("#2", for: .normal)
        playerThreeBuzzerButton.setTitle("#3", for: .normal)
        playerFourBuzzerButton.setTitle("#4", for: .normal)

        feedBackLabel.alpha = 0
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
    
    @IBAction func playerOneBuzzerButtonTapped(_ sender: Any) {
        viewModel.wordGuessed(by: 1)
    }

    @IBAction func playerTwoBuzzerButtonTapped(_ sender: Any) {
        viewModel.wordGuessed(by: 2)
    }

    @IBAction func playerThreeBuzzerButtonTapped(_ sender: Any) {
        viewModel.wordGuessed(by: 3)
    }

    @IBAction func playerFourBuzzerButtonTapped(_ sender: Any) {
        viewModel.wordGuessed(by: 4)
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
