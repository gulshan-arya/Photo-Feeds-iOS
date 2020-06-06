
import ObjectMapper
import Alamofire


class NetworkHelper {

    static let shared = NetworkHelper()
    
    private init () { }

    func getPhotosForTextQuery(_ text: String, pageSize: Int, pageNumber: Int, completion:@escaping (Result<PhotosModel>) -> Void) {
    
        PhotoFeedManager().getPhotosForTextQuery(text, pageSize: pageSize, pageNumber: pageNumber) { result in
            completion(result)
        }
    }
}
