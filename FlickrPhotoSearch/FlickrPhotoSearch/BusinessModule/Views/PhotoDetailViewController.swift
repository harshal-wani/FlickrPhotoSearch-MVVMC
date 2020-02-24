//
//  PhotoDetailViewController.swift
//  FlickrPhotoSearch
//
//  Created by Harshal Wani on 24/02/20.
//  Copyright © 2020 Harshal Wani. All rights reserved.
//

import UIKit
import SDWebImage

final class PhotoDetailViewController: UIViewController, Storyboarded {
    
    /// Outlet
    @IBOutlet private weak var photoImage: UIImageView!
    
    /// Local
    var photoURL: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showPhotoImage()
    }
    
    //MARK: - Private
    private func showPhotoImage() {
        if let url = photoURL {
            photoImage.sd_imageTransition = SDWebImageTransition.fade
            photoImage.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "img_placeholder"))
        }
    }
}
