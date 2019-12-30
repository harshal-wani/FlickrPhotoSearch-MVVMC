//
//  EndPoint.swift
//  FlickrPhotoSearch
//
//  Created by Harshal Wani on 07/12/19.
//  Copyright © 2019 Harshal Wani. All rights reserved.
//

import Foundation

struct EndPoint {
    let method: HTTPMethod
    let path: String
    var queryItem: [String: Any]
}

extension EndPoint {

    static func searchPhoto(queryParams: [String:Any] = [:]) -> EndPoint {
        return EndPoint(method: .get, path: "/services/rest", queryItem: queryParams)
    }

}

extension EndPoint {
    var url: URL? {
        var components = URLComponents()
        components.scheme = APP_URL.scheme
        components.host = APP_URL.host
        components.path = path
        components.setQueryItems(with: queryItem)
        return components.url
    }
}

extension URLComponents {
    
    mutating func setQueryItems(with parameters: [String: Any]) {
        self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
    }
}

