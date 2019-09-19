//
//  GoogleVision.swift
//  GoogleVision
//
//  Created by moon on 19/09/2019.
//  Copyright © 2019 Bugking. All rights reserved.
//

import UIKit
import SwiftyJSON

class GoogleVision {
    
    public struct Vision {
        public let fullTextAnnotation: String
    }
    
    /// API structure.
    private struct API {
        /// Base Google Vision API url.
        static let base = "https://vision.googleapis.com/v1/images:annotate"
        
        /// endpoint.
        struct vision {
            static let method = "POST"
            static let url = API.base
        }
    }
    
    enum VisionError: Error, LocalizedError {
        case invaildUrl
        case noImage
        
        public var errorDescription: String? {
            switch self {
            case .invaildUrl:
                return NSLocalizedString("invailded url", comment: "My error")
            case .noImage:
                return NSLocalizedString("No Image", comment: "Error")
            }
        }
    }
    
    /// API key.
    private var apiKey: String!
    /// Default URL session.
    private let session = URLSession(configuration: .default)
    
    init(apiKey:String) {
        assert(apiKey != "", "Please enter api key")
        self.apiKey = apiKey
    }
    
    public func run(image:UIImage?, _ completion: @escaping ((_ text: String?, _ error: Error?) -> Void)) {
        guard var urlComponents = URLComponents(string: API.vision.url) else {
            completion(nil, VisionError.invaildUrl)
            return
        }
        
        guard let base64image = image?.toBase64() else {
            completion(nil, VisionError.noImage)
            return
        }
        
        var queryItems = [URLQueryItem]()
        queryItems.append(URLQueryItem(name: "key", value: apiKey))
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            completion(nil, VisionError.invaildUrl)
            return
        }
        var request = URLRequest(url: url)
        let requestJson: [String: Any] = [
            "requests" : [
                "image" : [ "content":base64image ],
                "features" : [ "type" : "TEXT_DETECTION" ]
            ]
        ]
        
        let data = try! JSONSerialization.data(withJSONObject: requestJson, options: .prettyPrinted)
        request.httpBody = data
        request.httpMethod = API.vision.method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        session.dataTask(with: request) { (data, response, error) in
            guard let data = data,                                // is there data
                let response = response as? HTTPURLResponse,    // is there HTTP response
                (200 ..< 300) ~= response.statusCode,            // is statusCode 2XX
                error == nil else {                                // was there no error, otherwise ...
                    completion(nil, error)
                    return
            }
            
            let json = try! JSON(data: data)
            var result:String?
            let responses = json["responses"].arrayValue
            for res in responses {
                guard let fullTextAnnotation = res.dictionaryValue["fullTextAnnotation"]?.dictionaryValue else { continue }
                result = fullTextAnnotation["text"]?.stringValue
            }

            completion(result, nil)
        }.resume()
    }
    
}

fileprivate extension UIImage {
    func toBase64() -> String? {
        guard let imageData = self.pngData() else { return nil }
        return imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
    }
}
