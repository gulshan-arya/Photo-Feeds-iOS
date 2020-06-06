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

protocol PhotoFeedsRouterToViewModelDelegate: class {
    func searchLandingVC(_ vc: SearchLandingVC, didSelectSearchQuery text: String)
}

class PhotoFeedRouter: PhotoFeedRouterInterface {
    
    weak var routerToViewModelDelegate: PhotoFeedsRouterToViewModelDelegate?
    
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
        searchVc.delegate = self
        viewModel.viewDelegate = searchVc
        vc.navigationController?.pushViewController(searchVc, animated: true)
    }
}

extension PhotoFeedRouter: SearchLandingVCDelegate {
    
    func backButtonTapped(in vc: UIViewController) {
        vc.navigationController?.popViewController(animated: true)
    }
    
    func searchLandingVC(_ vc: SearchLandingVC, didSelectSearchQuery text: String) {
        
        if !text.isEmpty {
            routerToViewModelDelegate?.searchLandingVC(vc, didSelectSearchQuery: text)
            vc.navigationController?.popViewController(animated: true)
        }
    }
}
