//
//  Model.swift
//  RemeberTest
//
//  Created by steve on 2022/09/30.
//

import Foundation

struct Users: Codable {
    let total_count: Int
    let incomplete_results: Bool
    let items: [Item]

    struct Item: Codable {
        let login: String
        let id:    Int
    }

    struct Info: Codable {
        let login: String
        let id:    Int
        let name:  String
    }
}
