//
//  FavoriteCell.swift
//  Movies
//
//  Created by Tarokh on 9/7/20.
//  Copyright © 2020 Tarokh. All rights reserved.
//

import UIKit
import CoreData
import Kingfisher

class FavoriteCell: UICollectionViewCell {
    
    //MARK: - @IBOutlets
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var title: UILabel!
    
    
    
    //MARK: - Variables
    fileprivate let posterURL = "https://image.tmdb.org/t/p/w500"
    
    func configureCell(favorite: NSManagedObject) {
        let posterString = favorite.value(forKey: "poster") as! String
        let poster = URL(string: posterURL + posterString)
        posterImageView.kf.setImage(with: poster!)
        title.text = favorite.value(forKey: "title") as? String
    }
    
}
