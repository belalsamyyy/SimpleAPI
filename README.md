# SimpleAPI
Simple HTTP Networking in Swift based on UrlSession ⚡

## Installation

SimpleAPI is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SimpleAPI'
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

```swift 
    import 'SimpleAPI'
```

## Usage 

### Step 1 - create `Constants.swift` file for your API Urls 

```swift 
import Foundation
import SimpleAPI

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
 - [X] you have 2 function : `object` to return one object, `list` to return list of objects  
 - [X] `object` function takes 2 parameters the first one is `http method` enum like `.get(id)`, `.post`
 - [X] the second parameter is `decode` boolean its `true` by default
 - [X] but if you didn't need to decode the response to consider it as a success make it `false`

💡 Tip: `.get(id)` it will add `/id` at the end of your end point automatically


### GET - list of objects

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
```

### GET - object with id

```swift 
    //MARK: - get post with id
    func getPost(id: String) {
        API<Post>.object(.get(id)) { result in
            switch result {
            case .success(let post):
                print(post!.title)
            case .failure(let error):
                print(error)
            }
        }
    }
```

### POST - object with id

```swift 
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
```
    
   
### PUT - object with id

```swift 
    //MARK: - update post with id
    func updatePost(id: String, title: String, body: String) {
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
```
    
### DELETE - object with id

```swift 
    //MARK: - delete post with id
    func deletePost(id: String) {        
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

### step 4 - call your API function in `viewDidLoad()` 
```swift 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getPosts()
    }
```


## Author

BelalSamy, belalsamy10@gmail.com

## License

SimpleAPI is available under the MIT license. See the LICENSE file for more info.


