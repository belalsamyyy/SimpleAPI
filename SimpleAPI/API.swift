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
    
    
    //MARK: - Main Methods
    
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
                    DispatchQueue.main.async { result(.failure("didin't get any data from API")) } // Main Thread
                    return
                }
                
                if decode {
                    // =============== You need to decode ====================
                    do {
                        let data = try JSONDecoder().decode(M.self, from: data)
                        DispatchQueue.main.async { result(.success(data)) } // Main Thread

                    } catch {
                        DispatchQueue.main.async {
                            result(.failure("Error trying to decode response : \(error.localizedDescription)"))
                        } // Main Thread
                    }
                    
                } else {
                    // =============== Dont need to decode ====================
                    DispatchQueue.main.async { result(.success(nil)) } // Main Thread

                }
   
                
            case .failure(let error):
                // Main Thread
                DispatchQueue.main.async {
                    result(.failure("Error while fetching data : \(error?.localizedDescription ?? "error")"))
                }
            }
        }
    }
    
    
    // list
    
    public static func list(_ result: @escaping (_ result: ListResult ) -> ()) {
        APIService.request(M.endpoint, method: .getWithoutID, params: M.params, headers: M.headers) { response in
            switch response {
            case .success(let data):
                
                guard let data = data else {
                    DispatchQueue.main.async { result(.failure("didin't get any data from API")) } // Main Thread
                    return
                }
    
                do {
                    let data = try JSONDecoder().decode([M].self, from: data)
                    DispatchQueue.main.async { result(.success(data)) } // Main Thread

                } catch {
                    // Main Thread
                    DispatchQueue.main.async {
                        result(.failure("Error trying to decode response : \(error.localizedDescription)"))
                    }
                }

            case .failure(let error):
                // Main Thread
                DispatchQueue.main.async {
                    result(.failure("Error while fetching data : \(error?.localizedDescription ?? "error")"))
                }
            }
        }
    }
    
    //MARK: - Quicker Version
    
    // Quick object
    public static func quickObject(_ method: HTTPMethod, decode: Bool = true, _ result: @escaping (_ result: M? ) -> ()) {
        
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
                    DispatchQueue.main.async { print("didin't get any data from API") } // Main Thread
                    return
                }
                
                if decode {
                    // =============== You need to decode ====================
                    do {
                        let data = try JSONDecoder().decode(M.self, from: data)
                        DispatchQueue.main.async { result(data) } // Main Thread

                    } catch {
                        DispatchQueue.main.async {
                            print("Error trying to decode response : \(error.localizedDescription)")
                        } // Main Thread
                    }
                    
                } else {
                    // =============== Dont need to decode ====================
                    DispatchQueue.main.async { result(nil) } // Main Thread

                }
   
                
            case .failure(let error):
                // Main Thread
                DispatchQueue.main.async {
                    print("Error while fetching data : \(error?.localizedDescription ?? "error")")
                }
            }
        }
    }
    
    // list
    public static func quickList(_ result: @escaping (_ result: [M?] ) -> ()) {
        APIService.request(M.endpoint, method: .getWithoutID, params: M.params, headers: M.headers) { response in
            switch response {
            case .success(let data):
                
                guard let data = data else {
                    DispatchQueue.main.async { print("didin't get any data from API") } // Main Thread
                    return
                }
    
                do {
                    let data = try JSONDecoder().decode([M].self, from: data)
                    DispatchQueue.main.async { result(data) } // Main Thread

                } catch {
                    // Main Thread
                    DispatchQueue.main.async {
                        print("Error trying to decode response : \(error.localizedDescription)")
                    }
                }

            case .failure(let error):
                // Main Thread
                DispatchQueue.main.async {
                    print("Error while fetching data : \(error?.localizedDescription ?? "error")")
                }
            }
        }
    }
    
}
