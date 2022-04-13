//
//  NetworkManager.swift
//  Nutlix
//
//  Created by Евгений Башун on 08.04.2022.
//

import Foundation
import Alamofire

protocol NetworkManagerDescription {
    func getMedia(_ text: String, completion: @escaping (Result<[Media],Error>)->())
    func getSomething(_ query: String, completion: @escaping (Result<[Media],Error>) -> () )
}

enum APIError: Error {
    case failedToGetData
}

final class NetworkManager: NetworkManagerDescription {

    
    static let shared: NetworkManagerDescription = NetworkManager()
    
    private init() {}

    func getSomething(_ query: String, completion: @escaping (Result<[Media],Error>) -> () ) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=e1cc97d140fcc157ddbea74c5ee7f415&query=\(query)") else {return}
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print(error)
            }
            
            guard let data = data else {
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let decodedData = try decoder.decode(JSONResponse.self, from: data)
                completion(.success(decodedData.results))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getMedia(_ text: String, completion: @escaping (Result<[Media],Error>) -> ()) {
        guard let url = URL(string: Constants.baseUrl + "/\(text)" + "?api_key=" + Constants.APIKey) else {return}
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print(error)
            }
            
            guard let data = data else {
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let decodedData = try decoder.decode(JSONResponse.self, from: data)
                completion(.success(decodedData.results))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
 
}

