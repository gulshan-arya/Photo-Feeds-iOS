

import UIKit

class PhotoFeedsViewModel {

    unowned private var delegate: PhotoFeedsViewModelDelegate!
    
    private lazy var router = PhotoFeedRouter()
    private(set) var photoFeeds = [PhotosFeedModel]()
    private var searchDataBase: SearchDatabase = UserdefaultsDatabase()
  
    private(set) var isLoading  = false
    private var lastSearchQuery : String?
    private let pageSize        = 10
    private var pageNumber      = 1
    private var hasMoreData     = true
    
    lazy var photoSearchQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        queue.qualityOfService = .userInteractive
        return queue
    }()
    
    init(delegate: PhotoFeedsViewModelDelegate) {
        self.delegate = delegate
        router.routerToViewModelDelegate = self
    }
    
    //MARK:- Public method(s)
    func loadMoreImages(for searchQueuy: String) {

        photoSearchQueue.addOperation {
            self.fetchPhotos(for: searchQueuy)
        }
    }
   
    func collectionViewDidSelectItem(at indexPath: IndexPath) {
        guard let vc = delegate?.viewController else {
            return
        }
        
        let imageSources = photoFeeds.compactMap { SDWebImageSource(urlString: $0.largeImageUrl) }
        let dc = FullScreenSlideShowVCDataSource(initialPage: indexPath.row, inputSource: imageSources)
        router.presentSlideShowVC(in: vc, withDataSource: dc)
    }
    
    //MARK:- Private method(s)
    private func perFormFreshSearchWithText(_ text: String) {
        if lastSearchQuery == text { return }
        
        lastSearchQuery = text
        photoSearchQueue.addOperation {
            self.resetPaginationData()
            self.fetchPhotos(for: text, withNewQuery: true)
        }
    }
    
    private func fetchPhotos(for text: String, withNewQuery isFreshQuery: Bool = false) {
        
        guard !isLoading && hasMoreData else { return }
        
        isLoading = true
        NetworkHelper.shared.getPhotosForTextQuery(text, pageSize: pageSize, pageNumber: pageNumber) { result in
        
            if result.isSuccess {
                self.photoFeeds = isFreshQuery ? [] : self.photoFeeds
                self.handleSuccessfullySearchResponse(result.value)
            } else {
                self.delegate?.showError((result.error ?? NSError.genericError()).localizedDescription)
            }
        }
    }

    private func handleSuccessfullySearchResponse(_ result: PhotosModel?) {
        
        if let photos = result?.photos, !photos.isEmpty {
            self.photoFeeds.append(contentsOf: photos)
        }
        
        hasMoreData = !(result?.photos?.isEmpty ?? true)
        pageNumber = hasMoreData ? pageNumber + 1 : pageNumber
        isLoading = false
        updateUI()
        searchDataBase.saveRecentlySearchImageQuery(lastSearchQuery ?? "")
    }
    
    private func updateUI() {
        DispatchQueue.main.async {
            if self.photoFeeds.isEmpty {
                self.delegate?.showEmptySearchResultView(with: ErrorMessages.emptySearchMessage)
            } else {
                self.delegate?.hideEmptySearchResultView()
            }
            
            self.delegate?.refreshView()
        }
    }
    
    private func isValidSearch(_ text: String) -> Bool {
        return !(text.count >= 100)
    }
    
    private func resetPaginationData() {
        pageNumber = 1
        hasMoreData = true
        isLoading = false
    }
}

extension PhotoFeedsViewModel: PhotoFeedsRouterToViewModelDelegate {
    
    func searchLandingVC(_ vc: SearchLandingVC, didSelectSearchQuery text: String) {
        
        if isValidSearch(text) {
            perFormFreshSearchWithText(text)
        } else {
            delegate?.showError(ErrorMessages.invalidSearchQueryErrorMsg)
        }
    }
    
    func searchBarDidEndEditing(with text: String) {
        guard let vc = delegate?.viewController else { return }
        router.showSearchlandingVC(in: vc)
    }
}
