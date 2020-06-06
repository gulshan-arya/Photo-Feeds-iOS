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

protocol SearchDatabase {
    
    func fetchRecentlySearchedImageQueries() -> [String]
    
    func saveRecentlySearchImageQuery(_ text: String)
}




