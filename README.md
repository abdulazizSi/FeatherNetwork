# Feather Network
Feather Network is a lightweight networking SDK for Swift, providing a seamless and intuitive network layer that simplifies the process of making network requests. Built with clean, readable code and designed for ease of use, Feather Network offers a high-level abstraction over URLSession, including support for multipart/form-data for versatile data transmission.

## Features
- Lightweight and efficient network layer.
- Simple and clean interface for making network requests.
- Abstraction over URLSession for simplified networking operations.
- Easy integration and implementation into existing projects.
- Support for multipart/form-data for versatile data transmission.
- Swift-based SDK for robust and seamless networking capabilities.

## Table of Contents
- [Usage](#usage)
- [Example](#example)

## Usage

## Example
1- add the api path inside the ServerPath file
```swift
enum ServerPath: String {
    //User API's -----
    case userGet = "example/userGet"
    case userDelete = "example/userDelete"
    case userUpdate = "example/userUpdate"
    //-----
    
    
}
```
2- create a new endpoint and confirom to the URLRequestConvertible
``` swift

enum UserEndpoint<ResultType: Decodable>: URLRequestConvertible {
    case get
    case update(name: String)
    case delete
}

extension UserEndpoint {
    var path: ServerPath {
        switch self {
        case .get:
            return .userGet
        case .update:
            return .userUpdate
        case .delete:
            return .userDelete
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .get:
            return .get
        case .update:
            return .post
        case .delete:
            return .delete
        }
    }
    
    var headers: Headers? {
        defaultHeader
    }
    
    var task: RequestTask {
        
        switch self {
        case .get, .delete:
            return .requestPlain
            
        case .update(let name):
            var parameters = defaultParameters
            parameters["name"] = name
            return .dataTask(parameters: parameters, encoding: JSONEncoding.default)
        }

    }
}
```
3- Then you can crete your request as follow
``` swift
let network = Network.init()

let endpoint = UserEndpoint<UserModel>.get

network.request(endpoint) { result in
    switch result {
    case .success(let response):
        print(response.name)
    case .failure(let error):
        print(error)
    }
}
```
## Contributing
Feather Network welcomes contributions from the developer community. If you have any ideas, bug fixes, or improvements, feel free to open an issue or submit a pull request. Your contributions are highly appreciated and will help make Feather Network even better for everyone.

## License
Feather Network is available under the [MIT](https://github.com/abdulazizSi/FeatherNetwork/blob/main/LICENSE) License. You are free to use, modify, and distribute this SDK as per the terms of the license.
