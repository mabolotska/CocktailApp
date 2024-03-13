//
//  RecipeCell.swift
//  CocktailApp
//
//  Created by Maryna Bolotska on 12/03/24.
//

import UIKit

class RecipeCell: UITableViewCell {
    
    static let reuseID = "RecipeCell"
    let cellHeight = CellHeight()

    
    let backgroundViewBlue: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.layer.cornerRadius = 8
        return view
    }()
    
    let nameLabel = UILabel(text: "Cocktail", aligment: .center)
    let ingredientsLabel = UILabel(text: "List of products", aligment: .left, numberOfLines: 0)
    let instructionsLabel = UILabel(text: "How to make", aligment: .left, numberOfLines: 0)

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(model: Cocktail) {
        nameLabel.text = model.name
        ingredientsLabel.text = model.ingredients?.compactMap { $0 }.joined(separator: ", ") ?? "No ingredients available"
        instructionsLabel.text = model.instructions
    }

    private func configure() {
        addSubview(backgroundViewBlue)
        backgroundViewBlue.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(5)
            make.bottom.trailing.equalToSuperview().offset(-5)
            make.width.equalTo(150)
        }
        
        backgroundViewBlue.addSubview(nameLabel)
        backgroundViewBlue.addSubview(ingredientsLabel)
        backgroundViewBlue.addSubview(instructionsLabel)
      
        nameLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(5)
        }
        
        ingredientsLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview().inset(5)
        }
        
        instructionsLabel.snp.makeConstraints { make in
            make.top.equalTo(ingredientsLabel.snp.bottom).offset(5)
            make.leading.trailing.bottom.equalToSuperview().inset(5)
        }
    }
}
