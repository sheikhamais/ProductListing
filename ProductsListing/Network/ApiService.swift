//
//  ApiService.swift
//  ProductsListing
//
//  Created by Pro on 27/10/2023.
//

import Foundation

class ApiService {
    
    private init() {}
    static let shared = ApiService()
    
    let session = URLSession(configuration: .default)
    
    func request<T: Decodable>(url: URL?, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = url else {
            return
        }
        
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { data, response, error in
            if let data = data {
                if let results = data.decode(T.self) {
                    completion(.success(results))
                } else {
                    //throw decoding error
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
