//
//  ErrorResponse.swift
//  pkce
//
//  Created by Ricardo Bravo on 19/03/22.
//

import Foundation

struct ErrorResponse: Codable {
    let id: String
    let message: String
}

extension ErrorResponse: LocalizedError {
    var errorDescription: String? {
        return message
    }
}
