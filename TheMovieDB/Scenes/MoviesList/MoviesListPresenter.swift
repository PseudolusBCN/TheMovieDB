//
//  MoviesListPresenter.swift
//  TheMovieDB
//
//  Created by Miquel Masip on 23/02/2019.
//  Copyright © 2019 Miquel Masip. All rights reserved.
//

import UIKit
import MagazineLayout

class MoviesListPresenter: InterfaceMoviesListPresenter {
    var router: InterfaceMoviesListRouter?
    var interactor: InterfaceMoviesListInteractor?
    weak var view: InterfaceMoviesListViewController?

    unowned var delegate: InterfaceMoviesListPresenterOutput
    
    // MARK: - Init
    init(delegate: InterfaceMoviesListPresenterOutput) {
        self.delegate = delegate
    }
    
    // MARK: - Public methods
    func setupCollectionView(_ collectionView: UICollectionView, viewController: UIViewController) {
        let nib = UINib(nibName: "MovieCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: movieCellIdentifier())
        
        collectionView.collectionViewLayout = MagazineLayout()
        collectionView.dataSource = viewController as? UICollectionViewDataSource
        collectionView.delegate = viewController as? UICollectionViewDelegate
    }
    
    func collectionViewCell(_ collectionView: UICollectionView, indexPath: IndexPath) -> Any {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: movieCellIdentifier(), for: indexPath) as? MovieCollectionViewCell {
            let movie = interactor?.movie(indexPath.row)
            cell.posterImage.image = UIImage.emptyImage(with: cell.posterImage.bounds.size)
            cell.titleLabel.text = movie?.title
            cell.releaseLabel.text = interactor?.movieDate(indexPath.row)
            cell.overviewLabel.text = movie?.overview

            let picturesManager = PicturesManager.sharedInstance()
            if let picture = picturesManager.picture(indexPath.row) {
                cell.posterImage.image = picture
                cell.setNeedsLayout()
            } else {
                interactor?.movieImage(indexPath.row, completion: { (image) in
                    picturesManager.updatePicture(image, index: indexPath.row)
                    cell.posterImage.image = image
                    cell.setNeedsLayout()
                })

            }

            return cell
        }
        
        return UITableViewCell()
    }
    
    func itemsForSection(_ collectionView: UICollectionView, section: Int) -> Int {
        return (interactor?.numberOfMovies())!
    }

    func collectionViewLayoutItemSizeMode() -> MagazineLayoutItemSizeMode {
        return MagazineLayoutItemSizeMode(widthMode: .fullWidth(respectsHorizontalInsets: true), heightMode: .dynamic)
    }

    func collectionViewLayoutHeaderVisibilityMode() -> MagazineLayoutHeaderVisibilityMode {
        return .hidden
    }

    func collectionViewLayoutBackgroundVisibilityMode() -> MagazineLayoutBackgroundVisibilityMode {
        return .hidden
    }
    
    func collectionViewLayoutHorizontalSpacing() -> CGFloat {
        return 0.0
    }
    
    func collectionViewLayoutVerticalSpacing() -> CGFloat {
        return 0.0
    }
    
    func collectionViewLayoutInsets() -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    func moviesPending() -> Bool {
        return interactor?.moviesPending() ?? false
    }

    func firstRequest() -> Bool {
        return interactor?.firstRequest() ?? false
    }

    func downloadData(_ searchText: String) {
        interactor?.downloadData(searchText)
    }

    // MARK: - Private methods
    private func movieCellIdentifier() -> String {
        return "MovieCollectionCell"
    }
}

extension MoviesListPresenter: InterfaceMoviesListInteractorOutput {
    func dataDownloaded() {
        delegate.dataDownloaded()
    }
    
    func dataFailure() {
    }
}
