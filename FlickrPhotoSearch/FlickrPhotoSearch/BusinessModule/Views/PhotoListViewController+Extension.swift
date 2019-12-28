//
//  PhotoListViewController+Extension.swift
//  FlickrPhotoSearch
//
//  Created by Harshal Wani on 24/12/19.
//  Copyright © 2019 Harshal Wani. All rights reserved.
//

import UIKit

// MARK: - UICollectionViewDataSource
extension PhotoListViewController {
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if (kind == UICollectionView.elementKindSectionHeader) {
            let headerView:SearchReusableView =  collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SearchReusableView.reusableId, for: indexPath) as! SearchReusableView
            headerView.delegate = self
            headerView.saveDelegate = self
            return headerView
        }
        
        return UICollectionReusableView()
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? FlickrPhotoCell else { return }
        cell.dataCellViewModel = viewModel.getCellViewModel( at: indexPath.row )
        
        //Load more on scroll down
        if indexPath.row == viewModel.numberOfCells - Int(itemsPerRow),
            !viewModel.isLoading {
            requestGetPhotos()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FlickrPhotoCell.reusableId, for: indexPath) as? FlickrPhotoCell else {
            fatalError("\(FlickrPhotoCell.reusableId) not exists!")
        }
        return cell
    }
}

// MARK: - Collection View Flow Layout Delegate
extension PhotoListViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  sectionInsets.left * (2 + 1)
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize/2, height: collectionViewSize/2)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
}

// MARK: - SearchTextDelegate
extension PhotoListViewController: SearchTextDelegate {
    
    func enteredText(_ str: String) {
        self.pageIndex = 0
        self.searchText = str
        self.requestGetPhotos(reset: true)
    }
}

extension PhotoListViewController: SaveItemDefaultable {
    func save(_ value: String) {
        Utilities.saveSearchItemToUserDefaults(key: AppConstants.Defaults.searchHistory ,value: value)
    }
}
