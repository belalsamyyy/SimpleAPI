//
//  ResultMessage.swift
//  SimpleAPI
//
//  Created by Belal Samy on 19/03/2022.
//

import Foundation

extension API {
    
    public enum ResultMessage {
        case noInternetConnection(String)
        case wrongEndpoint(String)
        case noDataFromApi(String)
        case decodingFailed(String)
        case requestSucceedWithoutDecoding(HTTPMethod, String)
        case objectRequestSucceed(HTTPMethod, String)
        case listRequestSucceed(Int, String)
        
        var message: String {
            switch self {
            case .noInternetConnection(let endpoint):
                return "\n=> \(endpoint)\n" + "🔴 [\(M.self)] => request failed - you're offline, check your internet connection \n"
                
            case .wrongEndpoint(let endpoint):
                return "\n=> \(endpoint)\n" + "🔴 [\(M.self)] => request failed - check your endpoint is correct \n"
                
            case .noDataFromApi(let endpoint):
                return "\n=> \(endpoint)\n" + "🟠 [\(M.self)] => request succeed - but didn't get any data from Api \n"
                
            case .decodingFailed(let endpoint):
                return "\n=> \(endpoint)\n" + "🟡 [\(M.self)] => request succeed - but decoding failed, check \"\(M.self)\" properies data types are correct or check your endpoint is correct \"may be missing object id\" \n"
                
            case .requestSucceedWithoutDecoding(let method, let endpoint):
                return "\n=> \(endpoint)\n" + "🟢 [\(M.self)] => request succeed - \"\(method.name)\" without decoding, bec you set \"decoding\" to false \n"
                
            case .objectRequestSucceed(let method, let endpoint):
                return "\n=> \(endpoint)\n" + "🟢 [\(M.self)] => request succeed - \"\(method.name)\" 1 object of type \"\(M.self)\" \(method.id) \n"
                
            case .listRequestSucceed(let count, let endpoint):
                return "\n=> \(endpoint)\n" + "🟢 [\(M.self)] => request succeed - \"GET\" list of \(count) objects of type \"\(M.self)\" \n"
            }
        }
    }
    
}
