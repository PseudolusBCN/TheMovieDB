//
//  MoviesListInterfaces.swift
//  TheMovieDB
//
//  Created by Miquel Masip on 23/02/2019.
//  Copyright © 2019 Miquel Masip. All rights reserved.
//

import UIKit
import MagazineLayout

protocol InterfaceMoviesListViewController: class {
    var presenter: InterfaceMoviesListPresenter? { get set }
}

protocol InterfaceMoviesListPresenter: class {
    var router: InterfaceMoviesListRouter? { get set }
    var interactor: InterfaceMoviesListInteractor? { get set }
    var view: InterfaceMoviesListViewController? { get set }

    func setupCollectionView(_ collectionView: UICollectionView, viewController: UIViewController)
    func collectionViewCell(_ collectionView: UICollectionView, indexPath: IndexPath) -> Any
    func itemsForSection(_ collectionView: UICollectionView, section: Int) -> Int

    func collectionViewLayoutItemSizeMode() -> MagazineLayoutItemSizeMode
    func collectionViewLayoutHeaderVisibilityMode() -> MagazineLayoutHeaderVisibilityMode
    func collectionViewLayoutBackgroundVisibilityMode() -> MagazineLayoutBackgroundVisibilityMode
    func collectionViewLayoutHorizontalSpacing() -> CGFloat
    func collectionViewLayoutVerticalSpacing() -> CGFloat
    func collectionViewLayoutInsets() -> UIEdgeInsets
    
    func moviesPending() -> Bool

    func downloadData()
}

protocol InterfaceMoviesListPresenterOutput: class {
    func dataDownloaded()
}

protocol InterfaceMoviesListInteractor: class {
    var presenter: InterfaceMoviesListPresenter? { get set }
    
    func numberOfMovies() -> Int
    func movie(_ index: NSInteger) -> APIResult
    func movieDate(_ index: NSInteger) -> String
    func movieImage(_ index: NSInteger, completion: @escaping(_ responseData: UIImage) -> Void)

    func moviesPending() -> Bool

    func downloadData()
}

protocol InterfaceMoviesListInteractorOutput: class {
    func dataDownloaded()
    func dataFailure()
}

protocol InterfaceMoviesListRouter: class {
    var presenter: InterfaceMoviesListPresenter? { get set }
}
