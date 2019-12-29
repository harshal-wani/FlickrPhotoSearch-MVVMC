//
//  FlickrPhotoSearchTest.swift
//  FlickrPhotoSearchTests
//
//  Created by Harshal Wani on 07/12/19.
//  Copyright © 2019 Harshal Wani. All rights reserved.
//

import XCTest
@testable import FlickrPhotoSearch

class FlickrPhotoSearchTest: XCTestCase {

    override func setUp() {
    }

    override func tearDown() {
    }

    func testIsInternetAvailable() {
        if Utilities.isInternetAvailable() {
            XCTAssertTrue(Utilities.isInternetAvailable())
        } else {
            XCTAssertFalse(Utilities.isInternetAvailable())
        }
    }
    
    func testDataCellViewModel() {
        let photo = Photo(id: "1", title: "Photo title", server: "123", secret: "456", farm: 1)
        let photoTestUrl = "https://farm1.staticflickr.com/123/1_456_m.jpg"
        let dataCellViewModel = DataCellViewModel(photo: photo)
        
        XCTAssertEqual(photo.title, dataCellViewModel.title)
        XCTAssertEqual(photoTestUrl, dataCellViewModel.photoURL)
    }

    func testSearchPhotosResponseDecoding() throws {
        
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
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
