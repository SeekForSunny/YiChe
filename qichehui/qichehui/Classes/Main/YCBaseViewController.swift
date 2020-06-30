//
//  YCBaseViewController.swift
//  qichehui
//
//  Created by SMART on 2019/12/10.
//  Copyright © 2019 SMART. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class YCBaseViewController: ASViewController<ASDisplayNode> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.setBackgroundImage(UIImage.image(color: UIColor.white), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage.init()
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font:FONT_SIZE_15,NSAttributedString.Key.foregroundColor:UIColor.darkGray]
    }
    
    deinit {
        logger(message: "~~ deinit YCBaseViewController ~~")
    }
    
    override func rt_customBackItem(withTarget target: Any!, action: Selector!) -> UIBarButtonItem! {
        let button = UIButton(type: UIButton.ButtonType.custom);
        button.setImage(UIImage(named:"Nar_ico_back_black"), for: UIControl.State.normal);
        button.sizeToFit();
        button.addTarget(self, action: #selector(back), for: UIControl.Event.touchUpInside);
        return UIBarButtonItem.init(customView: button)
    }
    
    @objc
    func back() {
        rt_navigationController.popViewController(animated: true);
    }
    
}
