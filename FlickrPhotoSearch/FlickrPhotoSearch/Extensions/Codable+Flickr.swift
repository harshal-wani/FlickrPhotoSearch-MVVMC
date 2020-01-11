//
//  Codable+Flickr.swift
//  FlickrPhotoSearch
//
//  Created by Harshal Wani on 29/12/19.
//  Copyright © 2019 Harshal Wani. All rights reserved.
//

import Foundation

extension Encodable {
    
    func asDictionary() -> [String:Any] {
        let mirror = Mirror(reflecting: self)
        let dict = Dictionary(uniqueKeysWithValues: mirror.children.lazy.map({ (label:String?,value:Any) -> (String,Any)? in
            guard label != nil else { return nil }
            return (label!,value)
        }).compactMap{ $0 })
        return dict
    }
}
