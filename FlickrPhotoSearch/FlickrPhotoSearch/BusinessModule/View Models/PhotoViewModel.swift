//
//  PhotoViewModel.swift
//  FlickrPhotoSearch
//
//  Created by Harshal Wani on 07/12/19.
//  Copyright © 2019 Harshal Wani. All rights reserved.
//

import Foundation

final class PhotoViewModel: NSObject {
    
    /// Local
    let apiService: APIServiceProtocol
    private(set) var isLoading: Bool = false
    private var pageNo = 0
    internal var numberOfCells: Int {
        return cellViewModels.count
    }
    internal var resetCellViewModels: Bool = false {
        didSet {
            self.pageNo = 0
            self.cellViewModels.removeAll()
        }
    }
    private var cellViewModels: [DataCellViewModel] = [DataCellViewModel]() {
        didSet {
            self.updataPhotoData?()
        }
    }
    
    // Closure
    var showAlert: ((String) -> Void)?
    var updataPhotoData: (() -> ())?

    init( apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    //MARK: - Private
    
    /// Create DataCellViewModel for collection view and append to cellViewModels
    /// - Parameter models: Array of Photo model
    private func processFetchedData(_ models: [Photo]) {
        self.cellViewModels += models.map { DataCellViewModel(photo: $0)  }
    }
    
    //MARK: - Public
    
    /// Pass search photo text to API service and handle response
    /// - Parameter query: query parameters in dictionary
    func searchPhotos(text: String) {
        self.isLoading = true
        self.pageNo += 1
        /// Create Dictionary using Request Model
        let requestParam = SearchPhotoRequest(text: text, page: self.pageNo).asDictionary()
        self.apiService.getDataFromURL(.searchPhoto(queryParams: requestParam)) { [weak self] (result) in
            self?.isLoading = false
            switch result {
            case .success(let data):
                do {
                    let photosResponse = try JSONDecoder().decode(SearchPhotosResponse.self, from: data)
                    guard !photosResponse.photoList.isEmpty else {
                        self?.showAlert?(APIError.noData.rawValue)
                        return
                    }
                    self?.processFetchedData(photosResponse.photoList)
                } catch {
                    self?.showAlert?(APIError.decodeError.rawValue)
                }
            case .failure(let err):
                self?.showAlert?(err.rawValue)

            }
        }
    }
    
    
    /// Get DataCellViewModel from cellViewModels
    /// - Parameter index: query index number
    func getCellViewModel( at index: NSInteger ) -> DataCellViewModel {
        return cellViewModels[index]
    }
    
}

// MARK:- DataCellViewModel
struct DataCellViewModel {
    let title: String
    let photoURL: String
    
    init(photo: Photo) {
        self.title = photo.title
        self.photoURL = "https://farm\(photo.farm).staticflickr.com/\(photo.server)/\(photo.id)_\(photo.secret)_\(AppConstants.size.url_s.rawValue).jpg"
    }
}
