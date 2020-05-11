//
//  ViewController.swift
//  LayoutAnimations
//
//  Created by SofiaBuslavskaya on 11/05/2020.
//  Copyright © 2020 Sergey Borovkov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var toggleButton: UIButton!
    
    @IBOutlet var menuHeightConstraint: NSLayoutConstraint!
    @IBOutlet var toggleButtonTrailingConstraint: NSLayoutConstraint!
    
    //MARK: - Properties
    
    var slider: HorizontalItemsList!
    var menuIsOpen = false
    var items = [5, 6, 7]

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: - Actions
    
    @IBAction func toggleMenu(_ sender: Any) {
        menuIsOpen = !menuIsOpen
        
        titleLabel.text = menuIsOpen ? "Select Item" : "Packing List"
        view.layoutIfNeeded()
        titleLabel.superview?.constraints.forEach({ (constraint) in
            print("constraint - \(constraint.description)\n")
        })
        
        
        menuHeightConstraint.constant = menuIsOpen ? 200 : 80
        toggleButtonTrailingConstraint.constant = menuIsOpen ? 16 : 8
        
        UIView.animate(withDuration: 1.0,
                       delay: 0,
                       usingSpringWithDamping: 0.4,
                       initialSpringVelocity: 10,
                       options: .curveEaseIn,
                       animations: {
                        let angle = self.menuIsOpen ? CGFloat.pi / 4 : 0.0
                        self.toggleButton.transform = CGAffineTransform(rotationAngle: angle)
                        self.view.layoutIfNeeded()
        },
                       completion: nil)
    }
    
    //MARK: - Methods
    
    private func showItem(_ index: Int) {
        let imageView = makeImageView(index: index)
        view.addSubview(imageView)
        
        let conX = imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let conBottom = imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: imageView.frame.height)
        let conWidth = imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.33, constant: -50.0)
        let conHeight = imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
        
        NSLayoutConstraint.activate([conX, conBottom, conWidth, conHeight])
        view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.8,
                       delay: 0,
                       usingSpringWithDamping: 0.4,
                       initialSpringVelocity: 10,
                       options: .curveEaseIn,
                       animations: {
                        conBottom.constant = -imageView.frame.height * 2
                        conWidth.constant = 0.0
                        self.view.layoutIfNeeded()
        },
                       completion: nil)
        
        UIView.transition(with: imageView,
                          duration: 1,
                          options: .transitionFlipFromBottom,
                          animations: {
                            imageView.removeFromSuperview()
        }) { (_) in
            
        }
        
        UIView.animate(withDuration: 0.67,
                       delay: 2.0,
                       animations: {
                        conBottom.constant = imageView.frame.height
                        conWidht.constant = -50.0
                        self.view.layoutIfNeeded()
        },
                       completion: { _ in
                        imageView.removeFromSuperview()
        })
    }
    

}

