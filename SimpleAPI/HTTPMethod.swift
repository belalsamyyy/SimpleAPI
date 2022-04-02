//
//  HTTPMethod.swift
//  SimpleAPI
//
//  Created by Belal Samy on 23/03/2022.
//

import Foundation

public enum HTTPMethod {
    case get(_ path: String = "")
    case post(_ path: String = "")
    case put(_ path: String = "")
    case delete(_ path: String = "")
    
    var name: String {
        switch self {
        case .get:
            return "GET"
        case .post:
            return "POST"
        case .put:
            return "PUT"
        case .delete:
            return "DELETE"
        }
    }
    
    var id: String {
        switch self {
        case .get(let path):
            return path == "" ? "" : "with path \"\(path)\""
        case .post(let path):
            return path == "" ? "" : "with path \"\(path)\""
        case .put(let path):
            return path == "" ? "" : "with path \"\(path)\""
        case .delete(let path):
            return path == "" ? "" : "with path \"\(path)\""
        }
    }
    
}
