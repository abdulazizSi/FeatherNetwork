//
//  HTTPClient.swift
//  FeatherNetwork
//
//  Created by Abdulaziz Alsikh on 26.09.2023.
//

import Foundation

/// This protocol defines the interface for an HTTP client that can send HTTP requests
protocol HTTPClient {
    func perform(request: URLRequest, completion: @escaping ResultWithData)
}

