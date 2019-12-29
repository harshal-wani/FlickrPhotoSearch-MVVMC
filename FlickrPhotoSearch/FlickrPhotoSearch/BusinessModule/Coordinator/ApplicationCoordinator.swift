//
//  ApplicationCoordinator.swift
//  FlickrPhotoSearch
//
//  Created by Harshal Wani on 26/12/19.
//  Copyright © 2019 Harshal Wani. All rights reserved.
//

import UIKit

final class ApplicationCoordinator: Coordinator {
    
    private let window: UIWindow
    private let rootViewController: UINavigationController
    private var photoListCoordinator: PhotoListCoordinator?
    
    init(window: UIWindow) {
        self.window = window
        rootViewController = UINavigationController()
        rootViewController.navigationBar.prefersLargeTitles = true
        photoListCoordinator = PhotoListCoordinator(presenter: rootViewController)
    }
    
    func start() {
        window.rootViewController = rootViewController
        photoListCoordinator?.start()
        window.makeKeyAndVisible()
    }
    
}
