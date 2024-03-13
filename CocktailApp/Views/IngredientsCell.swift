//
//  IngredientsCell.swift
//  CocktailApp
//
//  Created by Maryna Bolotska on 12/03/24.
//

import UIKit

class IngredientsCell: UICollectionViewCell {
    static let reuseID = "IngredientsCell"
    
    let categoryLabel = UILabel(text: "Name", textColor: .blue, aligment: .center)
    let backgroundViewBlue: UIView = {
        let view = UIView()
        view.layer.borderWidth = 3
        view.layer.borderColor = UIColor.blue.cgColor
        view.layer.cornerRadius = 8
        return view
    }()
    
    let selectIndicator: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "chevron.down")
        return image
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        didSet {
            selectIndicator.isHidden = !isSelected
        }
    }
    
    

    private func configure() {
        selectIndicator.isHidden = true
        addSubview(backgroundViewBlue)
        backgroundViewBlue.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(5)
            make.bottom.trailing.equalToSuperview().offset(-5)
            make.width.equalTo(150)
        }
        
        backgroundViewBlue.addSubview(categoryLabel)
        categoryLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        backgroundViewBlue.addSubview(selectIndicator)
        selectIndicator.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-5)
        }
    }
}


