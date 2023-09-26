//
//  NetworkTypealias.swift
//  FeatherNetwork
//
//  Created by Abdulaziz Alsikh on 26.09.2023.
//

import Foundation

/// A typealias representing a completion handler that takes a Result object
/// with a generic type T, which should be Decodable.
typealias CompletionHandler<T: Decodable> = (_ result: Result<T, Error>) -> Void

/// A typealias representing a completion handler that takes a Result object
/// with a generic type of Data and a specific error type NetworkError.
typealias ResultWithData = (_ result: Result<Data, NetworkError>) -> Void


/// A typealias for a dictionary that maps String keys to Any values.
/// Typically used to represent parameters in network requests.
typealias Parameters = [String: Any]

/// A typealias for a dictionary that maps String keys to String values.
/// Typically used to represent HTTP headers in network requests.
typealias Headers = [String: String]
