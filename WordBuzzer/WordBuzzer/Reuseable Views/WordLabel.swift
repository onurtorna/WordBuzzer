//
//  WordLabel.swift
//  WordBuzzer
//
//  Created by Onur Torna on 27/04/18.
//  Copyright © 2018 Onur Torna. All rights reserved.
//

import UIKit

protocol WordLabelDelegate {
    func animationEnded()
}

class WordLabel: UILabel {

    private enum Constant {
        static let maximumLength: CGFloat = 100.0
        static let height: CGFloat = 20.0
        static let fontSize: CGFloat = 15.0
        static let fontName = "Arial-BoldMT"
        static let positionPossibilities = 4
        static let colorPossibilities = 5
        static let animationDuration = 3.0
    }

    enum Position: Int {
        case bottomLeft
        case bottomRight
        case topLeft
        case topRight
    }

    private enum Color: Int {
        case black
        case green
        case blue
        case red
        case purple
    }

    /// Start position of the label
    var position: Position = .bottomLeft

    /// Word label delegate
    var delegate: WordLabelDelegate?

    init(superViewBound: CGRect,
         text: String) {
        position = WordLabel.generateRandomPosition()
        let selfFrame = WordLabel.initialFrame(with: position,
                                               superViewBound: superViewBound)
        super.init(frame: selfFrame)
        alpha = 0
        self.text = text
        font = UIFont(name: Constant.fontName,
                      size: Constant.fontSize)
        textColor = WordLabel.generateRandomWordColor()
        adjustsFontSizeToFitWidth = true;
        minimumScaleFactor = 0.5
        transformLabelAccordingTo(position: position)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Performs move animation within the superViewBounds
    ///
    /// - Parameter superViewBound: Bound of the super view
    func moveWithAnimation(superViewBound: CGRect) {

        let animationFrame = calculateAnimationFrame(superViewBound: superViewBound)
        UIView.animate(withDuration: Constant.animationDuration,
                       animations: {
                        self.frame = animationFrame
                        self.alpha = 1
        }) { (_) in
            UIView.animate(withDuration: Constant.animationDuration,
                           animations: {
                            self.alpha = 0
            }, completion: { [weak self] (_) in
                self?.removeFromSuperview()
                self?.delegate?.animationEnded()
            })
        }
    }
}

// MARK: - Helpers
extension WordLabel {

    /// Generates random word color enum
    static func generateRandomWordColor() -> UIColor {
        let colorNumber = arc4random_uniform(UInt32(Constant.colorPossibilities))
        let color = Color(rawValue: Int(colorNumber)) ?? .black

        switch color {
        case .black:
            return UIColor.black
        case .green:
            return UIColor.green
        case .blue:
            return UIColor.blue
        case .red:
            return UIColor.red
        case .purple:
            return UIColor.purple
        }
    }

    /// Generates after animation frame with given super view bound
    private func calculateAnimationFrame(superViewBound: CGRect) -> CGRect {

        let xPosition :CGFloat
        let yPosition :CGFloat
        let width: CGFloat
        let height: CGFloat
        switch position {
        case .bottomLeft:
            width = Constant.maximumLength
            height = Constant.height
            xPosition = superViewBound.maxX - width
            yPosition = superViewBound.maxY - Constant.height
        case .bottomRight:
            width = Constant.height
            height = Constant.maximumLength
            xPosition = superViewBound.maxX - width
            yPosition = superViewBound.minY
        case .topLeft:
            width = Constant.height
            height = Constant.maximumLength
            xPosition = superViewBound.minX
            yPosition = superViewBound.maxY - height
        case .topRight:
            width = Constant.maximumLength
            height = Constant.height
            xPosition = superViewBound.minX
            yPosition = superViewBound.minY
        }

        return CGRect(x: xPosition,
                      y: yPosition,
                      width: width,
                      height: height)
    }

    /// Generates random position enum
    private static func generateRandomPosition() -> Position {

        let WordPositionNumber = arc4random_uniform(UInt32(Constant.positionPossibilities))
        return Position(rawValue: Int(WordPositionNumber)) ?? .bottomLeft
    }

    /// Applies transformation according to label position
    private func transformLabelAccordingTo(position: Position) {

        let transformConstant: CGFloat
        switch position {
        case .bottomRight:
            transformConstant = -1/2
        case .topRight:
            transformConstant = 1
        case .topLeft:
            transformConstant = 1/2
        case .bottomLeft:
            transformConstant = 0
        }
        let rotationAngle = transformConstant * CGFloat.pi
        self.transform = CGAffineTransform(rotationAngle: rotationAngle)
    }

    /// Generates initial frame of the word label with the position and super view bound
    private static func initialFrame(with position: Position,
                                     superViewBound: CGRect) -> CGRect {

        let xPosition: CGFloat
        let yPosition: CGFloat
        let height = Constant.height
        let width = Constant.maximumLength
        switch position {
        case .bottomLeft:
            xPosition = superViewBound.minX
            yPosition = superViewBound.maxY - height
        case .bottomRight:
            xPosition = superViewBound.maxX - ((width + height) / 2)
            yPosition = superViewBound.maxY - (height * 2)
        case .topLeft:
            xPosition = superViewBound.minX - (height * 2)
            yPosition = superViewBound.minY + (width / 2)
        case .topRight:
            xPosition = superViewBound.maxX - width
            yPosition = superViewBound.minY
        }

        return CGRect(x: xPosition,
                      y: yPosition,
                      width: Constant.maximumLength,
                      height: Constant.height)
    }
}
