//
//  MovieResponse.swift
//  pkce
//
//  Created by Ricardo Bravo on 19/03/22.
//

import Foundation

struct MovieResponse: Codable {
    let id: Int
    let title: String
    let diector: String
    let year: Int
    let rating: Float
}
