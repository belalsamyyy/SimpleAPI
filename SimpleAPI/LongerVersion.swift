//
//  LongerVersion.swift
//  SimpleAPI
//
//  Created by Belal Samy on 19/03/2022.
//

import Foundation

extension API {
    
    //MARK: - Longer Version
    
    // object
    public static func objectResult(_ method: HTTPMethod = .getWithoutID,
                                    encoding: Encoding = .json,
                                    decoding: Bool = true,
                                    _ result: @escaping (_ result: ResultOfObject ) -> ()) {
        
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
        
        APIService.request(endPoint, method: method, params: M.params, headers: M.headers, encoding: encoding) { response in
            switch response {
            case .success(let data):
                
                guard let data = data else {
                    DispatchQueue.main.async { result(.failure(ResultMessage.noDataFromApi.message)) } // Main Thread
                    return
                }
                
                if decoding {
                    // =============== You need to decode ====================
                    do {
                        let data = try JSONDecoder().decode(M.self, from: data)
                        DispatchQueue.main.async { result(.success(data)) } // Main Thread
                        print(ResultMessage.objectRequestSucceed(method).message)
                        
                    } catch {
                        DispatchQueue.main.async {
                            result(.failure("\(ResultMessage.decodingFailed.message)"))
                        } // Main Thread
                    }
                    
                } else {
                    // =============== Dont need to decode ====================
                    DispatchQueue.main.async { result(.success(nil)) } // Main Thread
                    print(ResultMessage.requestSucceedWithoutDecoding(method).message)

                }
   
                
            case .failure(_):
                // Main Thread
                DispatchQueue.main.async {
                    if Reachability.isConnected() {
                        result(.failure("\(ResultMessage.wrongEndpoint(endPoint).message) "))
                    } else {
                        result(.failure("\(ResultMessage.noInternetConnection.message) "))

                    }
                }
            }
        }
    }
    
    
    
    
    // list
    
    public static func listResult(_ result: @escaping (_ result: ResultOfList ) -> ()) {
        APIService.request(M.endpoint, method: .getWithoutID, params: M.params, headers: M.headers) { response in
            switch response {
            case .success(let data):
                
                guard let data = data else {
                    DispatchQueue.main.async { result(.failure(ResultMessage.noDataFromApi.message)) } // Main Thread
                    return
                }
    
                do {
                    let data = try JSONDecoder().decode([M].self, from: data)
                    DispatchQueue.main.async { result(.success(data)) } // Main Thread
                    print(ResultMessage.listRequestSucceed(data.count).message)

                } catch {
                    // Main Thread
                    DispatchQueue.main.async {
                        result(.failure(" \(ResultMessage.decodingFailed.message) "))
                    }
                }

            case .failure(_):
                // Main Thread
                DispatchQueue.main.async {
                    if Reachability.isConnected() {
                        result(.failure("\(ResultMessage.wrongEndpoint(M.endpoint).message) "))
                    } else {
                        result(.failure("\(ResultMessage.noInternetConnection.message) "))
                    }
                }
            }
        }
    }

}
