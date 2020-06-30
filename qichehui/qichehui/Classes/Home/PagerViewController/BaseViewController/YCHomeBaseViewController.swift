//
//  YCHomeBaseViewController.swift
//  qichehui
//
//  Created by SMART on 2019/12/30.
//  Copyright © 2019 SMART. All rights reserved.
//

import UIKit

protocol YCHomeSubScrollViewScrollDelegate:class {
    func subScrollViewDidScroll(_ scrollView: UIScrollView);
}

class YCHomeBaseViewController: UIViewController,UIScrollViewDelegate {
    weak var delegate:YCHomeSubScrollViewScrollDelegate?
    var scrollView:UIScrollView?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let scrollView = self.scrollView{
            scrollView.delegate = self
            scrollView.contentInset.bottom = NAVIGATION_BAR_HEIGHT + TAB_BAR_HEIGHT + 50
        }else{
            view.backgroundColor = UIColor.randomColor()
        }
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.subScrollViewDidScroll(scrollView)
    }
    
    
}

