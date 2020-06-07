//
//  ProgressIndicator.swift
//  PhotoFeeds
//
//  Created by Gulshan on 07/06/20.
//  Copyright © 2020 Gulshan. All rights reserved.
//

import Foundation
import SVProgressHUD

class ProgressIndicator {
    
    static private var isLoaderStopped = false
    // This Method is called in ZLHomeViewController, so that progress indicator appearance is customized for the whole app.
    class func customizeProgressIndicator() {
        
        SVProgressHUD.setDefaultStyle(.custom)
        SVProgressHUD.appearance().ringThickness                = 4.0
        SVProgressHUD.appearance().foregroundColor              = .systemPurple
        SVProgressHUD.appearance().fadeInAnimationDuration      = 0.0
        SVProgressHUD.appearance().fadeOutAnimationDuration     = 0.0
        SVProgressHUD.appearance().minimumDismissTimeInterval   = 0.0
    }
    
    class func startAnimation() {
        isLoaderStopped = false
        //Adding delay for starting the loader
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if !isLoaderStopped {
             SVProgressHUD.show()
            }
        }
    }
    
    class func stopAnimation() {
        isLoaderStopped = true
        SVProgressHUD.dismiss()
    }
}

