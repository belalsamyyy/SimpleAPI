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
    static var endpoint: Endpoint! = BASE_URL + "/posts"
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

// MARK: - Endpoints

extension Endpoint {
    func customize(path: String? = nil, queryItems: [String: String]?) -> String {
        var components = URLComponents(string: self)!

        // custom path "endpoint"
        if path != nil {
            components.path = path!
        }
        
        // queries
        if queryItems != nil {
            queryItems?.forEach { (key, value) in
                let query = URLQueryItem(name: key, value: value)
                components.queryItems?.append(query)
            }
            
        } else {
            components.query = nil
        }
    
        return "\(components.url!)"
    }
}

extension Post {
    static func customize(page: Int, searchText: String) {
        //Post.endpoint.customize(path: "", query: "")
        Post.endpoint = "\(BASE_URL)/posts?page=\(page)&searchText=\(searchText)"
    }
}


// property wrapper for endpoint string
// to define how i will customize it
// example
//@custom(page: Int, searchText: String)
//static var endpoint: EndPoint! = "\(BASE_URL)/posts"
// example how it work in view controller
// Post.endpoint.custom(page: Int, searchText: String)
// so it will override the origin value didnt change it

// second approach
// extensions "i prefer it "

// Post.endpoint.addParams([""]).addQuery([""])

//extension EndPoint {
//    func addParams(_ arr: [String]) -> String {
//        var paramString = ""
//        for item in arr {
//            paramString += "/\(item)"
//        }
//        return "self\(paramString)"
//    }
//}

//@propertyWrapper
//struct customize<Value> {
//    let key: String
//    let defaultValue: Value
//
//    var wrappedValue: Value {
//        get {
//            return Value += "123"
//        }
//        set {
//            container.set(newValue, forKey: key)
//        }
//    }
//}

@propertyWrapper
struct Capitalized {
  private(set) var text: String = "" //Declared to store the value
  var wrappedValue: String {
    get { return text }
    set { text = newValue.uppercased() }
  }
}
