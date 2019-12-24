//
//  PhotoListViewController.swift
//  FlickrPhotoSearch
//
//  Created by Harshal Wani on 07/12/19.
//  Copyright © 2019 Harshal Wani. All rights reserved.
//

import UIKit

protocol PhotoSearchable {
    var pageIndex: Int { get set }
    var searchText : String { get set }
}

final class PhotoListViewController: UICollectionViewController, Storyboarded, PhotoSearchable {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    internal let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    private let itemsPerRow: CGFloat = 2
    
    var pageIndex = 1
    var searchText = "cat"
    
    internal lazy var viewModel: PhotoViewModel = {
       return PhotoViewModel()
    }()
    
    //MARK: - View life cyle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = LocalizableStrings.photoListTitle
        FlickrPhotoCell.register(for: self.collectionView)
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        {
           // flowLayout.headerReferenceSize = CGSize(width: self.collectionView.frame.size.width, height: 100)
            flowLayout.sectionHeadersPinToVisibleBounds = true
        }
        initViewModel()
    }
    
    //MARK: - Private

    private func initViewModel() {
        
        // Naive binding
        viewModel.showAlertClosure = { [weak self] () in
            DispatchQueue.main.async {
                if let message = self?.viewModel.alertMessage {
                    UIAlertController.showAlert(title: LocalizableStrings.error, message: message, cancelButton: LocalizableStrings.ok)
                }
            }
        }
        
//        viewModel.updateLoadingStatusClosure = {[weak self] () in
//            DispatchQueue.main.async {
//                let isLoading = self?.viewModel.isLoading ?? false
//                if isLoading {
//                    self?.activityIndicator.startAnimating()
//                    UIView.animate(withDuration: 0.2, animations: {
//                        self?.collectionView.alpha = 0.0
//                    })
//                }else {
//                    self?.activityIndicator.stopAnimating()
//                    UIView.animate(withDuration: 0.2, animations: {
//                        self?.collectionView.alpha = 1.0
//                    })
//                }
//            }
//        }
        
        viewModel.reloadVehicleDataClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        self.pageIndex += 1
        viewModel.searchPhotos(query: ["text" : self.searchText,
        "page" : "\(self.pageIndex)"])
    }
}
