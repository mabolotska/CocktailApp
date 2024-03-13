//
//  UIHelper.swift
//  CocktailApp
//
//  Created by Maryna Bolotska on 11/03/24.
//

import UIKit

enum UIHelper {
    
    static func createTwoColFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
  //      let width =  view.bounds.width
        let padding: CGFloat = 12

        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
  //      flowLayout.itemSize = CGSize(width: itemWidth, height: 230)
        flowLayout.itemSize = UICollectionViewFlowLayout.automaticSize
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        return flowLayout
    }
    
    static func createThreeColFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
      
        let padding: CGFloat = 12

        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
  //      flowLayout.itemSize = CGSize(width: itemWidth, height: 230)
        flowLayout.itemSize = UICollectionViewFlowLayout.automaticSize
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        return flowLayout
    }
}
