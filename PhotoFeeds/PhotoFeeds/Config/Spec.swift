
import Foundation


protocol Spec {
    
    func getBaseStaticImageUrl() -> String
    
    func getBaseAPIUrl() -> String
    
    func getApiKey() -> String
}

//We can create spec for different environment.
class ProdSpec: Spec {
    
    func getBaseStaticImageUrl() -> String {
        
        return ""
    }
    
    func getBaseAPIUrl() -> String {
        return  "https://pixabay.com/api/"
    }
    
    func getApiKey() -> String {
        return "16910125-9ad35f61c1b59f4f648d957e7"
    }
}



