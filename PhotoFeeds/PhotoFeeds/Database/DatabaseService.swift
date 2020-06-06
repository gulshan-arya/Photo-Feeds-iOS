//
//  DatabaseService.swift
//  PhotoFeeds
//
//  Created by Gulshan on 06/06/20.
//  Copyright © 2020 Gulshan. All rights reserved.
//

import UIKit

class DatabaseService: SearchDatabase {
    
    private let searchDatabase = UserdefaultsDatabase()
    
    //MARK:- SearchDatabase method(s)
    func fetchRecentlySearchedImageQueries() -> [String] {
        return searchDatabase.fetchRecentlySearchedImageQueries()
    }
    
    func saveRecentlySearchImageQuery(_ text: String) {
        searchDatabase.saveRecentlySearchImageQuery(text)
    }
}
