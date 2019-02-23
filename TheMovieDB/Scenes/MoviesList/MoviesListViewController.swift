//
//  MoviesListViewController.swift
//  TheMovieDB
//
//  Created by Miquel Masip on 23/02/2019.
//  Copyright © 2019 Miquel Masip. All rights reserved.
//

import UIKit
import MagazineLayout

class MoviesListViewController: UIViewController, InterfaceMoviesListViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var presenter: InterfaceMoviesListPresenter?
    
    // MARK: - Init
    init() {
        super.init(nibName: "MoviesListViewController", bundle: nil)
        
        navigationItem.title = "TheMovieDB"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.setupCollectionView(collectionView, viewController: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if (presenter?.itemsForSection(collectionView, section: 0))! > 0 {
            collectionView.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

extension MoviesListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (presenter?.itemsForSection(collectionView, section: section))!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = presenter?.collectionViewCell(collectionView, indexPath: indexPath) {
            return cell as! UICollectionViewCell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //*** CONSTRASTAR CURRENT PAGE CON TOTAL PAGES PARA ACTUALIZAR DATOS
        
//        if PlacesManager.sharedInstance().nextPageToken.count > 0 {
//            if indexPath.row == (presenter?.itemsForSection(placesCollectionView, section: indexPath.section))! - 1 {
//                presenter?.downloadData()
//            }
//        }
    }
}

extension MoviesListViewController: UICollectionViewDelegateMagazineLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeModeForItemAt indexPath: IndexPath) -> MagazineLayoutItemSizeMode {
        return (presenter?.collectionViewLayoutItemSizeMode())!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, visibilityModeForHeaderInSectionAtIndex index: Int) -> MagazineLayoutHeaderVisibilityMode {
        return (presenter?.collectionViewLayoutHeaderVisibilityMode())!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, visibilityModeForBackgroundInSectionAtIndex index: Int) -> MagazineLayoutBackgroundVisibilityMode {
        return (presenter?.collectionViewLayoutBackgroundVisibilityMode())!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, horizontalSpacingForItemsInSectionAtIndex index: Int) -> CGFloat {
        return (presenter?.collectionViewLayoutHorizontalSpacing())!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, verticalSpacingForElementsInSectionAtIndex index: Int) -> CGFloat {
        return (presenter?.collectionViewLayoutVerticalSpacing())!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetsForItemsInSectionAtIndex index: Int) -> UIEdgeInsets {
        return (presenter?.collectionViewLayoutInsets())!
    }
}

extension MoviesListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}

extension MoviesListViewController: InterfaceMoviesListPresenterOutput {
}
