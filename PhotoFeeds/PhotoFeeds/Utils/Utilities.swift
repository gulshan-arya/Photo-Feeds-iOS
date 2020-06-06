
import Foundation


class Utility {
    
    static let shared = Utility()
    
    private init() { }
    
    enum ImageSize: String {
      case medium = "m"
    }
    
    ///TODO:  Make URL Step by step
    func getMediumImageUrl(_ farmId: String, serverId: String, photoId: String, secretId: String) ->  String {
        return "https://farm\(farmId).staticflickr.com/\(serverId)/\(photoId)_\(secretId)_\(ImageSize.medium.rawValue).jpg"
    }
    
    //MARK:- Private method(s)
    ///private func get
}




