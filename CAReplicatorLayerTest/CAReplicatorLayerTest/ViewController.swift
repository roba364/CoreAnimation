//
//  ViewController.swift
//  CAReplicatorLayerTest
//
//  Created by SofiaBuslavskaya on 05/05/2020.
//  Copyright © 2020 Sergey Borovkov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var replicatorLayer: CAReplicatorLayer!
    var sourceLayer: CAShapeLayer! {
        didSet {
            sourceLayer.lineWidth = 1
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        replicatorLayer = CAReplicatorLayer()
        sourceLayer = CAShapeLayer()
        
        // в слой(layer) нашего основго вью мы добавляем подслой
        self.view.layer.addSublayer(replicatorLayer)
        // а в слой replicatorLayer мы добавляем подслой sourceLayer
        replicatorLayer.addSublayer(sourceLayer)
        
        
        startAnimation(delay: 0.1, replicates: 15)
    }

    // метод который срабатывает каждый раз когда мы меняем размер нашего дисплея, например поворачиваем
    override func viewWillLayoutSubviews() {
        
        // Frame - это рамка, расположенная внутри какого-то суперкласса, который использует координаты суперкласса
        // здесь мы указываем что наша рамка должна располагаться тамже, где находятся координаты основного суперкласса(VIEW)
        // Frame - определяет позицию и размер в системе координат суперкласса
        // Bounds - используется использует свою собственную систему координат, своего собственного вью
        replicatorLayer.frame = self.view.bounds
        // определяем позицию
        replicatorLayer.position = self.view.center
        
        sourceLayer.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
        sourceLayer.cornerRadius = sourceLayer.frame.width / 2
        sourceLayer.backgroundColor = UIColor.white.cgColor
        sourceLayer.position = self.view.center
        // определяем точку вокруг которой будет происходить анимация вращения
        sourceLayer.anchorPoint = CGPoint(x: 0.0, y: 5.0)
    }
    
    // метод который будет анимировать наше изображение
    func startAnimation(delay: TimeInterval, replicates: Int) {
        
        // задаем количество копий(сечки) которые будут использованы в индикаторе
        replicatorLayer.instanceCount = replicates
        // задаем угол в единицу времени, с помощью (2.0 * M_PI) делаем угол 360
        // также высчитываем одинаковое расстояние между сечек
        let angle = CGFloat(2.0 * .pi) / CGFloat(replicates)
        replicatorLayer.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1.0)
        replicatorLayer.instanceDelay = delay
        
        sourceLayer.opacity = 0
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = 1
        opacityAnimation.toValue = 0
        opacityAnimation.duration = Double(replicates) * delay
        opacityAnimation.repeatCount = Float.infinity
        
        // в ключе можем указать имя, по которому можно обращаться к анимации
        sourceLayer.add(opacityAnimation, forKey: "activityIndicator")
    }
    
}

