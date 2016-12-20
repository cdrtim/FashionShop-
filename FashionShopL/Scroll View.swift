//
//  Scroll View.swift
//  FashionShopL
//
//  Created by Pham Ngoc Hai on 12/20/16.
//  Copyright © 2016 pnh. All rights reserved.
//

import UIKit

class Scroll_View: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var pageController: UIPageControl!
    var photos: [UIImageView] = []
    var pageImages: [String] =  []
    var frontScrollViews: [UIScrollView] = []
    var first = false
    var currentPage = 0
    
        override func viewDidLoad() {
        super.viewDidLoad()
            
        scrollView.isPagingEnabled = true
        pageController.currentPage = currentPage
        pageController.numberOfPages = pageImages.count
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        if (!first)
        {
        first = true
            let pagesScrollViewSize = scrollView.frame.size
            scrollView.contentSize = CGSize(width: pagesScrollViewSize.width * CGFloat(pageImages.count), height: 0)
            scrollView.contentOffset = CGPoint(x: CGFloat(currentPage) * scrollView.frame.size.width, y: 0)
            
            for i in 0 ..< pageImages.count
            {
                
                let imgView = UIImageView(image: UIImage(named:pageImages[i]+".jpg"))
                imgView.frame = CGRect(x: 0, y: 0, width: scrollView.frame.size.width, height: scrollView.frame.size.height)
                imgView.contentMode = .scaleAspectFit
                imgView.isUserInteractionEnabled = true
                imgView.isMultipleTouchEnabled = true
                let tap = UITapGestureRecognizer(target: self, action: #selector(Scroll_View.tapImg(_:)))
                tap.numberOfTapsRequired = 1
                imgView.addGestureRecognizer(tap)
                let doubleTap = UITapGestureRecognizer(target: self, action: #selector(Scroll_View.doubleTabImg(_:)))
                doubleTap.numberOfTapsRequired = 2
                imgView.addGestureRecognizer(doubleTap)
                tap.require(toFail: doubleTap)
                photos.append(imgView)
                let frontScrollView = UIScrollView(frame: CGRect( x: CGFloat(i) * scrollView.frame.size.width, y: 0, width: scrollView.frame.size.width, height: scrollView.frame.size.height))
                frontScrollView.minimumZoomScale = 1
                frontScrollView.maximumZoomScale = 2
                frontScrollView.delegate = self
                frontScrollView.contentSize = imgView.bounds.size
                frontScrollView.addSubview(imgView)
                frontScrollViews.append(frontScrollView)
                self.scrollView.addSubview(frontScrollView)
            }
            
        }
        
    }
    
    func tapImg(_ gesture: UITapGestureRecognizer)
    {
        let position = gesture.location(in: photos[pageController.currentPage])
        zoomRectForScale(frontScrollViews[pageController.currentPage].zoomScale * 1.5, center: position)
    }
    func doubleTabImg(_ gesture: UITapGestureRecognizer)
    {
        let position = gesture.location(in: photos[pageController.currentPage])
        zoomRectForScale(frontScrollViews[pageController.currentPage].zoomScale * 0.5, center: position)
    }
    func zoomRectForScale(_ scale: CGFloat, center: CGPoint)
    {
        var zoomRect = CGRect()
        let scrollViewSize = scrollView.bounds.size
        zoomRect.size.height = scrollViewSize.height / scale
        zoomRect.size.width = scrollViewSize.width / scale
        
        zoomRect.origin.x = center.x - (zoomRect.size.width / 2.0)
        zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0)
        frontScrollViews[pageController.currentPage] .zoom(to: zoomRect, animated: true)
    }
    //uiscrollview delegate
    func viewForZooming(in scrollView: UIScrollView) -> UIView?
    {
        return photos[pageController.currentPage]
    }
    
    @IBAction func onChange(_ sender: AnyObject) {
        scrollView.contentOffset = CGPoint(x: CGFloat(pageController.currentPage) * scrollView.frame.size.width, y: 0)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.size.width
        let page = Int(floor((self.scrollView.contentOffset.x * 2.0 + pageWidth) / (pageWidth * 2.0)))
        if (pageController.currentPage != page)
        {
            frontScrollViews[pageController.currentPage].zoomScale = 1
            pageController.currentPage = page
        }
    }

}

            
        
      
