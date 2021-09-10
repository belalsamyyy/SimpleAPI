//
//  File.swift
//  EasyAPI
//
//  Created by Belal Samy on 10/09/2021.
//

import Foundation

public enum HTTPMethod {
    case get(_ id: Int)
    case post
    case put(_ id: Int)
    case delete(_ id: Int)
    
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

class APIService {
    
    public enum Response {
        case success(Data?)
        case failure(Error?)
    }

    public static func request(_ endpoint: String,
                               method: HTTPMethod,
                               params: Params? = nil,
                               headers: Headers? = nil,
                               complete: @escaping (_ response: Response) -> ()) {
            
            //MARK: - session
        
            let session = URLSession.shared

            //MARK: - url
        
            guard let url = URL(string: endpoint) else { return }
            var request = URLRequest(url: url)
            
            //MARK: - method
        
            request.httpMethod = method.name
            
            //MARK: - headers
        
            if let headers = headers {
                for (key, value) in headers {
                    request.setValue("\(value)", forHTTPHeaderField: "\(key)")
                }
            }
        
            //MARK: - parameters
            if let params = params {
                guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else {
                    return
                }
                request.httpBody = httpBody
            }
        
            //MARK: - url session task
        
            session.dataTask(with: request) { data, response, error in
                
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
