# SimpleAPI
Simple HTTP Networking in Swift based on UrlSession ⚡

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

```swift 
    import 'SimpleAPI'
```

## Installation

SimpleAPI is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SimpleAPI'
```

## Usage 

### Step 1 - create `Constants.swift` file for your API Urls 

```swift 
import Foundation

let BASE_URL = "https://jsonplaceholder.typicode.com"

struct Endpoints {
    static let posts = "\(BASE_URL)/posts"
}
```

### step 2 - make your model conform `Model` protocol 

 Model protocol will add 3 static properties to your struct 
 - [X] endpoint 
 - [X] params 
 - [X] headers

`💡 Tip: add setParams() function so you don't have to specify params keys inside your viewController`
 
```swift 
import Foundation

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
```

### step 3 - create your API function in ViewController 

 - [X] just type `API` and specify the type of your `<object>` that you want to return  
 - [X] you have 2 function `object` to return one object `list` to return list of objects  
 - [X] `object` function takes 2 parameters the first one is `http method` enum like `.get(id)`, `.post`, `.put(id)`, `.delete(id)`
 - [X] the second parameter is `decode` boolean its `true` by default
 - [X] but if you didn't need to decode the response to consider it as a success make it `false`

```swift 
//MARK: - get list of posts
    func getPosts() {
        API<Post>.list { result in
            switch result {
            case .success(let posts):
                posts.forEach { post in
                    print(post!.title)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    //MARK: - get post with id
    func getPost(id: Int) {
        API<Post>.object(.get(id)) { result in
            switch result {
            case .success(let post):
                print(post!.title)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    //MARK: - set post
    func setPost(title: String, body: String) {
        Post.setParams(title: title, body: body)

        API<Post>.object(.post) { result in
            switch result {
            case .success(let post):
                print(post!.title)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    //MARK: - update post with id
    func updatePost(id: Int, title: String, body: String) {
        Post.setParams(title: title, body: body)
        
        API<Post>.object(.put(id)) { result in
            switch result {
            case .success(let post):
                print(post!.body)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    //MARK: - delete post with id
    func deletePost(id: Int) {        
        API<Post>.object(.delete(id), decode: false) { result in
            switch result {
            case .success(_):
                print("Deleted Successfully !")
            case .failure(let error):
                print(error)
            }
        }
    }
```


## Author

BelalSamy, belalsamy10@gmail.com

## License

SimpleAPI is available under the MIT license. See the LICENSE file for more info.


