//
//  DecodableResult.swift
//  FeatherNetwork
//
//  Created by Abdulaziz Alsikh on 26.09.2023.
//

import Foundation

/// The associated type ResultType represents the type into which the result can be decoded.
protocol DecodableResult {
    associatedtype ResultType: Decodable
}
