//
//  API.swift
//  EasyAPI
//
//  Created by Belal Samy on 10/09/2021.
//

import Foundation

//MARK: - Generic Model

public protocol Model: Codable {
    static var endpoint: String! { get set }
    static var params: Params? { get set }
    static var headers: Headers? { get set }
}

//MARK: - Generic Function

public class API<M: Model> {
    
    public enum ObjectResult {
        case success(M?)
        case failure(String)
    }
    
    public enum ListResult {
        case success([M?])
        case failure(String)
    }
    
    
    // object
    
    public static func object(_ method: HTTPMethod, decode: Bool = true, _ result: @escaping (_ result: ObjectResult ) -> ()) {
        
        let endPoint: String
        
        switch method {
        case .getWithoutID:
            endPoint = M.endpoint
        case .get(let id):
            endPoint = "\(M.endpoint!)/\(id)"
        case .post:
            endPoint = M.endpoint
        case .put(let id):
            endPoint = "\(M.endpoint!)/\(id)"
        case .delete(let id):
            endPoint = "\(M.endpoint!)/\(id)"
        }
        
        APIService.request(endPoint, method: method, params: M.params, headers: M.headers) { response in
            switch response {
            case .success(let data):
                
                guard let data = data else {
                    result(.failure("didin't get any data from API"))
                    return
                }
                
                if decode {
                    // =============== You need to decode ====================
                    do {
                        let data = try JSONDecoder().decode(M.self, from: data)
                        result(.success(data))

                    } catch {
                        result(.failure("Error trying to decode response : \(error.localizedDescription)"))
                    }
                    
                } else {
                    // =============== Dont need to decode ====================
                    result(.success(nil))
                }
   
                
            case .failure(let error):
                result(.failure("Error while fetching data : \(error?.localizedDescription ?? "error")"))
            }
        }
    }
    
    
    // list
    
    public static func list(_ result: @escaping (_ result: ListResult ) -> ()) {
        APIService.request(M.endpoint, method: .getWithoutID, params: M.params, headers: M.headers) { response in
            switch response {
            case .success(let data):
                
                guard let data = data else {
                    result(.failure("didin't get any data from API"))
                    return
                }
    
                do {
                    let data = try JSONDecoder().decode([M].self, from: data)
                    result(.success(data))

                } catch {
                    result(.failure("Error trying to decode response : \(error.localizedDescription)"))
                }

            case .failure(let error):
                result(.failure("Error while fetching data : \(error?.localizedDescription ?? "error")"))
            }
        }
    }
    
}
