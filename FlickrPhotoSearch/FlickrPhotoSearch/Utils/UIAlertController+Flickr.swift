//
//  UIAlertController+Flickr.swift
//  FlickrPhotoSearch
//
//  Created by Harshal Wani on 07/12/19.
//  Copyright © 2019 Harshal Wani. All rights reserved.
//

import UIKit

private var window: UIWindow!

extension UIAlertController {

    class func showAlert(title: String,
                         message: String,
                         cancelButton: String?,
                         otherButtons: [String]? = nil,
                         tapHandler: ((String) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if let title = cancelButton {
            alert.addAction(UIAlertAction(title: title, style: .cancel, handler: { action in
                if let handler = tapHandler {
                    handler(title)
                }
            }))
        }
        
        for buttonTitle in otherButtons ?? [] {
            alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: { action in
                if let handler = tapHandler {
                    handler(buttonTitle)
                }
            }))
        }
        alert.present(animated: true, completion: nil)
    }
    
    func present(animated: Bool,
                 completion: (() -> Void)?) {
        window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = UIViewController()
        window.windowLevel = .alert + 1
        window.makeKeyAndVisible()
        window.rootViewController?.present(self, animated: animated,
                                           completion: completion)
    }
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        window = nil
    }
}
