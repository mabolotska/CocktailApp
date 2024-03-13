//
//  FullRecipeVC.swift
//  CocktailApp
//
//  Created by Maryna Bolotska on 12/03/24.
//

import UIKit

class FullRecipeVC: UIViewController {
    var recipes: [Cocktail] = []
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RecipeCell.self, forCellReuseIdentifier: "RecipeCell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        print(recipes)
    }
}

extension FullRecipeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as! RecipeCell
      
        let model = recipes[indexPath.row]
        cell.set(model: model)
        
        return cell
    }
}

    extension FullRecipeVC {
        func setupUI() {
            title = "Cocktails"
            view.backgroundColor = .white
            view.addSubview(tableView)
            
            tableView.snp.makeConstraints { make in
                make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
                make.leading.trailing.bottom.equalToSuperview()
            }
        }
    }
