//
//  ViewController.swift
//  Movies
//
//  Created by Tarokh on 9/5/20.
//  Copyright © 2020 Tarokh. All rights reserved.
//

import UIKit
import Kingfisher
import JGProgressHUD

class MovieViewController: UIViewController {
    
    //MARK: - @IBOutlets
    @IBOutlet var movieSegment: UISegmentedControl!
    @IBOutlet var popularView: UIView!
    @IBOutlet var upcomingView: UIView!
    @IBOutlet var topRatedView: UIView!
    @IBOutlet var popularTableView: UITableView!
    @IBOutlet var upcomingTableView: UITableView!
    @IBOutlet var topRatedTableView: UITableView!
    
    
    
    //MARK: - Variables
    fileprivate let popularViewModel = PopularViewModel()
    fileprivate let upcomingViewModel = UpcomingViewModel()
    fileprivate let topRatedViewModel = TopRatedViewModel()
    var hud: JGProgressHUD?
    
    
    //MARK: - Views
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .black
        UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.white], for: .normal)
        
        popularView.isHidden = false
        popularView.backgroundColor = .black
        upcomingView.isHidden = true
        upcomingView.backgroundColor = .black
        topRatedView.isHidden = true
        topRatedView.backgroundColor = .black
        
        hud = JGProgressHUD(style: .dark)
        hud?.indicatorView = JGProgressHUDIndeterminateIndicatorView()
        hud?.show(in: self.view, animated: true)
        
        self.configureTableView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.title = "Popular"
        self.tabBarController?.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        getPopularData()
        getUpcomingData()
        getTopRatedData()
    }
    
    
    //MARK: - Functions
    @IBAction func segmentValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            popularView.isHidden = false
            upcomingView.isHidden = true
            topRatedView.isHidden = true
            self.tabBarController?.title = "Popular"
        case 1:
            popularView.isHidden = true
            upcomingView.isHidden = false
            topRatedView.isHidden = true
            self.tabBarController?.title = "Upcoming"
        case 2:
            popularView.isHidden = true
            upcomingView.isHidden = true
            topRatedView.isHidden = false
            self.tabBarController?.title = "Top Rated"
        default:
            popularView.isHidden = false
            upcomingView.isHidden = true
            topRatedView.isHidden = true
            self.tabBarController?.title = "Popular"
        }
    }
    
    private func getPopularData() {
        popularViewModel.getPopularMovies { (state) in
            switch state {
            case .success:
                DispatchQueue.main.async {
                    self.hud?.dismiss(animated: true)
                    self.popularTableView.isHidden = false
                    self.popularTableView.reloadData()
                }
            case .failure:
                print("Failure")
            }
        }
    }
    
    private func getUpcomingData() {
        upcomingViewModel.getUpcomingMovies { (state) in
            switch state {
            case .success:
                DispatchQueue.main.async {
                    self.hud?.dismiss(animated: true)
                    self.upcomingTableView.isHidden = false
                    self.upcomingTableView.reloadData()
                }
            case .failure:
                print("Failure")
            }
        }
    }
    
    private func getTopRatedData() {
        topRatedViewModel.getTopRatedMovies { (state) in
            switch state {
            case .success:
                DispatchQueue.main.async {
                    self.hud?.dismiss(animated: true)
                    self.topRatedTableView.isHidden = false
                    self.topRatedTableView.reloadData()
                }
            case .failure:
                print("Failure")
            }
        }
    }
    
    
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension MovieViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == popularTableView {
            return popularViewModel.popularItems.count
        }
        else if tableView == upcomingTableView {
            return upcomingViewModel.upcomingItems.count
        }
        else if tableView == topRatedTableView {
            return topRatedViewModel.topRatedItems.count
        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == popularTableView {
            let popularCell = popularTableView.dequeueReusableCell(withIdentifier: "popularCell") as! PopularCell
            popularCell.contentView.backgroundColor = .black
            let popular = popularViewModel.popularItems[indexPath.row]
            popularCell.configureCell(popular: popular)
            return popularCell
        }
        else if tableView == upcomingTableView {
            let upcomingCell = upcomingTableView.dequeueReusableCell(withIdentifier: "upcomingCell") as! UpcomingCell
            upcomingCell.contentView.backgroundColor = .black
            let upcoming = upcomingViewModel.upcomingItems[indexPath.row]
            upcomingCell.configureCell(upcoming: upcoming)
            return upcomingCell
        }
        else if tableView == topRatedTableView {
            let topRatedCell = topRatedTableView.dequeueReusableCell(withIdentifier: "topRatedCell") as! TopRatedCell
            topRatedCell.contentView.backgroundColor = .black
            let topRated = topRatedViewModel.topRatedItems[indexPath.row]
            topRatedCell.configureCell(topRated: topRated)
            return topRatedCell
        }
        else {
            return UITableViewCell()
        }
    }
    
}
