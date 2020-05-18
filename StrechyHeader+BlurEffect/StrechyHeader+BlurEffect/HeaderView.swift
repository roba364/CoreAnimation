//
//  HeaderView.swift
//  StrechyHeader+BlurEffect
//
//  Created by SofiaBuslavskaya on 18/05/2020.
//  Copyright © 2020 Sergey Borovkov. All rights reserved.
//

import UIKit

class HeaderView: UICollectionReusableView {
    
    let imageView: UIImageView = {
       let iv = UIImageView(image: UIImage(named: "sun"))
        iv.contentMode = .scaleAspectFit
        return iv
    }()
        
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // custom code for layout
        
        backgroundColor = .red
        
        addSubview(imageView)
        
        imageView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
