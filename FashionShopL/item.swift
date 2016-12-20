//
//  item.swift
//  FashionShopL
//
//  Created by Pham Ngoc Hai on 12/20/16.
//  Copyright © 2016 pnh. All rights reserved.
//

import UIKit

class item: NSObject {
    var name: String?
    var content: String?
    var nameImages: [String] = []
    var price: String?
    init(name: String, content: String, nameImages: [String], price: String)
    {
        self.name = name
        self.content = content
        self.nameImages = nameImages
        self.price = price
    }

}
