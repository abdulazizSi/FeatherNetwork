//
//  MultipartGenerator.swift
//  FeatherNetwork
//
//  Created by Abdulaziz Alsikh on 26.09.2023.
//

import Foundation

/// This struct provides functionality for generating multipart/form-data for HTTP requests.
struct MultipartGenerator {

    /// This struct represents media data that can be included in the multipart request.
    struct Media {
        var key = String()
        var filename = String()
        var data = Data()
        var mimeType = String()
    }
    
    /// A constant for the line break character sequence used in the multipart body.
    private let lineBreak = "\r\n"
    
    /// Encodes the given URLRequest with media and parameters into a multipart request.
    func encode(_ urlRequest: URLRequest, with media: [Media]?, parameters: Parameters?) throws -> URLRequest {
        var urlRequest = urlRequest
        
        /// Generate a unique boundary string for the multipart data.
        let boundary = String().generateBoundary()

        /// Create the multipart data body.
        var bodyData = createDataBody(withParameters: parameters, media: media, boundary: boundary)

        /// Set the appropriate headers for the multipart request.
        urlRequest.allHTTPHeaderFields?["Content-Type"] = "multipart/form-data; boundary=\(boundary)"
        urlRequest.addValue("\(bodyData.count)", forHTTPHeaderField: "content-length")
        
        return urlRequest
    }
    
    /// Creates the multipart data body.
    func createDataBody(withParameters params: Parameters?, media: [Media]?, boundary: String) -> Data {
        
        var body = Data()
        
        if let parameters = params {
            body = appendParameters(body: body, boundary: boundary, parameters: parameters)
        }
        
        if let media = media {
            body = appendMedia(body: body, boundary: boundary, media: media)
        }
        
        /// Append the closing boundary.
        body.append("--\(boundary)--\(lineBreak)")
        
        return body
    }
    
    /// Appends parameters to the multipart body.
    private func appendParameters(body: Data, boundary: String, parameters: Parameters) -> Data {
        var body = body
        for (key, value) in parameters {
            var stringValue = String()
            if let str = value as? String { stringValue = str }
            else if let int = value as? Int { stringValue = "\(int)"}
            else {stringValue = "\(value)"}
            
            body.append("--\(boundary + lineBreak)")
            body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
            body.append("\(stringValue + lineBreak)")
        }
        
        return body
    }
    
    /// Appends media (files) to the multipart body.
    private func appendMedia(body: Data, boundary: String, media: [Media]) -> Data {
        var body = body
        for item in media {
            body.append("--\(boundary + lineBreak)")
            body.append("Content-Disposition: form-data; name=\"\(item.key)\"; filename=\"\(item.filename)\"\(lineBreak)")
            body.append("Content-Type: \(item.mimeType + lineBreak + lineBreak)")
            body.append(item.data)
            body.append(lineBreak)
        }
        
        return body
    }
    
}

/// Extension to generate a unique boundary string.
extension String {
    func generateBoundary() -> String {
        return "multipartform.boundary-\(NSUUID().uuidString)"
    }
}

/// Extension to append string data to a mutable Data instance.
extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
