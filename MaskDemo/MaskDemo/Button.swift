//
//  Button.swift
//  MaskDemo
//
//  Created by SofiaBuslavskaya on 05/05/2020.
//  Copyright © 2020 Sergey Borovkov. All rights reserved.
//

import UIKit

@IBDesignable
class Button: UIButton {
    
    private var cornerRadii = CGSize()
    @IBInspectable var cornerRadius: CGFloat = 0 {
        // как только мы устанавливаем значение мы меняем наш cornerRadii на значение, которое мы выбираем ручками в InterfaceBuilder'e на стрелочки
        didSet {
            cornerRadii = CGSize(width: cornerRadius, height: cornerRadius)
        }
    }
    
    // создаем новое свойство выбора цвета в Interface Builder'e
    @IBInspectable var color: UIColor = .green
    
    var path: UIBezierPath?

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: cornerRadii)
        // заполняем нашу получившуюся фигуру BezierPath - зеленым цветом
        color.setFill()
        path?.fill()
    }
    
    // в этом методе мы будет избавлять от проблемы тапа по белой зоне, в которой раньше были углы кнопки
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        // проверяем, лежит ли поинт внутри нашей траектории
        if let path = path {
            return path.contains(point)
        }
        return false
    }

}
