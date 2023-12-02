//
//  Product.swift
//  ProductsListing
//
//  Created by Pro on 27/10/2023.
//

import Foundation

struct Product: Codable {
    let id: Int?
    let title: String?
    let price: Int?
    let description: String?
    let images: [String]?
    let creationAt, updatedAt: String?
    let category: Category?
}
