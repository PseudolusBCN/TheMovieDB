//
//  MovieCollectionViewCell.swift
//  TheMovieDB
//
//  Created by Miquel Masip on 23/02/2019.
//  Copyright © 2019 Miquel Masip. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!

    // MARK: - Init
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
