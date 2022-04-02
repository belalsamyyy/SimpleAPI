//
//  EndPoint.swift
//  SimpleAPI
//
//  Created by Belal Samy on 23/03/2022.
//

import Foundation

public enum EndPoint {
    case url(String)
    case customize(paramsArr: [String]?, queryDict: [String: String]?)
    
    var url: String? {
        switch self {
        case .url(let url):
            return "\(url)"
            
        case .customize(let paramsArr, let queryDict):
            var endpoint = ""
            
            if let paramsArr = paramsArr {
                for param in paramsArr {
                    endpoint += "/\(param)"
                }
            }
            
            if let queryDict = queryDict {
                for (key, value) in queryDict {
                    endpoint += "?\(key)=\(value)"
                }
            }
            
            return endpoint
        }
    }
}
