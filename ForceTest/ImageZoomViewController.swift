//
//  ViewController.swift
//  ForceTest
//
//  Created by Victor Baro on 10/10/2015.
//  Copyright © 2015 Produkt. All rights reserved.
//

import UIKit

class ImageZoomViewController: UIViewController {
    
    @IBOutlet weak var mainImageView: UIImageView!
    var initialFrame: CGRect = CGRectZero
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let forceGesture = ForceGestureRecognizer()
        forceGesture.addTarget(self, action: Selector("imagePressed:"))
        mainImageView.addGestureRecognizer(forceGesture)
    }
    
    override func viewDidAppear(animated: Bool) {
        initialFrame = mainImageView.frame
    }
    
    func imagePressed(sender: ForceGestureRecognizer) {
        let point = sender.locationInView(self.view)
        let imageCoordPoint = CGPointMake(point.x - initialFrame.origin.x, point.y - initialFrame.origin.y)
        
        var xValue = max(0, imageCoordPoint.x / initialFrame.size.width)
        var yValue = max(0, imageCoordPoint.y / initialFrame.size.height)
        
        xValue = min(xValue, 1)
        yValue = min(yValue, 1)
        
        let anchor = CGPointMake(xValue, yValue)
        mainImageView.layer.anchorPoint = anchor
        let forceValue = max(1, sender.forceValue)
        mainImageView.layer.transform = CATransform3DMakeScale(forceValue, forceValue, 1)
        
        if sender.state == .Ended {
            mainImageView.layer.anchorPoint = CGPointMake(0.5, 0.5)
            mainImageView.layer.transform = CATransform3DIdentity
        }
    }
}

