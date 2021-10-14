//
//  NetworkError.swift
//  RobinGonzalesChallenge
//
//  Created by Robin Gonzales on 13/10/21.
//

import Foundation

enum NetworkError: Error {
    case url
    case other(Error)
    
    var localizedDescription: String {
        switch self {
        case .url:
            return "Bad url"
        case .other(let error):
            return error.localizedDescription
        }
    }
}
