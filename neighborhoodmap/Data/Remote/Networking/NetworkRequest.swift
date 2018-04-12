//
//  NetworkRequest.swift
//  neighborhoodmap
//
//  Created by Phuc Tran on 4/11/18.
//  Copyright © 2018 Phuc Tran. All rights reserved.
//


import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case update = "UPDATE"
    case delete = "DELETE"
}

enum APIRequest {
    case search(latitude: Double, longitude: Double, currentRadius: Double)
    case photos(venueid: String)
    // MARK: URL Request
    
    var urlRequest: URLRequest? {
        var request: URLRequest?
        
        if let url = components.url {
            var urlRequest = URLRequest(url: url)
            
            // add method
            urlRequest.httpMethod = method.rawValue
            
            // add headers
            for (key, value) in headers { urlRequest.addValue(value, forHTTPHeaderField: key) }
            
            // add http body
            if let httpBody = httpBody { urlRequest.httpBody = httpBody }
            
            request = urlRequest
        }
        
        return request
    }
    
    // MARK: HTTP body
    
    var httpBody: Data? {
        switch self {
        default:
            return nil
        }
    }
    
    // MARK: HTTP Method
    
    var method: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
    
    // MARK: Headers
    
    var headers: [String: String] {
        return [:]
    }
    
    // MARK: Components
    
    var components: URLComponents {
        var components = URLComponents()
        components.scheme = NetworkConstants.Flickr.APIScheme
        components.host = NetworkConstants.Flickr.APIHost
        components.path = NetworkConstants.Flickr.APIPath + subpath
        components.queryItems = queryItems
        
        return components
    }
    
    // MARK: Subpath
    
    var subpath: String {
        switch self {
        case .search:
            return NetworkConstants.FourSquareMethods.Search
        case .photos(let venueid):
            return "/\(venueid)\(NetworkConstants.FourSquareMethods.Photos)"
        
        }
    }
    
    // MARK: Query Items
    
    var queryItems: [URLQueryItem] {
        var items = [URLQueryItem]()
        items.append(URLQueryItem(name: NetworkConstants.FourSquareParamKeys.ClientId, value: NetworkConstants.FourSquareParamValues.ClientId))
        items.append(URLQueryItem(name: NetworkConstants.FourSquareParamKeys.ClientSecret, value: NetworkConstants.FourSquareParamValues.ClientSecret))
        items.append(URLQueryItem(name: NetworkConstants.FourSquareParamKeys.Version, value: NetworkConstants.FourSquareParamValues.Version))
        switch self {
        case .search(let latitude, let longitude, let currentRadius):
            items.append(URLQueryItem(name: NetworkConstants.FourSquareParamKeys.CategoryId, value: NetworkConstants.FourSquareParamValues.CategoryId))
            items.append(URLQueryItem(name: NetworkConstants.FourSquareParamKeys.Limit, value: NetworkConstants.FourSquareParamValues.Limit))
            items.append(URLQueryItem(name: NetworkConstants.FourSquareParamKeys.latlng, value: "\(latitude),\(longitude)"))
            items.append(URLQueryItem(name: NetworkConstants.FourSquareParamKeys.radius, value: String(Int(round(currentRadius)))))
            break
            
        default:
            break
        }
        
        return items
    }
}


