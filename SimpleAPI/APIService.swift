//
//  APIService.swift
//  SimpleAPI
//
//  Created by Belal Samy on 10/09/2021.
//

import Foundation

public enum HTTPMethod {
    case getWithoutID
    case get(_ id: String)
    case post
    case put(_ id: String)
    case delete(_ id: String)
    
    var name: String {
        switch self {
        case .getWithoutID:
            return "GET"
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
        case .getWithoutID:
            return ""
        case .get(let id):
            return "with id \"\(id)\""
        case .post:
            return ""
        case .put(let id):
            return "with id \"\(id)\""
        case .delete(let id):
            return "with id \"\(id)\""
        }
    }
    
}

public enum Encoding {
    case json
    case url
}

public typealias Params = [String: Any]
public typealias Headers = [String: String]


public class APIService {
    
    public enum Response {
        case success(Data?)
        case failure(Error?)
    }

    public static func request(_ endpoint: String,
                               method: HTTPMethod,
                               params: Params? = nil,
                               headers: Headers? = nil,
                               encoding: Encoding = .json,
                               complete: @escaping (_ response: Response) -> ()) {

            // request from endpoint
            guard let allowArabicAndSpacesInEndPoint = endpoint.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
            guard let url = URL(string: allowArabicAndSpacesInEndPoint) else { return }
            var request = URLRequest(url: url)
            
            // method
            request.httpMethod = method.name
        
            // parameters
            if let params = params {
                guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else {
                    return
                }
                
                switch encoding {
                case .json:
                    request.httpBody = httpBody
                    
                case .url:
                    request.httpBody = urlEncoded(dict: params).data(using: .utf8)
                }
                
            }
            
            // headers
            if let headers = headers {
                for (key, value) in headers {
                    request.setValue("\(value)", forHTTPHeaderField: "\(key)")
                }
            }
        
        
            // url session task
            URLSession.shared.dataTask(with: request) { data, response, error in
                
                guard let myResponse = response else { return }
                let statusCode = (myResponse as! HTTPURLResponse).statusCode
                                
                if 200 ... 299 ~= statusCode {
                    complete(.success(data))
                    
                }else{
                    complete(.failure(error))
                }
            }.resume()
            
        }
}


func urlEncoded(dict: [String: Any]) -> String {
    var resultString = ""
    for (key, value) in dict {
        resultString = "\(resultString)&\(key)=\(value)"
    }
    resultString.removeFirst()
    return resultString
}
