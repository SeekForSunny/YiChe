//
//  YCNavigationController.swift
//  qichehui
//
//  Created by SMART on 2019/12/2.
//  Copyright © 2019 SMART. All rights reserved.
//

import UIKit
import RTRootNavigationController
class YCNavigationController: RTRootNavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if children.count >= 1{ viewController.hidesBottomBarWhenPushed = true}
        super.pushViewController(viewController, animated: animated);
    }

}
