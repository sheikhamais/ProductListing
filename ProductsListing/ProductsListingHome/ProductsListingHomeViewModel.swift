//
//  ProductsListingHomeViewModel.swift
//  ProductsListing
//
//  Created by Pro on 27/10/2023.
//

import Foundation

class ProductsListingHomeViewModel {
    
    private let session = URLSession(configuration: .default)
    var categories = [Category]()
    var products = [Product]()
    var groupedProducts = [Category: [Product]]()
    
    func getAllCategories(completion: @escaping (Result<Bool, Error>) -> Void) {
        let url = URL(string: "") //use your api
        ApiService.shared.request(url: url, responseType: [Category].self) { result in
            switch result {
            case .success(let categories):
                self.categories = categories
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getAllProducts(completion: @escaping (Result<Bool, Error>) -> Void) {
        
        let url = URL(string: "") //use your api
        ApiService.shared.request(url: url, responseType: [Product].self) { result in
            switch result {
            case .success(let products):
                self.products = products
                self.storeGroupedProducts()
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func storeGroupedProducts() {
        for product in products {
            if let category = product.category {
                var products = groupedProducts[category] ?? []
                products.append(product)
                groupedProducts[category] = products
            }
        }
    }
}

//private func getProductsFrom(data: Data) -> [Product] {
//    let jsonDecoder = JSONDecoder()
//    let products = try? jsonDecoder.decode([Product].self, from: data)
//    return products ?? []
//}
//
//private func getCategoriesFrom(data: Data) -> [Category] {
//    let jsonDecoder = JSONDecoder()
//    let categories = try? jsonDecoder.decode([Category].self, from: data)
//    return categories ?? []
//}
//
//private func getData(urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
//    guard let url = URL(string: urlString) else {
//        return
//    }
//    
//    let request = URLRequest(url: url)
//    let task = session.dataTask(with: request) { data, response, error in
//        if let data = data {
//            completion(.success(data))
//        } else if let error = error {
//            completion(.failure(error))
//        }
//    }
//    task.resume()
//}
