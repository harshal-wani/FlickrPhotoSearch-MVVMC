//
//  APIService.swift
//  FlickrPhotoSearch
//
//  Created by Harshal Wani on 07/12/19.
//  Copyright © 2019 Harshal Wani. All rights reserved.
//

import Foundation

protocol APIServiceProtocol {
    func getDataFromURL(_ endPoint: EndPoint, completion: @escaping (Result<Data, APIError>) -> ())
}

final class APIService: APIServiceProtocol {
        
    func getDataFromURL(_ endPoint: EndPoint, completion: @escaping (Result<Data, APIError>) -> ()) {
        
        
//        let url = Bundle.main.url(forResource: "MockPhotoList", withExtension: "json")!
//        do {
//            let data = try Data(contentsOf: url)
//            let json = try? JSONSerialization.jsonObject(with: data, options: [])
//            print(json)
//            completion(.success(data))
//        } catch {
//            print("ERROR")
//        }
        
        
        guard let url = endPoint.url else {
            return completion(.failure(APIError.invalidURL))
        }
        if !Utilities.isInternetAvailable() {
            completion(.failure(APIError.noNetwork))
            return
        }
        print(url)

        //Make request
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in

            guard error == nil else {
                completion(.failure(.invalidURL))
                return
            }
            guard data != nil else {
                completion(.failure(APIError.noData))
                return
            }
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode else {
                completion(.failure(APIError.checkErrorCode((response as? HTTPURLResponse)!.statusCode)))
                return
            }
//            let json = try? JSONSerialization.jsonObject(with: data!, options: [])
//            print(json)
            completion(.success(data!))
        }
        task.resume()
//
    }
    
}
