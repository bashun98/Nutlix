//
//  NetworkManager.swift
//  Nutlix
//
//  Created by Евгений Башун on 08.04.2022.
//

import Foundation

protocol NetworkManagerDescription {
    func getTrendingMovies(completion: @escaping (String)->())
}

enum APIError: Error {
    
}
class NetworkManager: NetworkManagerDescription {

    
    static let shared = NetworkManager()
    private init() {}
    
    func getTrendingMovies(completion: @escaping (String) -> ()) {
        guard let url = URL(string: Constants.baseUrl + "/3/trending/all/day?api_key=" + Constants.APIKey) else {return}
        print(url)
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print(error)
            }
            
            guard let data = data else {
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let decodedData = try decoder.decode(JSONModel.self, from: data)

                print(decodedData.results[0].title)
            } catch let error {
                print(error)
            }
        }
        task.resume()
    }
    
 
}
