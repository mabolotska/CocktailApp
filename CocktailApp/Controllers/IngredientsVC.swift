//
//  IngredientsVC.swift
//  CocktailApp
//
//  Created by Maryna Bolotska on 11/03/24.
//

import UIKit
import RealmSwift

enum Sections {
    case main
}

class IngredientsVC: UIViewController {
    var realm: Realm!
    
    enum Mode {
      case view
      case select
    }
  
    
    lazy var selectBarButton: UIBarButtonItem = {
      let barButtonItem = UIBarButtonItem(title: "Select", style: .plain, target: self, action: #selector(didSelectButtonClicked(_:)))
      return barButtonItem
    }()
    
    var collectionView: UICollectionView!
   var alcoholIngredints = AlcoholManager.alcoholNames
    var dataSource: UICollectionViewDiffableDataSource<Sections, String>!
 


    
    lazy var deleteBarButton: UIBarButtonItem = {
      let barButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(didDeleteButtonClicked(_:)))
      return barButtonItem
    }()
    
    var dictionarySelectedIndecPath: [IndexPath: Bool] = [:]
    
    var mMode: Mode = .view {
      didSet {
        switch mMode {
        case .view:
          for (key, value) in dictionarySelectedIndecPath {
            if value {
              collectionView.deselectItem(at: key, animated: true)
            }
          }
          
          dictionarySelectedIndecPath.removeAll()
          
            selectBarButton.title = "Select"
          navigationItem.leftBarButtonItem = nil
          collectionView.allowsMultipleSelection = false
        case .select:
            selectBarButton.title = "Cancel"
          navigationItem.leftBarButtonItem = deleteBarButton
          collectionView.allowsMultipleSelection = true
        }
      }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshCollectionView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureDataSource()
        configureViewController()
        
        // Initialize Realm
        do {
                realm = try Realm()
                
                // Check if the Ingredient objects exist in Realm
                let ingredientsInRealm = realm.objects(Ingredient.self)
                if ingredientsInRealm.isEmpty {
                    // Add all ingredients from alcoholIngredints to Realm
                    for ingredientName in alcoholIngredints {
                        let ingredient = Ingredient()
                        ingredient.name = ingredientName
                        
                        do {
                            try realm.write {
                                realm.add(ingredient)
                            }
                        } catch {
                            print("Error saving ingredient to Realm: \(error)")
                        }
                    }
                }
            } catch {
                print("Error initializing Realm: \(error)")
            }
        }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: String) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IngredientsCell.reuseID, for: indexPath) as? IngredientsCell
            cell?.categoryLabel.text = identifier
            return cell
        }
 }
    
    
    func getCategoryData(on categories: [String]) {
        var snapshot = NSDiffableDataSourceSnapshot<Sections, String>()
        snapshot.appendSections([.main])
        snapshot.appendItems(categories)
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(IngredientsCell.self, forCellWithReuseIdentifier: IngredientsCell.reuseID)
    }
    func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "List of ingredients"
       var addButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addIngredientButton))

        navigationItem.rightBarButtonItems = [addButton, selectBarButton]
        
      
    }
    
   
    
    @objc func didSelectButtonClicked(_ sender: UIBarButtonItem) {
      mMode = mMode == .view ? .select : .view
    }

    
    @objc func addIngredientButton() {
        let alertController = UIAlertController(title: "Add an ingredient", message: nil, preferredStyle: .alert)
        alertController.addTextField { (textField) in
        }
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
            guard let text = alertController.textFields?.first?.text else { return }

            // Save ingredient to Realm
            let ingredient = Ingredient()
            ingredient.name = text

            do {
                try self.realm.write {
                    self.realm.add(ingredient)
                }
            } catch {
                print("Error saving ingredient to Realm: \(error)")
            }

            // Refresh collection view with latest ingredients from Realm
            self.refreshCollectionView()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }

    func refreshCollectionView() {
        guard let realm = realm else {
                print("Error: Realm is nil")
                return
            }
            
            // Fetch ingredients from Realm and update the collection view
            let ingredients = realm.objects(Ingredient.self).map { $0.name }
            getCategoryData(on: Array(ingredients))
    }
 
    @objc func didDeleteButtonClicked(_ sender: UIBarButtonItem) {
        var deleteNeededIndexPaths: [IndexPath] = []
        for (key, value) in dictionarySelectedIndecPath {
            if value {
                deleteNeededIndexPaths.append(key)
            }
        }

        // Remove items from your data source
        var newIngredients = alcoholIngredints
        for indexPath in deleteNeededIndexPaths.sorted(by: { $0.item > $1.item }) {
            newIngredients.remove(at: indexPath.item)
        }
        
        alcoholIngredints = newIngredients

        // Apply the changes to the diffable data source
        var snapshot = dataSource.snapshot()
        snapshot.deleteItems(deleteNeededIndexPaths.map { indexPath in
            return dataSource.itemIdentifier(for: indexPath)!
        })
        dataSource.apply(snapshot, animatingDifferences: true)

        // Clear selection
        collectionView.indexPathsForSelectedItems?.forEach {
            collectionView.deselectItem(at: $0, animated: false)
        }
        dictionarySelectedIndecPath.removeAll()
    }

  
}

extension IngredientsVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch mMode {
        case .view:
            guard let cell = collectionView.cellForItem(at: indexPath) as? IngredientsCell else {
                       fatalError("Failed to get IngredientsCell.")
                   }
                   cell.selectIndicator.isHidden = true
         
            let text = alcoholIngredints[indexPath.item]
            
            NetworkManager.shared.fetchData(apiKey: Constants.apiKey, url: Constants.baseURL, word: text, completionHandler: { [weak self] ( result: Result<[Cocktail], Error>) in
                switch result {
                case .success(let cocktail):
                    
                    DispatchQueue.main.async {
                        let destVC = FullRecipeVC()
                        destVC.recipes = cocktail
                        
                        self?.navigationController?.pushViewController(destVC, animated: true)
                    }
                case .failure(let error):
                    print("Error fetching quotes: \(error)")
                }
            })
            
        case .select:
            dictionarySelectedIndecPath[indexPath] = true
        }
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
      if mMode == .select {
        dictionarySelectedIndecPath[indexPath] = false
      }
    }
}
