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
    public static func objectResult(_ method: HTTPMethod = .get(),
                                    encoding: Encoding = .json,
                                    decoding: Bool = true,
                                    _ result: @escaping (_ object: ResultOfObject ) -> ()) {
        
        let endPoint: String
        
        switch method {
        case .get(let path):
            endPoint = "\(M.endpoint!)\(path.starts(with: "?") ? "" : "/")\(path)"
        case .post(let path):
            endPoint = "\(M.endpoint!)\(path.starts(with: "?") ? "" : "/")\(path)"
        case .put(let path):
            endPoint = "\(M.endpoint!)\(path.starts(with: "?") ? "" : "/")\(path)"
        case .delete(let path):
            endPoint = "\(M.endpoint!)\(path.starts(with: "?") ? "" : "/")\(path)"
        }
        
        APIService.request(endPoint, method: method, params: M.params, headers: M.headers, encoding: encoding) { response in
            switch response {
            case .success(let data):
                
                guard let data = data else {
                    DispatchQueue.main.async { result(.failure(ResultMessage.noDataFromApi(endPoint).message)) } // Main Thread
                    return
                }
                
                if decoding {
                    // =============== You need to decode ====================
                    do {
                        let data = try JSONDecoder().decode(M.self, from: data)
                        DispatchQueue.main.async { result(.success(data)) } // Main Thread
                        print(ResultMessage.objectRequestSucceed(method, endPoint).message)
                        dump(data)
                        
                    } catch {
                        DispatchQueue.main.async {
                            result(.failure("\(ResultMessage.decodingFailed(endPoint).message)"))
                        } // Main Thread
                    }
                    
                } else {
                    // =============== Dont need to decode ====================
                    let dataAsString = String(decoding: data, as: UTF8.self)
                    DispatchQueue.main.async { result(.string(dataAsString)) } // Main Thread
                    print(ResultMessage.requestSucceedWithoutDecoding(method, endPoint).message)

                }
   
                
            case .failure(_):
                // Main Thread
                DispatchQueue.main.async {
                    if Reachability.isConnected() {
                        result(.failure("\(ResultMessage.wrongEndpoint(endPoint).message) "))
                    } else {
                        result(.failure("\(ResultMessage.noInternetConnection(endPoint).message) "))

                    }
                }
            }
        }
    }
    
    
    
    // list
    
    public static func listResult(_ result: @escaping (_ list: ResultOfList ) -> ()) {
        APIService.request(M.endpoint, method: .get(), params: M.params, headers: M.headers) { response in
            switch response {
            case .success(let data):
                
                guard let data = data else {
                    DispatchQueue.main.async { result(.failure(ResultMessage.noDataFromApi(M.endpoint).message)) } // Main Thread
                    return
                }
    
                do {
                    let data = try JSONDecoder().decode([M].self, from: data)
                    DispatchQueue.main.async { result(.success(data)) } // Main Thread
                    print(ResultMessage.listRequestSucceed(data.count, M.endpoint).message)
                    dump(data)

                } catch {
                    // Main Thread
                    DispatchQueue.main.async {
                        result(.failure(" \(ResultMessage.decodingFailed(M.endpoint).message) "))
                    }
                }

            case .failure(_):
                // Main Thread
                DispatchQueue.main.async {
                    if Reachability.isConnected() {
                        result(.failure("\(ResultMessage.wrongEndpoint(M.endpoint).message) "))
                    } else {
                        result(.failure("\(ResultMessage.noInternetConnection(M.endpoint).message) "))
                    }
                }
            }
        }
    }

}
