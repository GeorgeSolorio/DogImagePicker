//
//  DogAPI.swift
//  imageRequest
//
//  Created by George Solorio on 5/30/20.
//  Copyright © 2020 George Solorio. All rights reserved.
//

import Foundation
import UIKit

class DogAPI {
    enum endPoint {
        case randomImageFromAllDogsCollection
        case randomImageForBreed(String)
        case listAllBreeds
        
        var url: URL {
            return URL(string: self.stringValue)!
        }
        
        var stringValue: String {
            switch self {
            case .randomImageForBreed(let breed):
                return "https://dog.ceo/api/breed/\(breed)/images/random"
            case .randomImageFromAllDogsCollection:
                return "https://dog.ceo/api/breeds/image/random"
            case .listAllBreeds:
                return "https://dog.ceo/api/breeds/list/all"
            }
        }
    }

    class func requestBreedsList(completionHandler: @escaping ([String], Error?) -> ()) {
        
        let task = URLSession.shared.dataTask(with: endPoint.listAllBreeds.url) { (data, response, error) in
            
            guard let data = data else {
                completionHandler([], error!)
                return
            }
            
            let decoder = JSONDecoder()
            let breedsResponse = try! decoder.decode(BreedsListResponse.self, from: data)
            let breeds = breedsResponse.message.keys.map({$0})
            completionHandler(breeds, nil)
        }
        task.resume()
    }
    
    class func requestImageFile(url: URL, completionHandler: @escaping (UIImage?, Error?)->()) {
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                completionHandler(nil, error)
                return
            }
            
            let downloadedImage = UIImage(data: data)

            completionHandler(downloadedImage, nil)
        }
        
        task.resume()
    }
    
    class func requestRandomImage(breed: String, completionHandler: @escaping (DogImage?, Error?) -> () ) {
        let randomEndPoint = endPoint.randomImageForBreed(breed).url
        
        let task = URLSession.shared.dataTask(with: randomEndPoint) { (data, response, error) in
            
            guard let data = data else {
                completionHandler(nil, error)
                return
            }
            let decoder = JSONDecoder()
            let dogImage = try! decoder.decode(DogImage.self, from: data)
            completionHandler(dogImage, nil)
        }
        task.resume()
    }
}
