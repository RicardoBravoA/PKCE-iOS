//
//  TransactionRequest.swift
//  pkce
//
//  Created by Ricardo Bravo on 19/03/22.
//

import Foundation

struct TransactionRequest: Codable {
    let clientId: String
    let amount: String
}
