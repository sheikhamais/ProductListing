//
//  Data+Ext.swift
//  ProductsListing
//
//  Created by Pro on 27/10/2023.
//

import Foundation

extension Data {
    func decode<T: Decodable>(_ type: T.Type) -> T? {
        let decoder = JSONDecoder()
        return try? decoder.decode(type, from: self)
    }
}
