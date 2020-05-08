//
//  ButtonAnimationViewController.swift
//  CoreAnimationTest
//
//  Created by SofiaBuslavskaya on 08/05/2020.
//  Copyright © 2020 Sergey Borovkov. All rights reserved.
//

import UIKit

class ButtonAnimationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func pulseButtonTapped(_ sender: UIButton) {
        sender.pulsate()
    }
    
    @IBAction func flashButtonTapped(_ sender: UIButton) {
        sender.flash()
    }
    
    @IBAction func shakeButtonTapped(_ sender: UIButton) {
        sender.shake()
    }
    
}
