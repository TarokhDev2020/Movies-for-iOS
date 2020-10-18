//
//  UpcomingCell.swift
//  Movies
//
//  Created by Tarokh on 9/5/20.
//  Copyright © 2020 Tarokh. All rights reserved.
//

import UIKit
import Kingfisher

class UpcomingCell: UITableViewCell {
    
    //MARK: - @IBOutlets
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var releaseLabel: UILabel!
    @IBOutlet var overviewLabel: UILabel!
    
    
    //MARK: - Variables
    fileprivate let posterURL = "https://image.tmdb.org/t/p/w500"
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.selectionStyle = .none
        posterImageView.layer.cornerRadius = 5.0
        posterImageView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(upcoming: UpcomingResult) {
        let poster = URL(string: posterURL + upcoming.poster_path)
        posterImageView.kf.setImage(with: poster!)
        titleLabel.text = upcoming.title
        releaseLabel.text = upcoming.release_date
        overviewLabel.text = upcoming.overview
    }

}
