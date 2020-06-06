//
//  SearchSuggestionCell.swift
//  PhotoFeeds
//
//  Created by Gulshan on 06/06/20.
//  Copyright © 2020 Gulshan. All rights reserved.
//

import UIKit

class SearchSuggestionCell: UITableViewCell {

    @IBOutlet private(set) weak var titleLabel: UILabel!
    
    static var id: String {
        return "SearchSuggestionCell"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.text = nil
    }
}
