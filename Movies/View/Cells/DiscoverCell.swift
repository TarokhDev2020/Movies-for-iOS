//
//  DiscoveryCell.swift
//  Movies
//
//  Created by Tarokh on 9/6/20.
//  Copyright © 2020 Tarokh. All rights reserved.
//

import UIKit
import Kingfisher

class DiscoverCell: UICollectionViewCell {
    
    //MARK: - @IBOutlets
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var title: UILabel!
    
    //MARK: - Variables
    fileprivate let posterURL = "https://image.tmdb.org/t/p/w500"
    
    func configureCell(discover: DiscoverResult) {
        let poster = URL(string: posterURL + discover.poster_path!)
        posterImageView.kf.setImage(with: poster!)
        title.text = discover.title
    }
    
    
}
