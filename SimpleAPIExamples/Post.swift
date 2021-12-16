//
//  Post.swift
//  SimpleAPIExamples
//
//  Created by aly hassan on 16/12/2021.
//

import Foundation
import SimpleAPI

struct Post: Model {
    //API
    static var endpoint: String! = Endpoints.posts
    static var params: Params?
    static var headers: Headers? = ["Content-type": "application/json"]

    static func setParams(title: String, body: String) {
        self.params = ["title": title, "body": body]
    }
    
    //Properties
    var title: String
    var body: String
    
    private enum CodingKeys : String, CodingKey {
        case title = "title"
        case body = "body"
    }
    
}
