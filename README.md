# SimpleAPI

### How to make Networking simple and easy 

What if we just create a model class / struct and get our data immediately 🤔

Something like create a model called `Movie` then go to your viewcontroller and say something like Movie.list() 
And immediately get a list of `Movie` objects you can work with .. very fast & efficient 

## 🚀 We need to move everything to the model 

After creating your model, all you‘ve to do is to conform `Model` protocol 
It will ask you to add 3 important information to communicate with your API 
- [X] endpoint 
- [X] params 
- [X] headers 

```swift 
import Foundation
import SimpleAPI

struct Post: Model {
    //API
    static var endpoint: String! = "https://jsonplaceholder.typicode.com"
    static var params: Params?
    static var headers: Headers? = ["Content-type": "application/json"]

    //Properties
    var title: String
    var body: String
}
```

After all, more 3 lines to your model  won’t hurt 


## 🥳 This is were the fun begins 

`API` is our main class, using the magic of swift generics .. it accesses your generic model informations and pass them to its functions 

`💡 Note => your model must conform Model protocol`

```swift 
API<YOUR-MODEL-HERE> 
```

API class has a 2 main static functions : 
- [X] object => return 1 object of your model type 
- [X] list => return a list of objects of your model type 

### Quicker Version 
- Return the value directly and if something goes wrong it will print a descriptive error message for you 

`list()` function
```swift
API<Post>.list() { posts in
    // do whatever you want with "posts" array ... 
}
```

`object()` function's parameters 
- [X] HTTPMethod [enum] - `.getWithoutID [default]`, `.get(id)`, `.put(id)`, `.delete(id)`, `.post`
- [X] encoding [enum] -  `.json [default]`, `.url`
- [X] decoding - [Bool] - `true [default]`, `false`

### Notes 
- `HTTMethod` => will add `\id` at the end of your endpoint automatically
- `encoding` => to change encoding, json encoded or url encoded 
- `decoding` => if your API response is succeed but empty, you need to set decoding to false
 
#### GET - object without id  
```swift
API<Post>.object(.getWithoutID) { post in
    self.label.text = post.title 
}
```

#### GET - object with id  
```swift
API<Post>.object(.get("1")) { post in
    self.label.text = post.title 
}
```

#### PUT - object with id  
```swift
API<Post>.object(.put("1")) { post in
    self.label.text = post.title 
}
```

#### DELETE - object with id  
```swift
API<Post>.object(.delete("1"), decoding: false) { post in
    self.label.text = post.title 
}
```

#### POST 
```swift
API<Token>.object(.post, encoding: .url) { token in
    print("\(token) posted successfully!")
}
```

#### Examples for Success & Error Messages
- 🔴 [Post] => request failed - you're offline, check your internet connection
- 🟠 [Post] => request succeed - but didn't get any data from Api
- 🟡 [Post] => request succeed - but decoding failed check "Post" properies data types are correct or maybe your object id is missing
- 🟢 [Post] => request succeed - "GET" 1 object of type "Post" with id "1"
- 🟢 [Post] => request succeed - "GET" list of 20 objects of type "Post"
- 🔴 [Post] => request failed - check your endpoint is correct [https://jsonplaceholder.typicode.com/posts/1]


### Longer Version 
-  Return result enum with a .success & .failure callbacks for more customizations

`listResult()` function 
```swift 
API<Post>.list { result in
    switch result {
    case .success(let posts):
        // do whatever you want with "posts" array ... 
        
    case .failure(let error):
        print(error)
    }
}
```

`objectResult()` function 
```swift 
API<Post>.object(get("1")) { result in
    switch result {
    case .success(let post):
        self.label = post.title
        
    case .failure(let error):
        print(error)
    }
}
```

## Installation

SimpleAPI is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SimpleAPI'
```

## Author

BelalSamy, belalsamy10@gmail.com

## License

SimpleAPI is available under the MIT license. See the LICENSE file for more info.


