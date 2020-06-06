//
//  UserDefaultDatabase.swift
//  PhotoFeeds
//
//  Created by Gulshan on 06/06/20.
//  Copyright © 2020 Gulshan. All rights reserved.
//

import Foundation

class UserdefaultsDatabase: DatabaseLike, SearchDatabase {
    
    var type: DatabaseType {
        return .userDefaults
    }
    
    private let recentSearchedImageQuery = "recentSearchedImageQuery"
    
    func saveRecentlySearchImageQuery(_ text: String) {
        
        let defaults = UserDefaults.standard
        var results = fetchRecentlySearchedImageQueries()
        if results.isEmpty {
            defaults.set([text], forKey: recentSearchedImageQuery)
            return
        }
        
        if results.count >= 10 {
            results.removeFirst()
        }
        
        results.insert(text, at: 0)
        results.removeDuplicates()
        return defaults.set(results, forKey: recentSearchedImageQuery)
    }
    
    func fetchRecentlySearchedImageQueries() -> [String] {
        
        let defaults = UserDefaults.standard
        if let results = defaults.stringArray(forKey: recentSearchedImageQuery)  {
            return results
        }
        
        return []
    }
}


    
extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()

        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }

    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}
