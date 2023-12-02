//
//  Category.swift
//  ProductsListing
//
//  Created by Pro on 27/10/2023.
//

import Foundation

struct Category: Codable, Hashable {
    let id: Int?
    let name: String?
    let image: String?
    let creationAt, updatedAt: String?
}
