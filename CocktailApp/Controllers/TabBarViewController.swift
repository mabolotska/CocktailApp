//
//  TabBarViewController.swift
//  CocktailApp
//
//  Created by Maryna Bolotska on 11/03/24.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let vc1 = SearchViewController()
        let vc2 = IngredientsVC()
       

        vc1.title = "Daily Cocktail"
   //     vc2.title = "List of ingredients"
    

        vc1.navigationItem.largeTitleDisplayMode = .always
  //      vc2.navigationItem.largeTitleDisplayMode = .always
 

        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
       

        nav1.tabBarItem = UITabBarItem(title: "Cocktail", image: UIImage(systemName: "flame"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Ingredients", image: UIImage(systemName: "smiley"), tag: 1)
 

        nav1.navigationBar.prefersLargeTitles = true
    //    nav2.navigationBar.prefersLargeTitles = true


        setViewControllers([nav1, nav2], animated: false)
    }


}


