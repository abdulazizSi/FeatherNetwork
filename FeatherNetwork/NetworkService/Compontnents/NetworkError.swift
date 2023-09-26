//
//  NetworkError.swift
//  FeatherNetwork
//
//  Created by Abdulaziz Alsikh on 26.09.2023.
//

import Foundation

/// This enum represents various network-related errors that can occur during HTTP requests.
enum NetworkError: Error {
    
    /// Indicates that no data was received in the response.
    case noData
    
    /// Indicates that no response was received from the server.
    case noResponse
    
    /// Indicates that the HTTP response status code is out of the expected range.
    case responseStatusOutOfRange
    
    /// Indicates that the request is unauthorized, typically due to missing or invalid authentication credentials.
    case unAuthorized
    
    /// Indicates an unexpected error occurred, possibly wrapping another error for more specific information.
    case unexpectedError(Error)
    
    /// Indicates that the HTTP request failed with a specific status code.
    case requestFailed(statusCode: Int)
    
    /// Indicates that the URL used in the request is invalid.
    case invalidURL
    
    /// Indicates that the HTTP request was malformed and considered a bad request.
    case badRequest
    
    case missingURL
    
    case jsonEncodingFailed
}
