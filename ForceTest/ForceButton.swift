//
//  ForceButton.swift
//  ForceTest
//
//  Created by Victor Baro on 17/10/2015.
//  Copyright © 2015 Produkt. All rights reserved.
//

import UIKit

enum ForceButtonType: Int {
    case Shadow = 0
    case Scale = 1
}

class ForceButton: UIButton {
    
    private let maxForceValue: CGFloat = 6.6
    
    var shadowColor: UIColor = UIColor.lightGrayColor()
    var shadowOpacity: Float = 0.8
    var maxShadowOffset: CGSize = CGSize(width: 6.6, height: 6.6)
    var maxShadowRadius: CGFloat = 10.0
    var forceButtonType: ForceButtonType = .Scale
    
    @IBInspectable var inspectableType: Int {
        get { return self.forceButtonType.rawValue }
        set { self.forceButtonType =  ForceButtonType(rawValue: newValue) ?? .Shadow }
    }
    
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        shadowWithAmount(0.0)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        handleForceWithTouches(touches)
    }

    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesMoved(touches, withEvent: event)
        handleForceWithTouches(touches)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)
        switch forceButtonType {
        case .Shadow:
            shadowWithAmount(0.0)
        case .Scale:
            scaleWithAmount(0.0)
        }
    }
    
    func handleForceWithTouches(touches: Set<UITouch>) {
        if touches.count != 1 {
            return
        }
        guard let touch = touches.first else {
            return
        }
        switch forceButtonType {
        case .Shadow:
            shadowWithAmount(touch.force)
        case .Scale:
            scaleWithAmount(touch.force)
        }
    }
    
    func shadowWithAmount(amount: CGFloat) {
        layer.shadowColor = shadowColor.CGColor
        layer.shadowOpacity = shadowOpacity
        let widthFactor = maxShadowOffset.width/maxForceValue
        let heightFactor = maxShadowOffset.height/maxForceValue
        layer.shadowOffset = CGSize(width: maxShadowOffset.width - amount * widthFactor,
                                    height: maxShadowOffset.height - amount * heightFactor)
        layer.shadowRadius = maxShadowRadius - amount
    }
    
    func scaleWithAmount(amount: CGFloat) {
        layer.transform = CATransform3DMakeScale(1 + amount/100, 1 + amount/100, 1)
    }
}