//
//  Array + PhotoFeeds.swift
//  PhotoFeeds
//
//  Created by Gulshan on 07/06/20.
//  Copyright © 2020 Gulshan. All rights reserved.
//

import Foundation

extension Array where Element: Hashable {
    
    func getUnique() -> [Element] {
        var addedDict = [Element: Bool]()
        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }

    mutating func removeDuplicates() {
        self = self.getUnique()
    }
}
