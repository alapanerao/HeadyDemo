//
//  CategoryModel.swift
//  HeadyDemo
//
//  Created by Alap Anerao on 23/05/20.
//  Copyright © 2020 Alap Anerao. All rights reserved.
//

import Foundation

struct Category {
    let id: Int
    let name: String
    let products: [Product]
    let child_categories: [Int]
}

extension Category: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case products
        case child_categories
    }
}

struct Product {
    let id: Int
    let name: String
    let date_added: String
    let variants: [Variant]
    let tax: Tax
}

extension Product: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case date_added
        case variants
        case tax
    }
}

struct Variant {
    let id: Int
    let color: String
    let size: Int?
    let price: Int32?
}

extension Variant: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case color
        case size
        case price
    }
}


struct Tax {
    let name: String
    let value: Double
}

extension Tax: Decodable {
    enum CodingKeys: String, CodingKey {
        case name
        case value
    }
}

struct RankingProduct {
    let id: Int
    let view_count: Int64?
    let order_count: Int64?
    let shares: Int64?
}

extension RankingProduct: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case view_count
        case order_count
        case shares
    }
}


struct Ranking {
    let ranking: String
    let products: [RankingProduct]
}

extension Ranking: Decodable {
    enum CodingKeys: String, CodingKey {
        case ranking
        case products
    }
}

struct Wrapper<T: Decodable, R: Decodable>: Decodable {
    let categories: [T]
    let rankings: [R]
}
