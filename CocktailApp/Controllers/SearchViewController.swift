//
//  ViewController.swift
//  CocktailApp
//
//  Created by Maryna Bolotska on 11/03/24.
//

import UIKit
import SnapKit

enum Section {
    case main
}

class SearchViewController: UIViewController, UICollectionViewDelegate {

    var collectionView: UICollectionView!
    var emptyArrayToCancel: [Cocktail] = []
    var filteredCocktails: [Cocktail] = []
    var dataSource: UICollectionViewDiffableDataSource<Section, String>!
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
         configureDataSource()
         configureViewController()
         configureSearchController()
        
    }

    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: String) -> UICollectionViewCell? in
             
            guard let cocktail = self.filteredCocktails.first(where: { $0.name == identifier }) else {
                return nil
            }
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CocktailCell.reuseID, for: indexPath) as? CocktailCell
            cell?.set(model: cocktail)
            return cell
        }
    }

    
    func getCategoryData(on array: [Cocktail]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        snapshot.appendSections([.main])
        let cocktailNames = array.compactMap { $0.name }
        snapshot.appendItems(cocktailNames, toSection: .main)
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createTwoColFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(CocktailCell.self, forCellWithReuseIdentifier: CocktailCell.reuseID)
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
       
        navigationController?.navigationBar.prefersLargeTitles = true
        
      
    }
    
    func configureSearchController() {
          let searchController = UISearchController()
          searchController.searchResultsUpdater = self
  
          searchController.searchBar.placeholder = "Search for a cocktail"
          searchController.obscuresBackgroundDuringPresentation = false // removes light overlay on results below
          navigationItem.searchController = searchController
        searchController.searchBar.tintColor = .red // Change cancel button color
       
      }

}




extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            filteredCocktails.removeAll()
            getCategoryData(on: [])
            return
        }
       
        NetworkManager.shared.fetchData(apiKey: Constants.apiKey, url: Constants.baseURL, word: filter) { (result: Result<[Cocktail], Error>) in
            switch result {
            case .success(let cocktails):
                
                self.filteredCocktails = cocktails
                
                self.getCategoryData(on: cocktails)
            case .failure(let error):
                print("Error fetching cocktail data: \(error)")
              
            }
        }
        
        
        
        let filteredResults = filteredCocktails.filter { $0.name?.lowercased().contains(filter.lowercased()) ?? false }
        print("Filtered Results: \(filteredResults)")
        
        getCategoryData(on: filteredResults)
        print("filteredCocktails after update: \(filteredCocktails)")
    }

}
