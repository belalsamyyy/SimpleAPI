//
//  ResultMessage.swift
//  SimpleAPI
//
//  Created by Belal Samy on 19/03/2022.
//

import Foundation

extension API {
    
    public enum ResultMessage {
        case noInternetConnection
        case wrongEndpoint(String)
        case noDataFromApi
        case decodingFailed
        case requestSucceedWithoutDecoding(HTTPMethod)
        case objectRequestSucceed(HTTPMethod)
        case listRequestSucceed(Int)
        
        var message: String {
            switch self {
            case .noInternetConnection:
                return "🔴 [\(M.self)] => request failed - you're offline, check your internet connection"
                
            case .wrongEndpoint(let endpoint):
                return "🔴 [\(M.self)] => request failed - check your endpoint is correct [\(endpoint)]"
                
            case .noDataFromApi:
                return "🟠 [\(M.self)] => request succeed - but didn't get any data from Api"
                
            case .decodingFailed:
                return "🟡 [\(M.self)] => request succeed - but decoding failed check \"\(M.self)\" properies data types are correct or maybe your object id is missing"
                
            case .requestSucceedWithoutDecoding(let method):
                return "🟢 [\(M.self)] => request succeed - \"\(method.name)\" without decoding, bec you set \"decoding\" to false"
                
            case .objectRequestSucceed(let method):
                return "🟢 [\(M.self)] => request succeed - \"\(method.name)\" 1 object of type \"\(M.self)\" \(method.id)"
                
            case .listRequestSucceed(let count):
                return "🟢 [\(M.self)] => request succeed - \"GET\" list of \(count) objects of type \"\(M.self)\""
            }
        }
    }
    
}
