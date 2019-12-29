//
//  UICollectionViewCell+Flickr.swift
//  FlickrPhotoSearch
//
//  Created by Harshal Wani on 14/12/19.
//  Copyright © 2019 Harshal Wani. All rights reserved.
//

import UIKit

extension UICollectionViewCell {

    static func register(for collectionView: UICollectionView)  {
        let cellName = String(describing: self)
        let identifier = cellName
        let cellNib = UINib(nibName: String(describing: self), bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: identifier)
    }
}
