
//
//  Database.swift
//  PhotoFeeds
//
//  Created by Gulshan on 06/06/20.
//  Copyright © 2020 Gulshan. All rights reserved.
//


import UIKit

protocol SearchLandingViewModelDelegate: class {
    func refreshUI()
    func showHideEmptySearchView()
}

class SearchLandingViewModel {
    
    weak var viewDelegate: SearchLandingViewModelDelegate?
    
    private var database                 : SearchDatabase
    private(set) var resultSearchResults = [String]()
    
    private lazy var databaseQueue: DispatchQueue = {
        return DispatchQueue(label: "com.Gulshan.PhotoFeeds", qos: .userInitiated, attributes: .concurrent)
    }()
    
    init(database: SearchDatabase) {
        self.database = database
    }
    
    //MARK:- public method(s)
    func fetchRecentSearches() {
        
        databaseQueue.async {
            self.resultSearchResults = self.database.fetchRecentlySearchedImageQueries()
            DispatchQueue.main.async {
                self.viewDelegate?.showHideEmptySearchView()
                self.viewDelegate?.refreshUI()
            }
        }
    }
    
}

