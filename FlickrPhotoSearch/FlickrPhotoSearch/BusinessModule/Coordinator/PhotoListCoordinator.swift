//
//  PhotoListCoordinator.swift
//  FlickrPhotoSearch
//
//  Created by Harshal Wani on 26/12/19.
//  Copyright © 2019 Harshal Wani. All rights reserved.
//

import UIKit

final class PhotoListCoordinator: Coordinator {
    
    private var presenter: UINavigationController
    private var photoListViewController: PhotoListViewController?
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    func start() {
        let photoListViewController = PhotoListViewController.instantiate()
        self.photoListViewController = photoListViewController
        presenter.pushViewController(photoListViewController, animated: true)
    }
    
}

