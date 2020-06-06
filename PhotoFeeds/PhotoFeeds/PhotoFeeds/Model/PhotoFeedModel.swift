
//
//  Database.swift
//  PhotoFeeds
//
//  Created by Gulshan on 06/06/20.
//  Copyright © 2020 Gulshan. All rights reserved.
//

import ObjectMapper

struct PhotosModel: Mappable {

    private(set) var totalPhotos   : Int = 0
    private(set) var photos        : [PhotosFeedModel]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        
        totalPhotos  <- map["total"]
        photos       <- map["hits"]
    }
}

struct PhotosFeedModel: Mappable {

    private(set) var photoId      : Int!
    private(set) var smallImageUrl: String!
    private(set) var largeImageUrl: String!

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        
        photoId           <- map["id"]
        smallImageUrl     <- map["previewURL"]
        largeImageUrl     <- map["largeImageURL"]
    }
}
