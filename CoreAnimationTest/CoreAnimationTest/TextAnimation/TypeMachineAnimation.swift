//
//  TypeMachineAnimation.swift
//  CoreAnimationTest
//
//  Created by SofiaBuslavskaya on 08/05/2020.
//  Copyright © 2020 Sergey Borovkov. All rights reserved.
//

import UIKit
import AVFoundation

class TypeMachineAnimation: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    
    var string = "Destiny is All"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(clickView))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func clickView() {

        for i in string {
            AudioServicesPlaySystemSound(1306)
            textLabel.text! += String(i)
            RunLoop.current.run(until: Date() + 0.12)
        }
        textLabel.text = ""
        perform(#selector(nextVC), with: nil, afterDelay: 1)
    }
    
    @objc private func nextVC() {
        performSegue(withIdentifier: "toDestinyVC", sender: self)
    }
}
