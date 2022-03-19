//
//  MovieResponse.swift
//  pkce
//
//  Created by Ricardo Bravo on 19/03/22.
//

import Foundation

typealias MovieResponse = [MovieResponseItem]

struct MovieResponseItem: Codable {
    let id: Int
    let title: String
    let director: String
    let year: Int
    let rating: Double
}
