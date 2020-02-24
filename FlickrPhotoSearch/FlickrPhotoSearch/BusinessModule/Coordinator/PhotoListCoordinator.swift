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
    private var photoDetailCoordinator: PhotoDetailCoordinator?
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    func start() {
        let photoListViewController = PhotoListViewController.instantiate()
        photoListViewController.photoListVCDelegate = self
        self.photoListViewController = photoListViewController
        presenter.pushViewController(photoListViewController, animated: true)
    }
}

extension PhotoListCoordinator: PhotoListVCDelegate {
    
    func photoListVC(_ controller: PhotoListViewController, didSelect photoURL: String) {
        let photoDetailCoordinator = PhotoDetailCoordinator(presenter: presenter, photoURL: photoURL)
        self.photoDetailCoordinator = photoDetailCoordinator
        photoDetailCoordinator.start()
    }
    
}

