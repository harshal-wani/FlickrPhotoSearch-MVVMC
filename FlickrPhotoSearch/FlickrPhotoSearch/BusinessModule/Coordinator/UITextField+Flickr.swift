//
//  UITextField+Flickr.swift
//  FlickrPhotoSearch
//
//  Created by Harshal Wani on 28/12/19.
//  Copyright © 2019 Harshal Wani. All rights reserved.
//

import UIKit

extension UITextField {
    
    func setIcon(_ image: UIImage?) {
        guard let ic = image else {return}
        let iconView = UIImageView(frame: CGRect(x: 10, y: 5, width: 20, height: 20))
        iconView.image = ic
        let iconContainerView: UIView = UIView(frame: CGRect(x: 20, y: 0, width: 30, height: 30))
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
    }
}
