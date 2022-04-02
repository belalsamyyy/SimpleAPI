# SimpleAPI

Simple lightweight HTTP Networking Library written in Swift based on UrlSession

- [Requirements](#requirements)
- [Installation](#installation)
    - [Cocoapods](#cocoapods)
- [Usage](#usage)
    - [`Quick Start`](#quick-start)
    - [`object()` and `objectResult()`](#object-and-objectresult)
    - [`Examples`](#examples)
- [Extra Features](#extra-features)
- [Author](#author)
- [License](#license)

## Requirements
- Swift 5.0+
- iOS 13+

## Installation

### Cocoapods

SimpleAPI is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SimpleAPI', '~> 2.0.7'
```

## Usage

### Quick Start

#### 1. Create your model ( Must Conform to `Model`)

```swift 
import Foundation
import SimpleAPI

struct Post: Model {
    //API => Model protocol will add 3 static properties to communicate with API
    static var endpoint: String! = "https://jsonplaceholder.typicode.com/posts"
    static var params: Params?
    static var headers: Headers? = ["Content-type": "application/json"]

    //Properties
    var title: String
    var body: String
}
```

#### 2. Get your data immediately ⚡️⚡️⚡️
- Quicker Version => return value directly
    ```swift
    API<Post>.object { post in
        // do whatever you want with "post" object ... 
    }
    ```

    ```swift
    API<Post>.list { posts in
        // do whatever you want with "posts" array ... 
    }
    ```

- Longer Version => handle success & failure cases 
    ```swift 
    API<Post>.objectResult { result in
        switch result {
        case .success(let post):
        // do whatever you want with "post" object ... 

        case .failure(let error):
            print(error)
        }
    }
    ```
    
    ```swift 
    API<Post>.listResult { result in
        switch result {
        case .success(let posts):
            // do whatever you want with "posts" array ... 

        case .failure(let error):
            print(error)
        }
    }
    ```


#### Get a descriptive success/error messages

<img width="791" alt="Screen Shot 2022-04-02 at 11 44 47 AM" src="https://user-images.githubusercontent.com/38237387/161381722-22257fe7-492a-48f4-bfd6-379d97643fa3.png">

### object() and objectResult()

| Parameters        | Value           | Notes  |
| ------------- |:-------------:| -----:|
|HTTPMethod [enum] | `.get() [default]`, `.put()`, `.delete()`, `.post()` | you could pass an endpoint extension for specfic request through http methods |
|encoding [enum] | `.json [default]`, `.url` | to change body parameters encoding => json encoded or url encoded |
|decoding - [Bool] | `true [default]`, `false` | if your API response is empty or not return object from the same type , you need to set decoding to false |

#### Endpoint Extension

you could pass an endpoint extension ( custom paths/queries) for specfic request through http methods

```swift    
// Post.endpoint = "https://jsonplaceholder.typicode.com/posts" [original]

// .get("1") => https://jsonplaceholder.typicode.com/posts/1 🆕
// .get("?page=1&search=movie") => https://jsonplaceholder.typicode.com/posts?page=1&search=movie 🆕
```

### Examples 


#### GET - object
```swift
API<Post>.object { post in
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
    // ...
}
```

#### DELETE - object with id  
```swift
API<Post>.object(.delete("1"), decoding: false) { post in
    // ...
}
```

#### POST 
```swift
API<Token>.object(.post, encoding: .url) { token in
    print("posted successfully !")
}
```

## Extra Features
- SimpleAPI run on the main thread, so you could work with your UI directly 
- Endpoints support Arabic characters and spacing with percent-encoding by default

## Author

BelalSamy, belalsamy10@gmail.com

## License

SimpleAPI is available under the MIT license. See the LICENSE file for more info.

