//
//  Model.swift
//  SimpleAPI
//
//  Created by Belal Samy on 18/03/2022.
//

import Foundation

//MARK: - Generic Model

public protocol Model: Codable {
    static var endpoint: String! { get set }
    static var params: Params? { get set }
    static var headers: Headers? { get set }
}

// 🔴 [Post] => request failed - you're offline, check your internet connection
// 🔴 [Post] => request failed - check your endpoint is correct [endpoint url]
// 🟠 [Post] => request succeed - but didn't get any data from Api
// 🟡 [Post] => decoding failed - check "Post" properies data types are correct
// 🟢 [Post] => request succeed - without decoding, bec you set "decode" to false"
// 🟢 [Post] => request succeed - "GET" 1 object of type "Post"
// 🟢 [Post] => request succeed - "GET" request return list of "20" objects of type "Post"
