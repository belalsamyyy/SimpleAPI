//
//  File.swift
//  EasyAPI
//
//  Created by Belal Samy on 10/09/2021.
//

import Foundation

public enum HTTPMethod {
    case get(_ id: String)
    case post
    case put(_ id: String)
    case delete(_ id: String)
    
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
                               complete: @escaping (_ response: Response) -> ()) {

            // request from endpoint
            guard let url = URL(string: endpoint) else { return }
            var request = URLRequest(url: url)
            
            // method
            request.httpMethod = method.name
        
            // parameters
            if let params = params {
                guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else {
                    return
                }
                request.httpBody = httpBody
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
