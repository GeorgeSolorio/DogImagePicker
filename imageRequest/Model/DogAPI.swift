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
    enum endPoint: String {
        case randomImageFromAllDogsCollection = "https://dog.ceo/api/breeds/image/random"
        var url: URL {
            return URL(string: self.rawValue)!
        }
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
    
    class func requestRandomImage(completionHandler: @escaping (DogImage?, Error?) -> () ) {
        let randomEndPoint = DogAPI.endPoint.randomImageFromAllDogsCollection.url
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
