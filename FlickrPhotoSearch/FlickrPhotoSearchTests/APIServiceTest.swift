//
//  APIServiceTest.swift
//  FlickrPhotoSearchTests
//
//  Created by Harshal Wani on 29/12/19.
//  Copyright © 2019 Harshal Wani. All rights reserved.
//

import XCTest
@testable import FlickrPhotoSearch

class APIServiceTest: XCTestCase {
    
    var aPIService: APIService?
    
    override func setUp() {
        super.setUp()
        aPIService = APIService()
    }

    override func tearDown() {
        aPIService = nil
        super.tearDown()
    }

    func testSearchPhotos() {

        // Given
        let aPIService = self.aPIService!

        // When search photo
        let expect = XCTestExpectation(description: "API call and runs the callback closure")

        let queryParams = ["text" : "fruit",
        "page" : "1"]
        aPIService.getDataFromURL(.searchPhoto(queryParams: queryParams)) { (result) in
            expect.fulfill()
            switch result {
            case .success(let data):
                do {
                    let photosResponse = try JSONDecoder().decode(SearchPhotosResponse.self, from: data)
                    XCTAssertEqual( photosResponse.photoList.count, Int(AppConstants.APIParams.perPageLimit))
                } catch {
                }
            case .failure(let err):
                XCTFail("error occured: \(err))")
            }
        }

        wait(for: [expect], timeout: 3.0)
    }
    
}
