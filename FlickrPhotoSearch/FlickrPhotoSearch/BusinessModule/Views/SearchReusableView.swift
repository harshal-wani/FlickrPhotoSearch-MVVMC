//
//  SearchReusableView.swift
//  FlickrPhotoSearch
//
//  Created by Harshal Wani on 24/12/19.
//  Copyright © 2019 Harshal Wani. All rights reserved.
//

import UIKit

protocol SearchTextDelegate: class {
    func enteredText(str: String)
}

class SearchReusableView: UICollectionReusableView {

    @IBOutlet weak var searchTextField: UITextField!
    public static let reusableId: String = "SearchReusableView"
    
    weak var delegate:SearchTextDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        searchTextField.delegate = self
    }
    
}

extension SearchReusableView :UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let text = textField.text {
            delegate?.enteredText(str: text)
        }
        return true
    }
}
