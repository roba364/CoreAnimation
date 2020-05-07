//
//  View.swift
//  MaskDemo
//
//  Created by SofiaBuslavskaya on 05/05/2020.
//  Copyright © 2020 Sergey Borovkov. All rights reserved.
//

import UIKit

@IBDesignable
class View: UIView {
    
    private var size = CGSize()
    // позволяет создать в Interface Builder свойство, которое можно будет изменять там
    @IBInspectable var cornerRadiiSize: CGFloat = 0 {
        didSet {
            size = CGSize(width: cornerRadiiSize, height: cornerRadiiSize)
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = UIBezierPath(roundedRect: self.bounds,
                                       byRoundingCorners: [.topLeft, .bottomRight],
                                       cornerRadii: size).cgPath
        
        layer.mask = shapeLayer
    }

    // этот метод позволит отображать все изменения которые у нас происходят
    override func prepareForInterfaceBuilder() {
        // так как мы меняем форму нашей View, ей надо перерисоваться
        setNeedsLayout()
    }
}
