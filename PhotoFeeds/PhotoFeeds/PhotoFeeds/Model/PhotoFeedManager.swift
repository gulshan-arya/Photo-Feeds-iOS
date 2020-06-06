//
//  Database.swift
//  PhotoFeeds
//
//  Created by Gulshan on 06/06/20.
//  Copyright © 2020 Gulshan. All rights reserved.
//

import Alamofire
import ObjectMapper

class PhotoFeedManager: NetworkManager {
    
    override func success<T>(result: Result<Any>) -> Result<T> {
        
        let storefront = Mapper<PhotosModel>().map(JSONObject: result.value)
        return Result.success(storefront as! T)
    }
    
    override func failure<T>(result: Result<Any>) -> Result<T> {
        
        return result.error != nil ? Result.failure(result.error!) : Result.failure(NSError.genericError())
    }
    
    func getPhotosForTextQuery(_ text: String, pageSize: Int, pageNumber: Int, completion: @escaping (Result<PhotosModel>) -> Void) {
        
        let url = ServerConfig.PHOTO_FEEDS_URL
        let params = ["key": ServerConfig.API_KEY,
                      "q": text,
                      "image_type": "photo",
                      "per_page": String(pageSize),
                      "page": String(pageNumber)]
        
        self.getDataFromUrl(url, parameters: params) { (response) in
            
            let result = self.processReponse(response: response) as Result<PhotosModel>
            completion(result)
        }
    }
}


extension Error {
    
    static func genericError() -> NSError {
        var userInfo = [String:String]()
        userInfo[NSLocalizedDescriptionKey] = "Could not complete request"
        userInfo[NSLocalizedFailureReasonErrorKey] = "Internal Error"
        return  NSError(domain: Bundle.main.bundleIdentifier!, code: 500, userInfo: userInfo)
    }
}
