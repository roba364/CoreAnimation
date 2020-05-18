//
//  HeaderView.swift
//  StrechyHeader+BlurEffect
//
//  Created by SofiaBuslavskaya on 18/05/2020.
//  Copyright © 2020 Sergey Borovkov. All rights reserved.
//

import UIKit

import UIKit

class HeaderView: UICollectionReusableView {
    
    let imageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "sun"))
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    var visualEffectView =  UIVisualEffectView(effect: nil)
    let animator = UIViewPropertyAnimator(duration: 0.5, curve: .linear)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // custom code for layout
        
        backgroundColor = .red
        
        
        addSubview(imageView)
        imageView.fillSuperview()
        
        //blur
        setupVisualEffectBlur()
    }
    
    fileprivate func setupVisualEffectBlur() {
        self.addSubview(visualEffectView)
        
        animator.addAnimations {
            self.visualEffectView.effect = UIBlurEffect(style: .regular)
        }
        
        animator.fractionComplete = 0
        
        visualEffectView.fillSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
