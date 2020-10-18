//
//  UIImageHelper.swift
//  Movies
//
//  Created by Tarokh on 9/6/20.
//  Copyright © 2020 Tarokh. All rights reserved.
//

import UIKit

extension UIImage {

    convenience init?(withContentsOfUrl url: URL) throws {
        let imageData = try Data(contentsOf: url)
    
        self.init(data: imageData)
    }

}
