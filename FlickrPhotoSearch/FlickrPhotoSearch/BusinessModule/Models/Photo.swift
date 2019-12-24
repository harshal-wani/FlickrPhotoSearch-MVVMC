//
//  Photo.swift
//  FlickrPhotoSearch
//
//  Created by Harshal Wani on 07/12/19.
//  Copyright © 2019 Harshal Wani. All rights reserved.
//

import Foundation

struct Photo: Decodable {

    let id: String
    let title: String
    let farm: Int
    let server: String
    let secret: String

}
struct PhotosResponse: Decodable {
    let page: Int
    let pages: Int
    let photoList: [Photo]
    
    enum CodingKeys: String, CodingKey {
        case page = "page"
        case pages = "pages"
        case photoList = "photo"
        case photos = "photos"
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let response = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .photos)

        page = try response.decode(Int.self, forKey: .page)
        pages = try response.decode(Int.self, forKey: .pages)
        photoList = try response.decode([Photo].self, forKey: .photoList)

    }

}
