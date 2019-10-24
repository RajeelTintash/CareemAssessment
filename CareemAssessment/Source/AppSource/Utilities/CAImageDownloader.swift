//
//  CAImageDownloader.swift
//  CareemAssesment
//
//  Created by Rajeel Amjad on 22/10/2019.
//  Copyright © 2019 Rajeel Amjad. All rights reserved.
//

import Foundation
import UIKit

/// Shared cache manager
class CAImageCacheManager {
    static let shared = CAImageCacheManager()
    let imageCache = NSCache<NSString,UIImage>()
}

extension UIImageView {
    
    /// sets the placeholder image and tries to get the original
    /// - Parameter imageURL: url of requested image
    /// - Parameter placeholderImage: placeholder image
    func setImageFromCacheOrDownload (_ imageURL:URL, placeholderImage: UIImage){
        self.image = placeholderImage
        getImageForURL(imageURL , image: { image in
            guard let image = image else { return }
            self.image = image
        })
    }
    
    // MARK: image downloading and caching functions
    
    /// Downloads the image and sets in cache
    /// - Parameter imageURL: url of requested image
    /// - Parameter image: the returned image
    fileprivate func downloadImage(imageURL : URL, image : @escaping (_ image : UIImage?)->()) {
        let dataTask = URLSession.shared.dataTask(with: imageURL) { (data, response, error ) in
            var downloadedImage : UIImage?
            if let data = data {
                downloadedImage = UIImage(data: data)
            }
            if let image = downloadedImage {
                CAImageCacheManager.shared.imageCache.setObject(image, forKey: imageURL.absoluteString as NSString)
            }
            DispatchQueue.main.async {
                image(downloadedImage)
            }
        }
        dataTask.resume()
    }
    
    /// Tries to get image from cache or downloads it
    /// - Parameter imageURL: url of requested image
    /// - Parameter image: the returned image
    fileprivate func getImageForURL(_ imageURL : URL, image : @escaping (_ image : UIImage?)->()) {
        if let cachedImage = CAImageCacheManager.shared.imageCache.object(forKey: imageURL.absoluteString as NSString) {
            image(cachedImage)
        }
        else {
            downloadImage(imageURL: imageURL, image: image)
        }
    }
}
