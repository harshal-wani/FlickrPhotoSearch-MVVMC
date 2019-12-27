//
//  FlickrPhotoCell.swift
//  FlickrPhotoSearch
//
//  Created by Harshal Wani on 07/12/19.
//  Copyright © 2019 Harshal Wani. All rights reserved.
//

import UIKit
import SDWebImage

final class FlickrPhotoCell: UICollectionViewCell {
    public static let reusableId: String = "FlickrPhotoCell"

    @IBOutlet weak var imageView: UIImageView!
    
    var dataCellViewModel : DataCellViewModel? {
        didSet {
            if let url = dataCellViewModel?.photoURL {
                imageView.sd_imageTransition = SDWebImageTransition.fade
                imageView.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "img_placeholder"))
            }
        }
    }
}
