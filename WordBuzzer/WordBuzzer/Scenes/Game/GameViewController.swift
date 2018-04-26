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

    /// View model
    var viewModel: GameViewModel!

}
