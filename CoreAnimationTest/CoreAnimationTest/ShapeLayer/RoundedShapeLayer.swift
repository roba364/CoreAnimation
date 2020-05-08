//
//  SecondViewController.swift
//  CoreAnimationTest
//
//  Created by SofiaBuslavskaya on 04/05/2020.
//  Copyright © 2020 Sergey Borovkov. All rights reserved.
//

import UIKit

class RoundedShapeLayer: UIViewController, CAAnimationDelegate {
    
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.layer.cornerRadius = imageView.frame.size.width / 2
            imageView.layer.borderColor = UIColor.green.cgColor
            imageView.layer.borderWidth = 10
        }
    }
    
    var shapeLayer: CAShapeLayer! {
        didSet {
            shapeLayer.lineWidth = 10
            shapeLayer.lineCap = .round
            shapeLayer.fillColor = nil
            shapeLayer.strokeEnd = 1
            shapeLayer.path = UIBezierPath(roundedRect: CGRect(x: self.imageView.frame.origin.x, y: self.imageView.frame.origin.y, width: self.imageView.frame.size.width, height: self.imageView.frame.size.height), cornerRadius: self.imageView.layer.cornerRadius).cgPath
            shapeLayer.cornerRadius = imageView.layer.cornerRadius
            shapeLayer.strokeColor = UIColor.blue.cgColor
        }
    }
    
    var overShapeLayer: CAShapeLayer! {
        didSet {
            overShapeLayer.lineWidth = 10
            overShapeLayer.lineCap = .round
            overShapeLayer.fillColor = nil
            overShapeLayer.strokeEnd = 0
            overShapeLayer.path = UIBezierPath(roundedRect: CGRect(x: self.imageView.frame.origin.x, y: self.imageView.frame.origin.y, width: self.imageView.frame.size.width, height: self.imageView.frame.size.height), cornerRadius: self.imageView.layer.cornerRadius).cgPath
            overShapeLayer.strokeColor = UIColor.white.cgColor
        }
    }
    
    var gradientLayer: CAGradientLayer! {
        didSet {
            gradientLayer.startPoint = CGPoint(x: 1, y: 0)
            gradientLayer.endPoint = CGPoint(x: 0, y: 1)
            
            let startColor = UIColor.black.cgColor
            let endColor = UIColor.lightGray.cgColor
            
            gradientLayer.colors = [startColor, endColor]
            
            gradientLayer.locations = [0.2, 0.5, 0.8]
        }
    }


    @IBOutlet weak var takeButton: UIButton! {
        didSet {
            takeButton.layer.shadowColor = UIColor.red.cgColor
            takeButton.layer.shadowRadius = 15
            takeButton.layer.shadowOffset = CGSize(width: 10, height: 0)
            takeButton.layer.shadowOpacity = 5
            takeButton.layer.cornerRadius = 10
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gradientLayer = CAGradientLayer()
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        shapeLayer = CAShapeLayer()
        view.layer.addSublayer(shapeLayer)
        
        overShapeLayer = CAShapeLayer()
        view.layer.addSublayer(overShapeLayer)
    }
    
    override func viewDidLayoutSubviews() {
        gradientLayer.frame = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height)
        
//        configShapeLayer(shapeLayer)
//        configShapeLayer(overShapeLayer)
    }
    
    func configShapeLayer(_ shapeLayer: CAShapeLayer) {
        
        shapeLayer.frame = imageView.bounds
        
        let path = UIBezierPath()
        
        // хотим находиться в определенной точке
        // ставим точку и начинаем от нее рисовать траекторию

        path.move(to: CGPoint(x: self.imageView.frame.origin.x, y: self.imageView.frame.origin.y))
        
        path.addLine(to: CGPoint(x: self.imageView.frame.origin.x + imageView.frame.size.width,
                                 y: self.imageView.frame.origin.y))
        
        path.addLine(to:CGPoint(x: self.imageView.frame.origin.x + imageView.frame.size.width,
                                y: self.imageView.frame.origin.y + imageView.frame.size.height))
        
        path.addLine(to:CGPoint(x: self.imageView.frame.origin.x,
                                y: self.imageView.frame.origin.y + imageView.frame.size.height))
        
        path.addLine(to:CGPoint(x: self.imageView.frame.origin.x,
                                y: self.imageView.frame.origin.y))
        
        // присваиваем траекторию в наш shapeLayer
        shapeLayer.path = path.cgPath
    }

    @IBAction func takeButtonTapped(_ sender: Any) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        // анимация будет изменяться до значения 1(до конца)
        animation.toValue = 1
        // анимация будет длиться 2 секунды
        animation.duration = 2
        
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        animation.fillMode = CAMediaTimingFillMode.both
        animation.isRemovedOnCompletion = false
        
        animation.delegate = self
        
        
        overShapeLayer.add(animation, forKey: nil)
    }
    
}
