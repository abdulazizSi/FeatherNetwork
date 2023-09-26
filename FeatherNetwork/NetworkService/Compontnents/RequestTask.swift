//
//  RequestTask.swift
//  FeatherNetwork
//
//  Created by Abdulaziz Alsikh on 26.09.2023.
//

import Foundation

/// Represents an HTTP task.
enum RequestTask {
    /// A request with no additional data.
    case requestPlain

    /// A requests body set with encoded parameters.
    case dataTask(parameters: Parameters, encoding: ParameterEncoding)
    
    /// A "multipart/form-data" upload task.
    case uploadTask(parameters: Parameters?, media: [MultipartGenerator.Media])
}

