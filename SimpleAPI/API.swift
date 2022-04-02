//
//  API.swift
//  SimpleAPI
//
//  Created by Belal Samy on 10/09/2021.
//

import Foundation
import Network

public class API<M: Model> {
    
    public enum ResultOfObject {
        case success(M?)
        case string(String?)
        case failure(String)
    }
    
    public enum ResultOfList {
        case success([M?])
        case failure(String)
    }
}
