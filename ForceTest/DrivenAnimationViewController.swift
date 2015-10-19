//
//  DrivenAnimationViewController.swift
//  ForceTest
//
//  Created by Victor Baro on 18/10/2015.
//  Copyright © 2015 Produkt. All rights reserved.
//

import UIKit

class DrivenAnimationViewController: UIViewController {
    
    @IBOutlet weak var mainImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAnimations()
        let gesture = ForceGestureRecognizer()
        gesture.addTarget(self, action: Selector("backgroundPressed:"))
        view.addGestureRecognizer(gesture)
    }
    
    func setupAnimations() {
        addRotationAnimation()
        addScaleAnimation()
        mainImageView.layer.speed = 0.0
    }

    func addRotationAnimation() {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.fromValue = NSNumber(double: 1.0)
        animation.toValue = NSNumber(double: 2.0)
        animation.duration = 1
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        mainImageView.layer.addAnimation(animation, forKey: "scaleAnimation")
    }
    
    func addScaleAnimation() {
        let animation = CASpringAnimation(keyPath: "transform.translation.y")
        animation.toValue = NSNumber(double: -100)
        animation.duration = 1
        mainImageView.layer.addAnimation(animation, forKey: "translationAnimation")
    }
    
    func backgroundPressed(sender: ForceGestureRecognizer) {
        if sender.state == .Ended {
            mainImageView.layer.timeOffset = 0
            return
        }
        mainImageView.layer.timeOffset = Double(sender.forceValue/7)
    }
    
    
}
