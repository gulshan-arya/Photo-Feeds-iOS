//
//  SDWebImageSource.swift
//  PhotoFeeds
//
//  Created by Gulshan on 06/06/20.
//  Copyright © 2020 Gulshan. All rights reserved.
//

import SDWebImage
import ImageSlideshow

protocol SDWebImageSourceDelegate: class{
    func completedImageDownloading(in source: SDWebImageSource)
}

open class SDWebImageSource: NSObject, InputSource {
    
    weak var delegate:SDWebImageSourceDelegate?
    
    /**
     Load image from the source to image view.
     - parameter imageView: The image view to load the image into.
     - parameter callback: Callback called after the image was set to the image view.
     - parameter image: Image that was set to the image view.
     */
    open func load(to imageView: UIImageView, with callback: @escaping (UIImage?) -> Void) {

        
        imageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        imageView.sd_setImage(with: self.url, placeholderImage: self.placeholder, options: [.highPriority], completed: {
            [weak self] (image, error, cashtype , url) in
            
            self?.delegate?.completedImageDownloading(in: self!)
        })
    }

    var url: URL
    var placeholder: UIImage?
    
    public init(url: URL) {
        self.url = url
        super.init()
    }
    
    public init(url: URL, placeholder: UIImage) {
        self.url = url
        self.placeholder = placeholder
        super.init()
    }
    
    public init?(urlString: String) {
        if let validUrl = URL(string: urlString) {
            self.url = validUrl
            super.init()
        } else {
            return nil
        }
    }
    
    @objc open func setToImageView(_ imageView: UIImageView) {
        imageView.sd_setImage(with: self.url, placeholderImage: self.placeholder)
    }
}
