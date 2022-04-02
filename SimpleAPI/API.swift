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
        case success(object: M?)
        case failure(error: String)
    }
    
    public enum ResultOfList {
        case success(list: [M?])
        case failure(error: String)
    }
}
