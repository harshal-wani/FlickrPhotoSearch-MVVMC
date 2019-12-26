//
//  UserDefaultable.swift
//  FlickrPhotoSearch
//
//  Created by Harshal Wani on 25/12/19.
//  Copyright © 2019 Harshal Wani. All rights reserved.
//

import Foundation


extension UserDefaults {
    // Check key exists
    static func exists(key: String) -> Bool {
        return self.standard.object(forKey: key) != nil
    }
    //Save
    static func save(object: AnyObject?, key: String) {
        if (object != nil) {
            self.standard.set(object, forKey: key)
        }
        self.standard.synchronize()
    }
    //Get
    static func retrive(key : String) -> AnyObject? {
        if let name = self.standard.value(forKey: key) {
            return name as AnyObject
        }
        return nil
    }
}
