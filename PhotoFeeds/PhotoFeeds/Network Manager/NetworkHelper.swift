
import ObjectMapper
import Alamofire


/// It is acting like an interface who knows which manager to use for making the api call.
class NetworkHelper {

    static let shared = NetworkHelper()
    
    private init () { }

    func getPhotosForTextQuery(_ text: String, pageSize: Int, pageNumber: Int, completion:@escaping (Result<PhotosModel>) -> Void) {
    
        PhotoFeedManager().getPhotosForTextQuery(text, pageSize: pageSize, pageNumber: pageNumber) { result in
            completion(result)
        }
    }
}
