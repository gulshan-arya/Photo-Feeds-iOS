//
//  PhotoFeedProtocols.swift
//  PhotoFeeds
//
//  Created by Gulshan on 06/06/20.
//  Copyright © 2020 Gulshan. All rights reserved.
//

import UIKit

protocol SearchBarDelegate {
    func searchBarDidEndEditing(with text: String)
}

protocol PhotoFeedsViewModelDelegate: class {
    
    var viewController: UIViewController { get }
    
    func refreshView()
    func showError(_ errorMessage: String)
    func showEmptySearchResultView(with message: String)
    func hideEmptySearchResultView()
}
