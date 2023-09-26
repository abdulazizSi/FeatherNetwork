//
//  HTTPMethod.swift
//  FeatherNetwork
//
//  Created by Abdulaziz Alsikh on 26.09.2023.
//

import Foundation

/// This enum represents various HTTP request methods with their corresponding raw string values.
enum HTTPMethod: String {
    /// GET method.
    case get = "GET"
    
    /// POST method.
    case post = "POST"
    
    /// DELETE method.
    case delete = "DELETE"
    
    /// PATCH method.
    case patch = "PATCH"
    
    /// HEAD method.
    case head = "HEAD"
}
