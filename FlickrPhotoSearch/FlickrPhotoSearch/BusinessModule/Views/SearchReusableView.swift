//
//  SearchReusableView.swift
//  FlickrPhotoSearch
//
//  Created by Harshal Wani on 24/12/19.
//  Copyright © 2019 Harshal Wani. All rights reserved.
//

import UIKit
import SearchTextField

protocol SearchTextDelegate: class {
    func enteredText(str: String)
}
protocol SaveItemDefaultable: class {
    func save(value: String)
}

class SearchReusableView: UICollectionReusableView {
    
    @IBOutlet weak var searchTextField: SearchTextField!
    public static let reusableId: String = "SearchReusableView"
    
    weak var delegate: SearchTextDelegate?
    weak var saveDelegate: SaveItemDefaultable?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        searchTextField.delegate = self
        if saveDelegate != nil {
            configureSimpleSearchTextField()
        }
    }
    
    fileprivate func configureSimpleSearchTextField() {
        searchTextField.theme.cellHeight = 50
        searchTextField.maxResultsListHeight = 230
        searchTextField.theme.separatorColor = UIColor.lightGray.withAlphaComponent(0.5)
        searchTextField.startVisible = true
    }
}

extension SearchReusableView: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if saveDelegate != nil {
            guard let items = UserDefaults.retrive(key: AppConstants.Defaults.searchHistory) as? [String] else {
                return
            }
            searchTextField.filterStrings(items)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let text = textField.text {
            saveDelegate?.save(value: text)
            delegate?.enteredText(str: text)
        }
        return true
    }
}
