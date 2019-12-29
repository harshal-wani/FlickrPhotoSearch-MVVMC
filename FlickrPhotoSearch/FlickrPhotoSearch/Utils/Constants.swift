//
//  Constants.swift
//  FlickrPhotoSearch
//
//  Created by Harshal Wani on 07/12/19.
//  Copyright © 2019 Harshal Wani. All rights reserved.
//

import Foundation

/// API Constants
struct APP_URL {
    static let scheme = "https"
    static let host = "api.flickr.com"
}

/// HTTPMethod type
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

/// Error
enum APIError: String, Error {
    case invalidURL             = "Invalid url"
    case invalidResponse        = "Invalid response"
    case decodeError            = "Decode error"
    case missingParameters      = "Missing required parameters!"
    case noNetwork              = "Internet connection not available!"
    case noData                 = "Oops! There are no matches for entered text."
    case unknownError           = "Unknown error"
    case serverError            = "Server error"
    
    static func checkErrorCode(_ errorCode: Int = 0) -> APIError {
        switch errorCode {
        case 400:
            return .invalidURL
        case 500:
            return .serverError
        case 404:
            return .missingParameters
        default:
            return .unknownError
        }
    }
}


/// App Constants
struct AppConstants {
    
    /// SDK keys
    struct Keys {
        static let flickrAPIKey = "acdeef10bb0e01ffe6cae8f0a82fca54"
        
    }
    
    /// URL Query Parameters
    struct APIParams {
        static let perPageLimit = "20"
        static let servertId = "serverId"
        static let farm = "farm"
        static let format = "json"
        static let nojsoncallback = "1"
    }
    
    enum size: String {
        case url_sq = "s"   //small square 75x75
        case url_q = "q"    //large square 150x150
        case url_t = "t"    //thumbnail, 100 on longest side
        case url_s = "m"    //small, 240 on longest side
        case url_n = "n"    //small, 320 on longest side
        case url_m = "-"    //medium, 500 on longest side
        case url_z = "z"    //medium 640, 640 on longest side
        case url_c = "c"    //medium 800, 800 on longest side†
        case url_l = "b"    //large, 1024 on longest side*
        case url_h = "h"    //large 1600, 1600 on longest side†
        case url_k = "k"    //large 2048, 2048 on longest side†
        case url_o = "o"    //original image, either a jpg, gif or png, depending on source format
    }
    /// User Defaults
    struct Defaults {
        static let searchHistory = "searchHistory"
    }
}

struct LocalizableStrings {
    
    /// Screen title
    static let photoListTitle = "Flickr Photo"
    
    /// Common
    static let alert = "Alert"
    static let error = "Error"
    static let ok = "Ok"
    static let cancel = "Cancel"
    
}

