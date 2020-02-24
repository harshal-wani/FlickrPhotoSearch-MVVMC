//
//  PhotoDetailCoordinator.swift
//  FlickrPhotoSearch
//
//  Created by Harshal Wani on 24/02/20.
//  Copyright © 2020 Harshal Wani. All rights reserved.
//

import UIKit

final class PhotoDetailCoordinator: Coordinator {
    
    private var presenter: UINavigationController
    private var photoDetailViewController: PhotoDetailViewController?
    private let photoURL: String
    
    init(presenter: UINavigationController, photoURL: String) {
        self.presenter = presenter
        self.photoURL = photoURL
    }
    
    func start() {
        
        let photoDetailVC = PhotoDetailViewController.instantiate()
        photoDetailVC.photoURL = photoURL
        self.photoDetailViewController = photoDetailVC
        presenter.pushViewController(photoDetailVC, animated: true)
    }
}
