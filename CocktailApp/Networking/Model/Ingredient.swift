//
//  Ingredient.swift
//  CocktailApp
//
//  Created by Maryna Bolotska on 13/03/24.
//

import RealmSwift
//
//class Ingredient: Object {
//    
//    @objc dynamic var name: String = ""
//   
//
//    override static func primaryKey() -> String? {
//        return "name"
//    }
//}

class Ingredient: Object {
    @Persisted var name: String = ""
    @Persisted var id = UUID()
}
