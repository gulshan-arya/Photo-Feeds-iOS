//
//  Database.swift
//  PhotoFeeds
//
//  Created by Gulshan on 06/06/20.
//  Copyright © 2020 Gulshan. All rights reserved.
//

import Foundation

enum DatabaseType {
    case userDefaults
}

protocol DatabaseLike {
    var type: DatabaseType { get }
}

/// Base type for any database which will have search functionality e.g it can be userdefaults, realm or coredata but the method(s) should be the same for scaling it.
/// Anyone database that we will use should implement this type
protocol SearchDatabase {
    
    func fetchRecentlySearchedImageQueries() -> [String]
    
    func saveRecentlySearchImageQuery(_ text: String)
}




