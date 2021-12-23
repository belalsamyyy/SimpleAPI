# SimpleAPI
Simple HTTP Networking in Swift based on UrlSession, networking easier, quicker & simpler than ever ⚡

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
```

### step 3 - create your API function in ViewController 

 - [X] just type `API` and specify the type of your `<object>` that you want to return  
 - [X] you have 2 functions : `object` to return one object, `list` to return list of objects  
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

### GET - object without id

```swift 
    //MARK: - get post with id
    func getPost() {
        API<Post>.object(.getWithoutID) { result in
            switch result {
            case .success(let post):
                print(post!.title)
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

## Extra Tips 😎

💡 tip #1:  you can customize your `endpoint` from your function as you want, like this 

```swift 
   func getVideos(page: Int, genreID: String) {
        Video.endpoint = "\(BASE_URL)\(CategoryName.movies)/genre/\(genreID)/\(page)" // << endpoint
        API<Video>.list { [weak self] result in
          // .
          // . 
          // .
```


💡 tip #2: there're quicker versions of our 2 main funtions => `quickObject` & `quickList`
 - [X] `object` & `list` comes with success & failure callbacks
 - [X] but `quickObject` & `quickList` just return the value directly
 - [X] if quick functions fails it'll only print the error without customizations 

```swift
API<Post>.quickObject(.get("5")) { [weak self] post in 
    self?.label.text = post?.title
}
```

```swift
API<Post>.quickList() { posts in
    posts.forEach { post in
        print(post!.title)
    }
}
```


💡 tip #3: SimpleAPI set your parmaters to request's body
- [X] parameters encoded as `json` by default
- [X] but your can change it, to encoded as `urlencoded` like this 

```swift 
func login(email: String, password: String) {
    // API
    Token.setParams(email: email, password: password)

    // Token
    API<Token>.quickObject(.post, .urlencoded) { token in
        // write your logic here 
    }
}
```


## Author

BelalSamy, belalsamy10@gmail.com

## License

SimpleAPI is available under the MIT license. See the LICENSE file for more info.


