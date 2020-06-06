//
//  UserDefaultDatabase.swift
//  PhotoFeeds
//
//  Created by Gulshan on 06/06/20.
//  Copyright © 2020 Gulshan. All rights reserved.
//


class UserdefaultsDatabase: DatabaseLike, SearchDatabase {
    
    var type: DatabaseType {
        return .userDefaults
    }
    
    func saveRecentlySearchImageQuery(_ text: String) {
        
    }
    
    func fetchRecentlySearchedImageQueries() -> [String] {
        
        return ["Log", "CAR", "Cutie", "Flower"]
    }
    
    //MARK:- Private Method(s)
}
