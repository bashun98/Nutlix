//
//  NetworkManager.swift
//  Nutlix
//
//  Created by Евгений Башун on 08.04.2022.
//

import Foundation

protocol NetworkManagerDescription {
    func getMedia(_ text: String, completion: @escaping (Result<[Media],Error>)->())
}

enum APIError: Error {
    case failedToGetData
}

class NetworkManager: NetworkManagerDescription {

    
    static let shared: NetworkManagerDescription = NetworkManager()
    
    private init() {}
    
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

