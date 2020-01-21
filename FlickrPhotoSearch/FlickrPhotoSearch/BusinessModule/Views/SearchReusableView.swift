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
    func enteredText(_ str: String)
}
protocol SaveItemDefaultable: class {
    func save(_ value: String)
}

class SearchReusableView: UICollectionReusableView {
    
    /// Outlet
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var searchTextField: SearchTextField!
    
    /// Local
    public static let reusableId: String = "SearchReusableView"
    weak var searchTextDelegate: SearchTextDelegate?
    weak var saveDelegate: SaveItemDefaultable?
    
    
    /// Initialization
    override func awakeFromNib() {
        super.awakeFromNib()
        configureSearchTextField()
    }
    
    //MARK: - Private
    fileprivate func configureSearchTextField() {
        searchTextField.delegate = self
        searchTextField.setIcon(UIImage(named: "ic_search"))
        searchTextField.theme.font = UIFont.systemFont(ofSize: 14)
        searchTextField.theme.bgColor = UIColor.white
        searchTextField.theme.borderColor = UIColor.lightGray.withAlphaComponent(0.5)
        searchTextField.theme.cellHeight = 50
        searchTextField.maxResultsListHeight = 230
        searchTextField.theme.separatorColor = UIColor.lightGray.withAlphaComponent(0.5)
        searchTextField.itemSelectionHandler = {item, itemPosition in
            self.searchTextField.text = item[itemPosition].title
            self.cancelButton.isEnabled = (self.searchTextField.text!.count > 0)
            self.searchItem()
        }
    }
    
    fileprivate func searchItem() {
        guard let text = searchTextField.text else {
            return
        }
        searchTextField.resignFirstResponder()
        saveDelegate?.save(text)
        searchTextDelegate?.enteredText(text)
    }
    
    //MARK: - Action
    @IBAction func cancelButtonTap(_ sender: UIButton) {
        searchTextField.text = ""
        searchTextField.becomeFirstResponder()
    }
}

extension SearchReusableView: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if saveDelegate != nil {
            guard let items = UserDefaults.retrive(key: AppConstants.Defaults.searchHistory) as? [String] else {
                return
            }
            searchTextField.filterStrings(items)
            searchTextField.startVisibleWithoutInteraction = true
            cancelButton.isEnabled = (textField.text!.count > 0)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.count + string.count - range.length
        cancelButton.isEnabled = (newLength > 0)
        return true
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text != nil {
            searchItem()
        }
        return true
    }
}
