
//
//  Database.swift
//  PhotoFeeds
//
//  Created by Gulshan on 06/06/20.
//  Copyright © 2020 Gulshan. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import SDWebImage
import ImageSlideshow

/*
 This class is responsible for showing images based on the query entered by the user.
 */
class PhotoFeedsViewController: UIViewController {
    
    @IBOutlet private weak var collectionView               : UICollectionView!
    @IBOutlet private weak var emptySearchView              : UIView!
    @IBOutlet private weak var emptySearchDescriptionLabel  : UILabel!
    @IBOutlet private weak var searchBar                    : UISearchBar!
    private var slideshowTransitioningDelegate              : ZoomAnimatedTransitioningDelegate?
    
    private weak var loadingView    : PaganationReusableView?
    private var viewModel           : PhotoFeedsViewModel!
    
    //MARK:- Overriden method(s)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = PhotoFeedsViewModel(delegate: self)
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        //addSearchBar()
    }
    
    
    //MARK:- Private method(s)
    
    private func setupCollectionView() {
        
        collectionView.register(UINib(nibName:"PhotoFeedViewCell", bundle: .main), forCellWithReuseIdentifier: "PhotoFeedViewCell")
        
        let loadingReusableNib = UINib(nibName: "PaganationReusableView", bundle: nil)
        collectionView.register(loadingReusableNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "PaganationReusableView")
    }
}

extension PhotoFeedsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel != nil ? viewModel.photoFeeds.count : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        if viewModel == nil {
            return CGSize.zero
        }
        return viewModel.isLoading ? CGSize.zero : CGSize(width: collectionView.bounds.size.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width / 2 
        return CGSize(width: width, height: width * 3/4)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionFooter {
            let aFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "PaganationReusableView", for: indexPath) as! PaganationReusableView
            loadingView = aFooterView
            loadingView?.stopAnimating()
            return aFooterView
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoFeedViewCell", for: indexPath) as! PhotoFeedViewCell
        cell.updateCell(viewModel.photoFeeds[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter && viewModel != nil && viewModel.isLoading {
            self.loadingView?.starAnimating()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            self.loadingView?.stopAnimating()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let lastRowIndex = collectionView.numberOfItems(inSection: 0) - 1
        if indexPath.row == lastRowIndex {
            viewModel.loadMoreImages(for: searchBar.text ?? "")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.collectionViewDidSelectItem(at: indexPath)
    }
}


extension PhotoFeedsViewController: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        viewModel.searchBarDidEndEditing(with: searchBar.text ?? "")
        return false
    }
}


extension PhotoFeedsViewController: PhotoFeedsViewModelDelegate {
    
    var viewController: UIViewController {
        return self
    }
    
    func refreshView() {
        collectionView.reloadData()
    }
    
    func showError(_ errorMessage: String) {
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    func showEmptySearchResultView(with message: String) {
        emptySearchView.isHidden = false
        emptySearchDescriptionLabel.text = message
    }
    
    func hideEmptySearchResultView() {
        emptySearchView.isHidden = true
    }
}
