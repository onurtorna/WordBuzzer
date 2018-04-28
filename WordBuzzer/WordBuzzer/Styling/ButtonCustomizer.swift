//
//  ButtonCustomizer.swift
//  WordBuzzer
//
//  Created by Onur Torna on 29/04/18.
//  Copyright © 2018 Onur Torna. All rights reserved.
//

import UIKit

class ButtonCustomizer {

    static func applyBuzzerStyleTo(button: UIButton,
                                   color: UIColor) {

        button.backgroundColor = color
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.clipsToBounds = true
    }

}

