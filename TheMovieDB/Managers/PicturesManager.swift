//
//  PicturesManager.swift
//  TheMovieDB
//
//  Created by Miquel Masip on 23/02/2019.
//  Copyright © 2019 Miquel Masip. All rights reserved.
//

import UIKit

class PicturesManager: NSObject {
    private static var instance: PicturesManager?
    
    private var pictures: [UIImage?] = []

    // MARK: - Singleton
    class func sharedInstance() -> PicturesManager {
        guard let currentInstance = instance else {
            instance = PicturesManager()
            return instance!
        }
        return currentInstance
    }
    
    class func clearInstance() {
        instance = nil
    }
    
    // MARK: - Init
    override init() {
        super.init()
    }

    // MARK: - Public methods
    func removeAllPictures() {
        pictures = []
    }

    func initPicturesList(_ items: Int) {
        pictures.append(contentsOf: [UIImage?](repeating: nil, count: items))
    }
    
    func updatePicture(_ picture: UIImage, index: NSInteger) {
        do {
            try! pictures[index] = picture
        } catch {
            print("Unexpected error updating picture")
        }
    }
    
    func picture(_ index: NSInteger) -> UIImage? {
        return pictures[index]
    }
}
