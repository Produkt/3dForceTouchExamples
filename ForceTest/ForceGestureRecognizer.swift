//
//  ForceGestureRecognizer.swift
//  ForceTest
//
//  Created by Victor Baro on 17/10/2015.
//  Copyright © 2015 Produkt. All rights reserved.
//

import UIKit.UIGestureRecognizerSubclass

class ForceGestureRecognizer: UIGestureRecognizer {
    
    var forceValue: CGFloat = 0
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent) {
        super.touchesBegan(touches, withEvent: event)
        state = .Began
        handleForceWithTouches(touches)
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent) {
        super.touchesMoved(touches, withEvent: event)
        state = .Changed
        handleForceWithTouches(touches)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent) {
        super.touchesEnded(touches, withEvent: event)
        state = .Ended
        handleForceWithTouches(touches)
    }
    
    func handleForceWithTouches(touches: Set<UITouch>) {
        if touches.count != 1 {
            state = .Failed
            return
        }
        
        guard let touch = touches.first else {
            state = .Failed
            return
        }
        forceValue = touch.force
    }
}
