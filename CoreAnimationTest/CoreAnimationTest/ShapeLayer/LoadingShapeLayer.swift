//
//  ViewController.swift
//  CoreAnimationTest
//
//  Created by SofiaBuslavskaya on 04/05/2020.
//  Copyright © 2020 Sergey Borovkov. All rights reserved.
//

import UIKit

class LoadingShapeLayer: UIViewController, CAAnimationDelegate {
    
    var shapeLayer: CAShapeLayer! {
        didSet {
            // толщина линии которой будет совершаться обводка
            shapeLayer.lineWidth = 20
            // закругленные края
            shapeLayer.lineCap = CAShapeLayerLineCap(rawValue: "round")
            // чтобы фигура не заполнялась дэфолтным черным цветом, ставим nil
            shapeLayer.fillColor = nil
            // когда мы будем создавать второй слой, strokeEnd не будет единицей, иначе он перекроет shapeLayer
            // вся траектория идет от 0 до 1
            // слева - 0, справа - 1
            shapeLayer.strokeEnd = 1
            shapeLayer.strokeColor = UIColor.blue.cgColor
        }
    }
    
    var overShapeLayer: CAShapeLayer! {
        didSet {
            overShapeLayer.lineWidth = 20
            overShapeLayer.lineCap = CAShapeLayerLineCap(rawValue: "round")
            // чтобы фигура не заполнялась дэфолтным черным цветом, ставим nil
            overShapeLayer.fillColor = nil
            // когда мы будем создавать второй слой, strokeEnd не будет единицей, иначе он перекроет shapeLayer
            overShapeLayer.strokeEnd = 0
            overShapeLayer.strokeColor = UIColor.white.cgColor
        }
    }
    
    var gradientLayer: CAGradientLayer! {
        // устанавливаем значения
        didSet {
            // начальная и конечная точка градиента
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 0, y: 1)
            // массив цветов, которые будут использованы в градиенте
            // используем cgColor, так как layer работает с Core Graphics, и он ожидает CgColor, а не UIColor
            let startColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1).cgColor
            let endColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1).cgColor
            gradientLayer.colors = [startColor, endColor]
            // делаем так чтобы перетекание цветов было не 50/50, а сдвигаем например 20/80
//            gradientLayer.locations = [0, 0.2, 1]
        }
    }

    @IBOutlet weak var imageView: UIImageView! {
        // наблюдатель свойства работает таким образом, что когда у нас присваивается новое значение imageView, то у нас устанавливаются те свойства, которые у нас меняться не будут
        didSet {
            imageView.layer.cornerRadius = imageView.frame.size.height / 2
            imageView.layer.masksToBounds = true
            imageView.layer.borderColor = UIColor.gray.cgColor
            imageView.layer.borderWidth = 2
        }
    }
    @IBOutlet weak var tapButton: UIButton! {
        didSet {
            tapButton.layer.shadowOffset = CGSize(width: 0, height: 10)
            tapButton.layer.shadowOpacity = 0.5
            tapButton.layer.shadowRadius = 5
        }
    }
    
    // этот метод срабатывает каждый раз когда у нас меняется ориентация нашего девайса и у нас идет пересчитывание позиции X и Y, потому что высота становится шириной и ширина высотой
    override func viewDidLayoutSubviews() {
        gradientLayer.frame = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height)
        
        // задаем место где будет отображаться shapeLayer
        configShapeLayer(shapeLayer)
        configShapeLayer(overShapeLayer)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gradientLayer = CAGradientLayer()
        // вставляем gradientLayer как самый нижний слой view
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        shapeLayer = CAShapeLayer()
        view.layer.addSublayer(shapeLayer)
        
        overShapeLayer = CAShapeLayer()
        view.layer.addSublayer(overShapeLayer)
    }
    
    // задаем место где будет отображаться shapeLayer
    func configShapeLayer(_ shapeLayer: CAShapeLayer) {
        shapeLayer.frame = view.bounds
        
        // для того чтобы определить форму нашего shapeLayer, нам нужен path(траектория, для отрисовки shapeLayer)
        // UIBezierPath можем использовать для создания кругов, овалов, прямоугольников с закругленным углами
        // В этом классе есть несколько инициализаторов, которые позволяю создавать простые формы
        let path = UIBezierPath()
        
        // хотим находиться в определенной точке
        // ставим точку и начинаем от нее рисовать траекторию
        path.move(to: CGPoint(x: self.view.frame.width / 2 - 100,
                              y: self.view.frame.height / 2))
        
        // начинаем рисовать траекторию. Мы добавляем линию до следующей точки
        // наши точки симметричны от центра экрана по оси X(+100 и -100) и на одной линии по оси Y
        path.addLine(to: CGPoint(x: self.view.frame.width / 2 + 100,
        y: self.view.frame.height / 2))
        
        // присваиваем траекторию в наш shapeLayer
        shapeLayer.path = path.cgPath
    }
    @IBAction func tapButtonTapped(_ sender: Any) {
        
        // ---> 1ый способ, по нажатию прибавляет strokeEnd свойство второго белого слоя и затем показываем второй VC <---
//        overShapeLayer.strokeEnd += 0.2
//        if overShapeLayer.strokeEnd == 1 {
//            performSegue(withIdentifier: "showSecondVC", sender: nil)
//        }
        
        // ---> 2ой способ, анимация <---
        
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
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        performSegue(withIdentifier: "showSecondVC", sender: self)
    }

}



