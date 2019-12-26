//
//  Utilities.swift
//  FlickrPhotoSearch
//
//  Created by Harshal Wani on 07/12/19.
//  Copyright © 2019 Harshal Wani. All rights reserved.
//

import Foundation

import SystemConfiguration

class Utilities: NSObject {
    
    /// Check internet connection
    static func isInternetAvailable() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) { zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
    }
    
    /// Retrive and save search items to UserDefaults
    /// - Parameter value: search text to save
    static func saveSearchItemToUserDefaults(key: String, value: String) {
        
        var history = [String]()
        if UserDefaults.exists(key: key) {
            history = (UserDefaults.retrive(key: key) as! [String]).filter {$0 != value}
        }
        history.insert(value, at: 0)
        UserDefaults.save(object: history as AnyObject, key: key)
    }

}
