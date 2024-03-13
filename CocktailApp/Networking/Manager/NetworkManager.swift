//
//  NetworkManager.swift
//  CocktailApp
//
//  Created by Maryna Bolotska on 11/03/24.
//


import UIKit
import Alamofire


class NetworkManager {
    static let shared = NetworkManager()
    
    private init() { }
    
    typealias completionHandler = (Result<[Cocktail], Error>) -> Void

    

    func fetchData<T: Decodable>(apiKey: String, url: String, word: String? = nil, completionHandler: @escaping (Result<T, Error>) -> Void) {
        let headers: HTTPHeaders = [
            "X-Api-Key": Constants.apiKey
        ]
        
        let newUrl = url + (word ?? "")
        
        AF.request(newUrl, method: .get, parameters: nil, headers: headers).validate().responseDecodable(of: T.self) {  response in
           
            switch response.result {
            case .success(let data):
                completionHandler(.success(data))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
   
    
    

    
  
    
}

