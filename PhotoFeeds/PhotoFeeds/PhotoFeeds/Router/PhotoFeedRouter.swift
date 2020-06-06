//
//  PhotoFeedRouter.swift
//  PhotoFeeds
//
//  Created by Gulshan on 06/06/20.
//  Copyright © 2020 Gulshan. All rights reserved.
//

import UIKit
import ImageSlideshow

protocol PhotoFeedRouterInterface: class {
    func presentSlideShowVC(in vc: UIViewController, withDataSource dataSource: FullScreenSlideShowVCDataSource)
    func showSearchlandingVC(in vc: UIViewController)
}

class PhotoFeedRouter: PhotoFeedRouterInterface {
    
    //MARK:- Public method(s)
    func presentSlideShowVC(in vc: UIViewController, withDataSource dataSource: FullScreenSlideShowVCDataSource) {

        let slideShowVC = FullScreenSlideshowViewController()
        slideShowVC.modalPresentationStyle = .fullScreen
        slideShowVC.initialPage = dataSource.initialPage
        slideShowVC.inputs      = dataSource.inputSource
        slideShowVC.backgroundColor = .systemGray3
        slideShowVC.slideshow.pageIndicator = nil
        vc.present(slideShowVC, animated: true, completion: nil)
    }
    
    func showSearchlandingVC(in vc: UIViewController) {
        
        let viewModel = SearchLandingViewModel(database: UserdefaultsDatabase())
        let searchVc = SearchLandingVC(viewModel: viewModel)
        viewModel.viewDelegate = searchVc
        vc.navigationController?.pushViewController(searchVc, animated: true)
    }
}
