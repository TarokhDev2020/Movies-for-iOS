//
//  TableViewHelper.swift
//  Movies
//
//  Created by Tarokh on 9/5/20.
//  Copyright © 2020 Tarokh. All rights reserved.
//

import Foundation
import UIKit

extension MovieViewController {
    
    func configureTableView() {
        popularTableView.isHidden = true
        popularTableView.backgroundColor = .black
        popularTableView.separatorColor = .white
        popularTableView.register(UINib(nibName: "PopularCell", bundle: nil), forCellReuseIdentifier: "popularCell")
        popularTableView.delegate = self
        popularTableView.dataSource = self
        
        upcomingTableView.isHidden = true
        upcomingTableView.backgroundColor = .black
        upcomingTableView.separatorColor = .white
        upcomingTableView.register(UINib(nibName: "UpcomingCell", bundle: nil), forCellReuseIdentifier: "upcomingCell")
        upcomingTableView.delegate = self
        upcomingTableView.dataSource = self
        
        topRatedTableView.isHidden = true
        topRatedTableView.backgroundColor = .black
        topRatedTableView.separatorColor = .white
        topRatedTableView.register(UINib(nibName: "TopRatedCell", bundle: nil), forCellReuseIdentifier: "topRatedCell")
        topRatedTableView.delegate = self
        topRatedTableView.dataSource = self
    }
    
}
