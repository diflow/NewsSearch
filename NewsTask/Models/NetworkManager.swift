//
//  NetworkManager.swift
//  NewsTask
//
//  Created by ivan on 14.11.2020.
//

import Foundation

class NetworkManager {
    
    // Достаем из JSONa нужные нам параметры
    static func fetchData(url: String, completion: @escaping (_ articles: [Articles])->()) {
        
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let newsStruct = try decoder.decode(NewsStruct.self, from: data)
                let articles = newsStruct.articles
                completion(articles)
            } catch let error {
                let decoder = JSONDecoder()
                let errorAPI = try! decoder.decode(ErrorsAPI.self, from: data)
                print(error)
                print(errorAPI)
            }
        }.resume()
    }
}
