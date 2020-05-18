//
//  StretchyHeaderController.swift
//  StrechyHeader+BlurEffect
//
//  Created by SofiaBuslavskaya on 18/05/2020.
//  Copyright © 2020 Sergey Borovkov. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class StretchyHeaderController: UICollectionViewController {
    
    fileprivate let cellId = "Cell"
    fileprivate let headerId = "headerId"
    fileprivate let padding: CGFloat = 16
    override func viewDidLoad() {
        super.viewDidLoad()
        // custom code for our collection view
        setupLayout()
        setupCollectionView()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    fileprivate func setupCollectionView() {
        collectionView.backgroundColor = .purple
        collectionView.contentInsetAdjustmentBehavior = .never
        // register cell
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
        // register header
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
    }
    
    fileprivate func setupLayout() {
        
        // layout customization
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionInset = .init(top: padding, left: padding, bottom: padding, right: padding)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 18
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        
        cell.backgroundColor = .black
        
        return cell
    }
}

extension StretchyHeaderController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - padding, height: 50)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath)
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 340)
    }
}
