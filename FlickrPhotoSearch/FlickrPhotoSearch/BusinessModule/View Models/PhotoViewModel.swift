//
//  PhotoViewModel.swift
//  FlickrPhotoSearch
//
//  Created by Harshal Wani on 07/12/19.
//  Copyright © 2019 Harshal Wani. All rights reserved.
//

import Foundation

final class PhotoViewModel: NSObject {
    
    // Closures
    var showAlertClosure: (() -> ())?
    var reloadVehicleDataClosure: (() -> ())?
    var updateLoadingStatusClosure: (() -> ())?
    
    let apiService: APIServiceProtocol

    private(set) var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatusClosure?()
        }
    }
    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }
    var numberOfCells: Int {
        return cellViewModels.count
    }
    private var cellViewModels: [DataCellViewModel] = [DataCellViewModel]() {
        didSet {
            self.reloadVehicleDataClosure?()
        }
    }
    
    init( apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    //MARK: - Private
    
    private func processFetchedData(_ models: [Photo]) {
        self.cellViewModels += models.map { DataCellViewModel(photo: $0)  }
    }
    
    //MARK: - Public
    
    func searchPhotos(query: [String:String]) {
        self.isLoading = true
        
        self.apiService.getDataFromURL(.searchPhoto(list: query)) { [weak self] (result) in
            self?.isLoading = false
            switch result {
            case .success(let data):
                do {
                    let photosResponse = try JSONDecoder().decode(PhotosResponse.self, from: data)
                    guard !photosResponse.photoList.isEmpty else {
                        self?.alertMessage = APIError.noData.rawValue
                        return
                    }
                    self?.processFetchedData(photosResponse.photoList)
                } catch {
                    self?.alertMessage = APIError.decodeError.rawValue
                }
            case .failure(let err):
                self?.alertMessage = err.rawValue
            }
        }
    }
    
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
        self.photoURL = "https://farm\(photo.farm).staticflickr.com/\(photo.server)/\(photo.id)_\(photo.secret)_t.jpg"
    }
}
