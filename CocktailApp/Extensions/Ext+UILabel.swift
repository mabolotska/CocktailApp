//
//  Ext+UILabel.swift
//  CocktailApp
//
//  Created by Maryna Bolotska on 11/03/24.
//

import UIKit

extension UILabel {
    convenience init(text: String, textColor: UIColor = .white, aligment: NSTextAlignment = .left, numberOfLines: Int = 0) {
        self.init()
        self.text = text
        self.textColor = textColor
        self.textAlignment = aligment
        self.numberOfLines = numberOfLines
    }
}
