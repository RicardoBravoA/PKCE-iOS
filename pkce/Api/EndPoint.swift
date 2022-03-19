//
//  EndPoint.swift
//  pkce
//
//  Created by Ricardo Bravo on 19/03/22.
//

import Foundation

enum EndPoint {
    static let urlBase = "http://192.168.31.55:3000/api/"
    
    case movie
    case transaction
    
    var value: String {
        switch self {
            case .movie:
                return EndPoint.urlBase + "movie"
            case .transaction:
                return EndPoint.urlBase + "transaction"
        }
    }
    
    var url: URL {
        return URL(string: value)
    }
}
