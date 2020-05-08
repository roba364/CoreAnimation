//
//  LoadingCircleViewController.swift
//  CAReplicatorLayerTest
//
//  Created by SofiaBuslavskaya on 08/05/2020.
//  Copyright © 2020 Sergey Borovkov. All rights reserved.
//

import UIKit

class LoadingCircleViewController: UIViewController {
    
    var replicator: CAReplicatorLayer!
    var shapeLayer: CAShapeLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        shapeLayer = CAShapeLayer()
        shapeLayer.frame.size = CGSize(width: 10, height: 20)
        shapeLayer.anchorPoint = CGPoint(x: 1, y: 1)
        shapeLayer.fillColor = UIColor.white.cgColor
        
        replicator = CAReplicatorLayer()
        replicator.position = self.view.center
        replicator.bounds.size = CGSize(width: shapeLayer.frame.height * .pi,
                                        height: shapeLayer.frame.height)
        
        self.view.layer.addSublayer(replicator)
        replicator.addSublayer(shapeLayer)
        
        // start animate replicator
        startAnimation(delay: 0.1, replicates: 20)
    }
    
    private func startAnimation(delay: TimeInterval, replicates: Int) {
        
        replicator.instanceCount = replicates
        replicator.instanceDelay = delay
        
        let angle = CGFloat(2.0 * .pi) / CGFloat(replicates)
        replicator.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1.0)
        
        
        shapeLayer.opacity = 0
        
        let path = CGPath(ellipseIn: shapeLayer.frame, transform: nil)
        shapeLayer.path = path
        
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = 1
        opacityAnimation.toValue = 0
        opacityAnimation.duration = Double(replicates) * delay
        opacityAnimation.repeatCount = Float.infinity

        shapeLayer.add(opacityAnimation, forKey: "activityIndicator")
    }
    

}
