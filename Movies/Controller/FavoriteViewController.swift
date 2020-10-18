//
//  FavoriteViewController.swift
//  Movies
//
//  Created by Tarokh on 9/5/20.
//  Copyright © 2020 Tarokh. All rights reserved.
//

import UIKit
import CoreData
import Kingfisher
import DZNEmptyDataSet

class FavoriteViewController: UIViewController {

    //MARK: - @IBOutlets
    @IBOutlet var favoriteCollectionView: UICollectionView!
    
    
    //MARK: - Variables
    private var favoriteItems = [NSManagedObject]()
    var managedContext: NSManagedObjectContext?
    fileprivate let posterURL = "https://image.tmdb.org/t/p/w500"
    
    //MARK: - Views
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .black
        favoriteCollectionView.register(UINib(nibName: "FavoriteCell", bundle: nil), forCellWithReuseIdentifier: "favoriteCell")
        favoriteCollectionView.delegate = self
        
        favoriteCollectionView.dataSource = self
        setCollectionLayout()
        
        favoriteCollectionView.emptyDataSetDelegate = self
        favoriteCollectionView.emptyDataSetSource = self
        
        favoriteCollectionView.backgroundColor = .black
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.title = "Favorites"
        getFavoriteItems()
    }
    
    //MARK: - Functions
    private func getFavoriteItems() {
        favoriteItems = []
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Movie")
        
        do {
            let movies = try managedContext?.fetch(fetchRequest)
            for data in movies! {
                favoriteItems.append(data)
                DispatchQueue.main.async {
                    self.favoriteCollectionView.reloadData()
                }
            }
        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func setCollectionLayout() {
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top:0,left:0,bottom:0,right:0)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.size.width/2 - 1, height: 300)
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        favoriteCollectionView.collectionViewLayout = layout
    }
    
    private func delete(index: IndexPath) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        context.delete(favoriteItems[index.row])
        favoriteItems.remove(at: index.row)
        
        do {
            try context.save()
            self.favoriteCollectionView.deleteItems(at: [index])
            self.favoriteCollectionView.reloadData()
        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension FavoriteViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favoriteCell", for: indexPath) as! FavoriteCell
        let favorite = favoriteItems[indexPath.row]
        
        cell.posterImageView.layer.cornerRadius = 5.0
        cell.configureCell(favorite: favorite)
        
        cell.posterImageView.layer.masksToBounds = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let favorite = favoriteItems[indexPath.row]
        let title = favorite.value(forKey: "title") as! String
        showSeet(title: title, message: "Do you want to remove this movie", buttonTitle: "Delete") {
            self.delete(index: indexPath)
        }
    }
    
}

//MARK: - DZNEmptyDataSetDelegate, DZNEmptyDataSetSource
extension FavoriteViewController: DZNEmptyDataSetDelegate, DZNEmptyDataSetSource {
    
    func title(forEmptyDataSet scrollView: UIScrollView?) -> NSAttributedString? {
        let text = "Add a movie to your favorite to see the list!"

        let attributes = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18.0),
            NSAttributedString.Key.foregroundColor: UIColor.darkGray
        ]

        return NSAttributedString(string: text, attributes: attributes)
    }
    
}
