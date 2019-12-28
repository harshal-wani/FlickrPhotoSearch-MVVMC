//
//  EndPoint.swift
//  FlickrPhotoSearch
//
//  Created by Harshal Wani on 07/12/19.
//  Copyright © 2019 Harshal Wani. All rights reserved.
//

import Foundation

/// Search photo params
protocol PhotoSearchable {
    var pageIndex: Int { get set }
    var searchText : String { get set }
}

struct EndPoint {
    let path: String
    var queryItem: [String: String]
}

extension EndPoint {

    static func searchPhoto(list: [String:String] = [:]) -> EndPoint {
        
        /// Default parameters
        var queryParams: [String: String] = [
            "method": "flickr.photos.search",
            "api_key": AppConstants.Keys.flickrAPIKey,
            "format": "json",
            "nojsoncallback": "1",
            "per_page": AppConstants.APIParams.perPageLimit
        ]
        /// Append text and page
        queryParams.merge(list) { (_, new) in new }
        
        return EndPoint(path: "/services/rest", queryItem: queryParams)
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
    
    mutating func setQueryItems(with parameters: [String: String]) {
        self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
}
