//
//  EndPoint.swift
//  FlickrPhotoSearch
//
//  Created by Harshal Wani on 07/12/19.
//  Copyright © 2019 Harshal Wani. All rights reserved.
//

import Foundation

struct EndPoint {
    let path: String
    var queryItem: [URLQueryItem]? = nil
}
//services/rest/
extension EndPoint {

    static func searchPhoto(list: [String:String] = [:]) -> EndPoint {
        
        /// Default parameters
        var param = [
            URLQueryItem(name: "method", value: "flickr.photos.search"),
            URLQueryItem(name: "api_key", value: AppConstants.flickrAPIKey),
            URLQueryItem(name: "format", value: "json"),
            URLQueryItem(name: "nojsoncallback", value: "1"),
            URLQueryItem(name: "per_page", value: AppConstants.perPageLimit)
        ]
        /// Append text and page
        for (key,value) in list {
            param.append(URLQueryItem(name: key, value: value))
        }
        
        return EndPoint(path: "/services/rest", queryItem: param)
    }

}

extension EndPoint {
    var url: URL? {
        var components = URLComponents()
        components.scheme = APP_URL.scheme
        components.host = APP_URL.host
        components.path = path
        components.queryItems = queryItem
        return components.url
    }
}
