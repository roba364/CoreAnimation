//
//  ChainTextAnimation.swift
//  CoreAnimationTest
//
//  Created by SofiaBuslavskaya on 08/05/2020.
//  Copyright © 2020 Sergey Borovkov. All rights reserved.
//

import UIKit

class ChainTextAnimation: UIViewController {
    
    @IBOutlet weak var destinyLabel: UILabel!
    @IBOutlet weak var isLabel: UILabel!
    @IBOutlet weak var allLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        destinyLabel.isHidden = true
        isLabel.isHidden = true
        allLabel.isHidden = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(clickView))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func clickView() {
        
        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 1.0,
                       options: .curveEaseInOut,
                       animations: {
                        self.destinyLabel.isHidden = false
                        self.destinyLabel.transform = CGAffineTransform(translationX: 0, y: -120)
        }) { (_) in
            UIView.animate(withDuration: 0.5,
                           delay: 0.0,
                           usingSpringWithDamping: 1,
                           initialSpringVelocity: 1,
                           options: .curveEaseInOut,
                           animations: {
                            self.isLabel.isHidden = false
                            self.isLabel.transform = CGAffineTransform(translationX: 0, y: -80)
            }) { (_) in
                UIView.animate(withDuration: 0.5,
                               delay: 0.0,
                               usingSpringWithDamping: 1,
                               initialSpringVelocity: 1,
                               options: .curveEaseInOut,
                               animations: {
                                self.allLabel.isHidden = false
                                self.allLabel.transform = CGAffineTransform(translationX: 0, y: -40)
                }) { (_) in
                    UIView.animate(withDuration: 1,
                                   delay: 0.0,
                                   usingSpringWithDamping: 1,
                                   initialSpringVelocity: 1,
                                   options: .curveEaseInOut,
                                   animations: {
                                    self.destinyLabel.transform = CGAffineTransform(translationX: -300, y: -120)
                    }) { (_) in
                        UIView.animate(withDuration: 1,
                                       delay: 0.0,
                                       usingSpringWithDamping: 1,
                                       initialSpringVelocity: 1,
                                       options: .curveEaseInOut,
                                       animations: {
                                        self.isLabel.transform = CGAffineTransform(translationX: 300,
                                                              y: -80)
                        }) { (_) in
                            UIView.animate(withDuration: 1,
                                           delay: 0.0,
                                           usingSpringWithDamping: 1,
                                           initialSpringVelocity: 1,
                                           options: .curveEaseInOut,
                                           animations: {
                                            self.allLabel.transform = CGAffineTransform(translationX: -300,y: -40)
                            }) { (_) in
                                self.performSegue(withIdentifier: "toNextVC", sender: self)
                            }
                        }
                    }
                }
            }
        }
    }
}
