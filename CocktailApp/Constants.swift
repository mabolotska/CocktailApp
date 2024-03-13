//
//  Constants.swift
//  CocktailApp
//
//  Created by Maryna Bolotska on 11/03/24.
//

import UIKit


enum Constants {
    static let baseURL = "https://api.api-ninjas.com/v1/cocktail?name="
    static let apiKey = "J6XxwQA06zLZvJaD20+znQ==az5H8lGqh3N7cAFS"
    static let ingredientsURL = "https://api.api-ninjas.com/v1/cocktail?ingredients="
}
struct CellHeight {
    let width =  UIScreen.main.bounds.size.width
    let padding: CGFloat = 12
    let minimumItemSpacing: CGFloat = 10
 //   let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2)
   
   var itemWidth: CGFloat {
          let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2)
          return availableWidth / 2
      }
 //   let itemWidth = availableWidth / 2
    
}

class AlcoholManager {
    static let alcoholNames = [
        "Vodka",
        "Gin",
        "Rum",
        "Tequila",
        "Whiskey",
        "Bourbon",
        "Brandy",
        "Scotch",
        "Cognac",
        "Schnapps",
        "Absinthe",
        "Sake",
        "Mezcal",
        "Rye whiskey",
        "Irish whiskey"
     
    ]
}
