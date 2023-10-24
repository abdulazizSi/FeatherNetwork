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
- [Examples](#examples)

## Usage
Feather Network can be easily integrated into your Swift projects. Use the following steps to make a network request:
``` swift
// Create an instance of the Network
let network = Network.init()

// Define the endpoint with the desired response model 'UserModel'
let endpoint = UserEndpoint<UserModel>.get

// Initiate the network request with the specified endpoint
network.request(endpoint) { result in
    switch result {
    case .success(let response):
        // Handle the successful response here
        print("Received user name: \(response.name)")
    case .failure(let error):
        // Handle any errors that occur during the request
        print("Error occurred: \(error)")
    }
}
```

## Examples

### Example 1
Add the API path inside the 'ServerPath' file
```swift
enum ServerPath: String {
    //User API's -----
    case userGet = "example/userGet"
    case userDelete = "example/userDelete"
    case userUpdate = "example/userUpdate"
    //-----
    
    
}
```
### Example 2
Create a new endpoint and confirom to the 'URLRequestConvertible'
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

## Contributing
Feather Network welcomes contributions from the developer community. If you have any ideas, bug fixes, or improvements, feel free to open an issue or submit a pull request. Your contributions are highly appreciated and will help make Feather Network even better for everyone.

## License
Feather Network is available under the [MIT](https://github.com/abdulazizSi/FeatherNetwork/blob/main/LICENSE) License. You are free to use, modify, and distribute this SDK as per the terms of the license.

## Contact

Feel free to reach out with issues, questions or anything else.

- <p><a href="mailto:abdulaziz.si.aa@gmail.com">Send Email</a></p>
- [Follow on LinkedIn](https://linkedin.com/in/abdulaziz-alsikh-1225a2120)
