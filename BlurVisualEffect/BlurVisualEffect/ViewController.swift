//
//  ViewController.swift
//  BlurVisualEffect
//
//  Created by SofiaBuslavskaya on 08/05/2020.
//  Copyright © 2020 Sergey Borovkov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var addItemView: UIView!
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    
    var effect: UIVisualEffect!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        effect = visualEffectView.effect
        visualEffectView.effect = nil
        
        addItemView.layer.cornerRadius = 5
    }
    
    private func animateIn() {
        self.view.addSubview(addItemView)
        addItemView.center = self.view.center
        
        addItemView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        addItemView.alpha = 0
        
        UIView.animate(withDuration: 0.4) {
            self.visualEffectView.effect = self.effect
            self.addItemView.alpha = 1
            self.addItemView.transform = CGAffineTransform.identity
        }
    }
    
    private func animateOut() {
        UIView.animate(withDuration: 0.3, animations: {
            self.addItemView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.addItemView.alpha = 0
            
            self.visualEffectView.effect = nil
        }) { (_) in
            self.addItemView.removeFromSuperview()
        }
    }

    @IBAction func addTapped(_ sender: UIBarButtonItem) {
        animateIn()
    }
    
    @IBAction func doneButton(_ sender: UIButton) {
        animateOut()
    }
}

