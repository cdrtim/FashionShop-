//
//  ListImages.swift
//  FashionShopL
//
//  Created by Pham Ngoc Hai on 12/20/16.
//  Copyright © 2016 pnh. All rights reserved.
//

import UIKit

class ListImages: UIViewController {

    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var nameShop: UILabel!
    @IBOutlet weak var detailShop: UITextView!
    var item : item!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameShop.text = item.name
        detailShop.text = item.content
        imgProfile.image = UIImage(named: item.nameImages[0]+".jpg")
        imgProfile.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(ListImages.tapImg))
        imgProfile.addGestureRecognizer(tap)
    }
    func tapImg()
    {
        pushView(0)
    }
    func pushView(_ index: Int)
    {
        let listView = self.storyboard?.instantiateViewController(withIdentifier: "ViewScroll") as? Scroll_View
        listView?.pageImages = item.nameImages
        listView?.currentPage = index
        self.navigationController?.pushViewController(listView!, animated: true)
    }
//    delegate uicollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return item.nameImages.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAtIndexPath indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CellItem
        cell.kCellWidth = 60
        cell.addSubviews(false)
        cell.imageView.image = UIImage(named: item.nameImages[indexPath.item]+".jpg")
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: IndexPath) {
        pushView(indexPath.item)
        
    }
}
