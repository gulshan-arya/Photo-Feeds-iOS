//
//  Database.swift
//  PhotoFeeds
//
//  Created by Gulshan on 06/06/20.
//  Copyright © 2020 Gulshan. All rights reserved.
//

import UIKit

class PaganationReusableView: UICollectionReusableView {

   @IBOutlet private weak var animator: UIActivityIndicatorView!
      
     override func awakeFromNib() {
         super.awakeFromNib()
         
         animator.stopAnimating()
         backgroundColor = UIColor.clear
     }
     
     //MARK:- Public method(s)
     func starAnimating() {
         animator.startAnimating()
     }
     
     func stopAnimating() {
         animator.stopAnimating()
     }
}
