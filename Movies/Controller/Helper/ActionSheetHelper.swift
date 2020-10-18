//
//  ActionSheetHelper.swift
//  Movies
//
//  Created by Tarokh on 9/7/20.
//  Copyright © 2020 Tarokh. All rights reserved.
//

import UIKit

extension DiscoverViewController {
    
    func showSeet(title: String, message: String, buttonTitle: String, completion: @escaping() -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: { (action) in
            completion()
        }))
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        cancel.setValue(UIColor.red, forKey: "titleTextColor")
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension FavoriteViewController {
    
    func showSeet(title: String, message: String, buttonTitle: String, completion: @escaping() -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let delete = UIAlertAction(title: buttonTitle, style: .default) { (action) in
            completion()
        }
        delete.setValue(UIColor.red, forKey: "titleTextColor")
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(delete)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
}
