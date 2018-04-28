//
//  CALayer+Animation.swift
//  WordBuzzer
//
//  Created by Onur Torna on 29/04/18.
//  Copyright © 2018 Onur Torna. All rights reserved.
//

import UIKit

extension CALayer {

    func pause() {
        let pausedTime: CFTimeInterval = convertTime(CACurrentMediaTime(), from: nil)
        speed = 0.0
        timeOffset = pausedTime
    }

    func resume() {
        let pausedTime: CFTimeInterval = timeOffset
        speed = 1.0
        timeOffset = 0.0
        beginTime = 0.0
        let timeSincePause: CFTimeInterval = convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        beginTime = timeSincePause
    }
}
