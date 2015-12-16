//
//  KDInfiniteView.swift
//  KDInfiniteView
//
//  Created by Kingiol on 15/12/16.
//  Copyright © 2015年 Kingiol. All rights reserved.
//

import UIKit

@objc public protocol KDInfiniteViewDataSource : NSObjectProtocol {
    
    optional func numberOfPagesInKDInfiniteView(infiniteView: KDInfiniteView) -> Int // Default is 1 if not implemented
    
    func kdInfiniteView(kdInfiniteView: KDInfiniteView, cellForPage page: Int) -> KDInfiniteViewCell
    
}

@objc public protocol KDInfiniteViewDelegate : NSObjectProtocol {
    
    optional func kdInfiniteView(kdInfiniteView: KDInfiniteView, didSelectAtPage page: Int)
    optional func kdInfiniteView(kdInfiniteView: KDInfiniteView, didScrollFromPage fromPage: Int, toPage: Int)
    
}

public class KDInfiniteViewCell: UIView {
    
    public var kdInfiniteViewCellIdentifier: String!
    
}

public class KDInfiniteView: UIView {
    
    private let numberOfVisiblePages = 3
    
    weak public var dataSource: KDInfiniteViewDataSource?
    weak public var delegate: KDInfiniteViewDelegate?
    
    public var numberOfPages = 1
    public var autoScrollInterval: NSTimeInterval = 5
    var visiblePages = [KDInfiniteViewCell]()
    var resueablePages = [KDInfiniteViewCell]()
    
    lazy var scrollView: UIScrollView = {
        let s = UIScrollView()
        s.pagingEnabled = true
        s.scrollsToTop = false
        s.showsHorizontalScrollIndicator = false
        s.showsVerticalScrollIndicator = false
        return s
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }

    public func registerClass(cellClass: AnyClass?, forCellReuseIdentifier identifier: String) {
        
    }
    
    public func reloadData() {
        
    }
    
    public override func didMoveToSuperview() {
        super.didMoveToSuperview()
        reloadData()
    }
    
    private func initialize() {
        autoScrollInterval = 5
        addSubview(scrollView)
        NSLayoutConstraint(item: scrollView, attribute: .Leading, relatedBy: .Equal, toItem: self, attribute: .Leading, multiplier: 1.0, constant: 0.0).active = true
        NSLayoutConstraint(item: scrollView, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1.0, constant: 0.0).active = true
        NSLayoutConstraint(item: scrollView, attribute: .Trailing, relatedBy: .Equal, toItem: self, attribute: .Trailing, multiplier: 1.0, constant: 0.0).active = true
        NSLayoutConstraint(item: scrollView, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1.0, constant: 0.0).active = true
    }
    
}
