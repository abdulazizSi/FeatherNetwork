//
//  URLRequestConvertible.swift
//  FeatherNetwork
//
//  Created by Abdulaziz Alsikh on 26.09.2023.
//

import Foundation

protocol URLRequestConvertible: DecodableResult {
    /// The endpoint base `URL`.
    var baseURL: URL? { get }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: ServerPath { get }
    
    /// The HTTP method used in the request.
    var method: HTTPMethod { get }
    
    /// The headers to be used in the request.
    var headers: Headers? { get }
    
    /// The default parameters
    var defaultParameters: Parameters { get }
    
    /// The type of HTTP task to be performed.
    var task: RequestTask { get }
    
    /**
       Converts the URLRequestConvertible conforming instance into a URLRequest.

       This method is responsible for assembling all the components of an HTTP request, such as the base URL, path, HTTP method, headers, parameters, and task, into a fully constructed URLRequest.

       - Returns: A fully constructed URLRequest representing the HTTP request to be made.
       - Throws: An error if there are any issues in creating the URLRequest.
     */
    func asURLRequest() throws -> URLRequest
}

extension URLRequestConvertible {
    var baseURL: URL? {
        return URL(string: "https://example/api.com")
    }
                   
    var defaultParameters: Parameters {
        let parameters = Parameters()
        return parameters
    }
    
    var defaultHeader: Headers {
        var header = Headers()
        header["Content-Type"] = "application/json"
        header["accept"] = "application/json"
        return header
    }
}

extension URLRequestConvertible {
    func asURLRequest() throws -> URLRequest {
        guard let url = baseURL else {
            throw NetworkError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path.rawValue),
                                    cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                    timeoutInterval: 100)
        
        urlRequest.httpMethod = method.rawValue
        
        headers?.forEach { urlRequest.addValue($1, forHTTPHeaderField: $0) }
        
        
        urlRequest = try configure(request: urlRequest, task: task)
        
        return urlRequest
        
    }
    
    private func configure(request: URLRequest, task: RequestTask) throws -> URLRequest {
        var request = request
        
        switch task {
        case .requestPlain:
            return request
            
        case let .dataTask(parameters, encoding):
            request = try encoding.encode(request, with: parameters)
            
        case let .uploadTask(parameters, media):
            let multipartGenerator = MultipartGenerator()
            request = try multipartGenerator.encode(request, with: media, parameters: parameters)
        }
        
        return request
    }
}

