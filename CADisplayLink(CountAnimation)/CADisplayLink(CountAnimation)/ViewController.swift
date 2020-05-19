//
//  ViewController.swift
//  CADisplayLink(CountAnimation)
//
//  Created by SofiaBuslavskaya on 19/05/2020.
//  Copyright © 2020 Sergey Borovkov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var countingLabel: UILabel = {
        let label = UILabel()
        label.text = "123"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        
        
        return label
    }()
    
    var startValue: Double = 0
    let endValue: Double = 100
    
    let animationStartDate = Date()
    let animationDuration: Double = 1.5

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(countingLabel)
        countingLabel.frame = view.frame
        
        // create my CADisplayLink here
        let displayLink = CADisplayLink(target: self, selector: #selector(handleUpdate))
        displayLink.add(to: .main, forMode: .default)
    }

    @objc func handleUpdate() {
        // time from application launched
        let now = Date()
        let elapsedTime = now.timeIntervalSince(animationStartDate)
        
        if elapsedTime > animationDuration {
            self.countingLabel.text = "\(endValue)"
        } else {
            let percentage = elapsedTime / animationDuration
            let value = startValue + percentage * (endValue - startValue)
            self.countingLabel.text = "\(percentage)"
        }
        
        
        
        
//        self.countingLabel.text = "\(startValue)"
//        startValue += 1
//        if startValue > endValue {
//            startValue = endValue
//        }
    }
}

