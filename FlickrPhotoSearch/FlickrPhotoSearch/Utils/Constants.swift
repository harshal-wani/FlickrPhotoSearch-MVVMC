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
    
    //SDK keys
    struct Keys {
        static let flickrAPIKey = "acdeef10bb0e01ffe6cae8f0a82fca54"
        
    }
    
    //URL Query Parameters
    struct APIParams {
        static let perPageLimit = "30"
        static let servertId = "serverId"
        static let farm = "farm"
    }

    //User Defaults
    struct Defaults {
        static let searchHistory = "searchHistory"
    }
}

struct LocalizableStrings {
    
    /// Screen title
    static let photoListTitle = "Chat"
    
    /// Common
    static let alert = "Alert"
    static let error = "Error"
    static let ok = "Ok"
    static let cancel = "Cancel"
    
}
