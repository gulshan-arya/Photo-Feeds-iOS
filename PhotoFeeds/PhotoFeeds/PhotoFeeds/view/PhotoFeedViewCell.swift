//
//  Database.swift
//  PhotoFeeds
//
//  Created by Gulshan on 06/06/20.
//  Copyright © 2020 Gulshan. All rights reserved.
//


import UIKit

class PhotoFeedViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var feedImageView: UIImageView!
    
    //MARK:- Public method(s)
    func updateCell(_ photoFeed: PhotosFeedModel) {
        
        guard let _ = photoFeed.photoId,
            let smallImageUrl = photoFeed.smallImageUrl else {
            return
        }
                
        if let url = URL(string: smallImageUrl) {
            self.feedImageView.sd_setImage(with: url) // Not adding placeholder
        }
    }
}


