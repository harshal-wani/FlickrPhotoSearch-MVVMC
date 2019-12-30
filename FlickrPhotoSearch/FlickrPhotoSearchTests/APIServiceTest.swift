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

    func testSearchResponseDecoding() throws {
        
        let json = """
        {
          "photos": {
            "page": 1,
            "pages": 1824,
            "perpage": 20,
            "total": "1",
            "photo": [
              {
                "id": "49182167128",
                "owner": "144588813@N02",
                "secret": "d98ff9a1f3",
                "server": "65535",
                "farm": 66,
                "title": "P-90-Fd-061",
                "ispublic": 1,
                "isfriend": 0,
                "isfamily": 0
              }
            ]
          },
          "stat": "ok"
        }
        """.data(using: .utf8)!
        
        XCTAssertNoThrow(try JSONDecoder().decode(SearchPhotosResponse.self, from: json))
    }
    
    func testSearchPhotosCount() {

        // Given
        let aPIService = self.aPIService!

        // When search photo
        let expect = XCTestExpectation(description: "API call and runs the callback closure")

        let requestParam = SearchPhotoRequest(text: "fruit", page: 1).asDictionary()
        aPIService.getDataFromURL(.searchPhoto(queryParams: requestParam)) { (result) in
            expect.fulfill()
            switch result {
            case .success(let data):
                do {
                    let photosResponse = try JSONDecoder().decode(SearchPhotosResponse.self, from: data)
                    XCTAssertEqual( photosResponse.photoList.count, Int(AppConstants.APIParams.perPageLimit))
                } catch {
                    XCTFail("Decode error")
                }
            case .failure(let err):
                XCTFail("error occured: \(err))")
            }
        }
        wait(for: [expect], timeout: 10.0)
    }
    
    func testValidatePhotoURL() {
        // Given
        let aPIService = self.aPIService!

        // When search photo
        let expect = XCTestExpectation(description: "Returns all fields to create valid image url")
        
        let requestParam = SearchPhotoRequest(text: "fruit", page: 1).asDictionary()
        aPIService.getDataFromURL(.searchPhoto(queryParams: requestParam)) { (result) in
            
            switch result {
            case .success(let data):
                do {
                    let photosResponse = try JSONDecoder().decode(SearchPhotosResponse.self, from: data)
                    let count = photosResponse.photoList.count
                    if count == 0 {
                        XCTFail("No photos returned")
                        return
                    }
                    
                    XCTAssert(true, "Returned photos")
                    
                    // Pick first photo to test image url
                    let photo = photosResponse.photoList.first
                    
                    if photo?.farm == nil {
                        XCTFail("No farm id returned")
                    }
                    
                    if photo?.server == nil {
                        XCTFail("No server id returned")
                    }
                    
                    if photo?.id == nil {
                        XCTFail("No photo id returned")
                    }
                    
                    if photo?.secret == nil {
                        XCTFail("No secret id returned")
                    }
                    
                    XCTAssert(true, "Success")
                    expect.fulfill()
                } catch {
                    XCTFail("Decode error")
                }
            case .failure(let err):
                XCTFail("error occured: \(err))")
            }
        }
        wait(for: [expect], timeout: 10.0)
    }
}
