//
//  NetworkService.swift
//  FeatherNetwork
//
//  Created by Abdulaziz Alsikh on 26.09.2023.
//

import Foundation

class Network {
            
    private let client: HTTPClient
    
    init(client: HTTPClient = URLSession.shared) {
        self.client = client
    }
    
    func request<e: URLRequestConvertible>(
        _ endpoint: e,
        completionHandler: @escaping CompletionHandler<e.ResultType>
    ) {
        do {
            let request = try endpoint.asURLRequest()
            client.perform(request: request) { result in
                switch result {
                case .success(let data):
                    do {
                        let decoder = JSONDecoder()
                        let NetworkResponseModel = try decoder.decode(e.ResultType.self, from: data)
                        completionHandler(.success(NetworkResponseModel))
                    } catch {
                        completionHandler(.failure(error))
                    }
                    
                case .failure(let error):
                    completionHandler(.failure(error))
                }
            }
        } catch {
            completionHandler(.failure(NetworkError.badRequest))
        }
       
    }
}


extension URLSession: HTTPClient {
    func perform(request: URLRequest, completion: @escaping ResultWithData) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            /// Check for any errors
            if let error {
                completion(.failure(.unexpectedError(error)))
                return
            }
            
            /// Try to cast the response as HTTPURLResponse
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.noResponse))
                return
            }
            
            if response.statusCode == 403 {
                completion(.failure(.unAuthorized))
                return
            }
            
            guard (200...299).contains(response.statusCode) else {
                completion(.failure(.requestFailed(statusCode: response.statusCode)))
                return
            }
            
            /// Check the response data is not nil
            guard let data else {
                completion(.failure(.noData))
                return
            }

            completion(.success(data))
            
        }.resume()
    }
}
