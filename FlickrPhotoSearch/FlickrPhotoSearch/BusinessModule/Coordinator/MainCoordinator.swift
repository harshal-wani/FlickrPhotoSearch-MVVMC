//
//  MainCoordinator.swift
//  FlickrPhotoSearch
//
//  Created by Harshal Wani on 07/12/19.
//  Copyright © 2019 Harshal Wani. All rights reserved.
//

import UIKit

final class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    func start() {
        let vc = PhotoListViewController.instantiate()
        navigationController.pushViewController(vc, animated: false)
        vc.navigationController?.navigationBar.prefersLargeTitles = true
    }
}
