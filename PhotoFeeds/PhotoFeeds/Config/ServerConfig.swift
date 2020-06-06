

import Foundation


struct ServerConfig {

    static private let BASE_URL = SpecProvider.currentSpec.getBaseAPIUrl()
    static let API_KEY = SpecProvider.currentSpec.getApiKey()

    static let PHOTO_FEEDS_URL = BASE_URL
}
