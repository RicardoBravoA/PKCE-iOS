//
//  MovieResponse.swift
//  pkce
//
//  Created by Ricardo Bravo on 19/03/22.
//

import Foundation

struct MovieResponse: Codable {
    let results: [MovieResponseItem]
}

struct MovieResponseItem: Codable {
    let id: Int
    let title: String
    let diector: String
}
