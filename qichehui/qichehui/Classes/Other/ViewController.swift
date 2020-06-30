//
//  ViewController.swift
//  qichehui
//
//  Created by SMART on 2020/1/22.
//  Copyright © 2020 SMART. All rights reserved.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {
    
    private lazy var forwardBtn:UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 50
        self.view.addSubview(btn)
        btn.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 100, height: 100))
        }
        btn.addTarget(self, action: #selector(forward), for: UIControl.Event.touchUpInside)
        return btn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        forwardBtn.backgroundColor = UIColor.randomColor()
        view.backgroundColor = UIColor.white
        
        ImageCache.default.calculateDiskCacheSize { (size) in
            print("disk size：",size/1024/1024)
        }
        ImageCache.default.clearMemoryCache()
    }
    
    @objc
    func forward(){
        UIApplication.shared.keyWindow?.rootViewController =  YCTabBarController()
    }
    
}
