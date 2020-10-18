//
//  DiscoverViewController.swift
//  Movies
//
//  Created by Tarokh on 9/5/20.
//  Copyright © 2020 Tarokh. All rights reserved.
//

import UIKit
import Kingfisher
import JGProgressHUD
import CoreData
import Loaf

class DiscoverViewController: UIViewController {
    
    //MARK: - @IBOutlets
    @IBOutlet var discoverCollectionView: UICollectionView!
    private let discoverViewModel = DiscoverViewModel()
    private var favoriteItems: [NSManagedObject] = []
    private var newFavoriteItems: NSManagedObject?
    
    
    //MARK: - Variables
    fileprivate let posterURL = "https://image.tmdb.org/t/p/w500"
    let popularViewModel = PopularViewModel()
    var hud: JGProgressHUD?
    
    
    //MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        discoverCollectionView.backgroundColor = .black
        discoverCollectionView.register(UINib(nibName: "DiscoverCell", bundle: nil), forCellWithReuseIdentifier: "discoverCell")
        discoverCollectionView.delegate = self
        discoverCollectionView.dataSource = self
        discoverCollectionView.isHidden = true
        setCollectionLayout()
        
        hud = JGProgressHUD(style: .dark)
        hud?.indicatorView = JGProgressHUDIndeterminateIndicatorView()
        hud?.show(in: view, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.title = "Discover"
        getDiscoverMovies()
    }
    
    //MARK: - Functions
    private func getDiscoverMovies() {
        discoverViewModel.getDiscoverMovie { (state) in
            switch state {
            case .success:
                DispatchQueue.main.async {
                    self.hud?.dismiss()
                    self.discoverCollectionView.isHidden = false
                    self.discoverCollectionView.reloadData()
                }
            case .failure:
                print("Failure")
            }
        }
    }
    
    func setCollectionLayout() {
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top:0,left:0,bottom:0,right:0)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.size.width/2 - 1, height: 300)
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        discoverCollectionView.collectionViewLayout = layout
    }
    
    private func save(title: String, poster: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Movie", in: managedContext)
        let movies = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        movies.setValue(title, forKey: "title")
        movies.setValue(poster, forKey: "poster")
        
        favoriteItems.append(movies)
        do {
            try managedContext.save()
            DispatchQueue.main.async {
                Loaf("\(title) has saved!", state: .success, location: .bottom, presentingDirection: .vertical, dismissingDirection: .vertical, sender: self).show()
            }
        }
        catch let error as NSError {
            print(error)
        }
    }
    
}


//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension DiscoverViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return discoverViewModel.discoverItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "discoverCell", for: indexPath) as! DiscoverCell
        let discover = discoverViewModel.discoverItems[indexPath.row]
        cell.posterImageView.layer.cornerRadius = 5.0
        cell.posterImageView.layer.masksToBounds = true
        cell.configureCell(discover: discover)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let discover = discoverViewModel.discoverItems[indexPath.row]
        let title = discover.title
        self.showSeet(title: title!, message: "Do you want to add this in your favorite?", buttonTitle: "Save") {
            self.save(title: title!, poster: discover.poster_path!)
        }
    }

}
