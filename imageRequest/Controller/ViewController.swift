//
//  ViewController.swift
//  imageRequest
//
//  Created by George Solorio on 5/29/20.
//  Copyright © 2020 George Solorio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        DogAPI.requestRandomImage(completionHandler: handleRandomImageResponse(imageData:error:))
    }
    
    func handleRandomImageResponse(imageData: DogImage?, error: Error?) {
        guard let imageURL = URL(string: imageData?.message ?? "") else {
            print(error!)
            return
        }
        
        DogAPI.requestImageFile(url: imageURL, completionHandler: self.handleImageReponse(image:error:))
    }
    
    func handleImageReponse(image: UIImage?, error: Error?) {

        guard let image = image else {
            print(error!)
            return
        }

        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }
}

