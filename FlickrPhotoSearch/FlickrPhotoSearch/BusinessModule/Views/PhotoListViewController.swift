//
//  PhotoListViewController.swift
//  FlickrPhotoSearch
//
//  Created by Harshal Wani on 07/12/19.
//  Copyright © 2019 Harshal Wani. All rights reserved.
//

import UIKit

final class PhotoListViewController: UICollectionViewController, Storyboarded, PhotoSearchable {
    
    /// Local
    internal let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    internal let itemsPerRow: CGFloat = 2
    internal lazy var viewModel: PhotoViewModel = {
       return PhotoViewModel()
    }()
    
    /// PhotoSearchable
    var searchText = "fruit"
    
    //MARK: - View life cyle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = LocalizableStrings.photoListTitle
        configureCollectionView()
        viewModelClosures()
    }
    
    //MARK: - Private
    private func configureCollectionView() {
        FlickrPhotoCell.register(for: collectionView)
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.headerReferenceSize = CGSize(width: self.collectionView.frame.size.width, height: 40)
            flowLayout.sectionHeadersPinToVisibleBounds = true
        }
    }
    private func viewModelClosures() {
        
        viewModel.showAlert = { (message) in
            DispatchQueue.main.async {
                    UIAlertController.showAlert(title: LocalizableStrings.error, message: message, cancelButton: LocalizableStrings.ok)
            }
        }
        viewModel.updataPhotoData = { [weak self] () in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
    
    private func updateCollectionViewLayout(with size: CGSize) {
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            
            let padding: CGFloat =  sectionInsets.left * (itemsPerRow + 1)
            let collectionViewSize = collectionView.frame.size.width - padding
            
            layout.itemSize = CGSize(width: collectionViewSize/itemsPerRow, height: collectionViewSize/itemsPerRow)
            layout.invalidateLayout()
        }
    }
    
    //MARK: - Internal
    internal func requestGetPhotos(reset: Bool? = false) {
        if reset == true {
            viewModel.resetCellViewModels = true
        }
        viewModel.searchPhotos(text: self.searchText)

    }

    //MARK: - Action
    @IBAction func handleTap(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    //MARK: - UIScrollViewDelegate
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
    
    //MARK: - Rotation
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        updateCollectionViewLayout(with: size)
    }
}
