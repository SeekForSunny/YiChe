//
//  YCTabBarController.swift
//  qichehui
//
//  Created by SMART on 2019/12/2.
//  Copyright © 2019 SMART. All rights reserved.
//

import UIKit
import RTRootNavigationController

class YCTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setup()
        
    }
    func setup(){
        
        view.backgroundColor = UIColor.white
        
        // 添加子控制器
        addChildren()
        
        // 默认选中
        selectedIndex = 0
    }
    
    func addChildren(){
        //首页
        let homeVc = YCHomeViewController()
        addChild(homeVc, title: "首页", imageName: "ic_tabbar_0")
        // 论坛
        let forumVc = YCForumViewController()
        addChild(forumVc, title: "论坛", imageName: "ic_tabbar_1")
        // 新车
        let newCarVc = YCNewCarViewController()
        addChild(newCarVc, title: "新车", imageName: "TOOLBAR_esc")
        // 二手车
        let usedCarVc = YCUsedCarViewController()
        addChild(usedCarVc, title: "二手车", imageName: "ToolBar_xc")
        // 我的
        let profileVc = YCProfileViewController()
        addChild(profileVc, title: "我的", imageName: "ToolBar_profile")
    }
    
    func addChild(_ childController: UIViewController,title:String,imageName:String) {
        
        let navigationVc = YCNavigationController.init(rootViewController: childController)
        addChild(navigationVc)
        
        childController.tabBarItem.title = title
        
        let selectedAttributes = [NSAttributedString.Key.font:FONT_SIZE_13,NSAttributedString.Key.foregroundColor:THEME_COLOR]
        childController.tabBarItem.setTitleTextAttributes(selectedAttributes, for: UIControl.State.selected)
        
        let unselectedAttributes = [NSAttributedString.Key.font:FONT_SIZE_13,NSAttributedString.Key.foregroundColor:UIColor.darkGray]
        childController.tabBarItem.setTitleTextAttributes(unselectedAttributes, for: UIControl.State.normal)
        
        childController.tabBarItem.image = UIImage(named: imageName+"_normal")
        childController.tabBarItem.selectedImage = UIImage(named: imageName+"_press")
        if #available(iOS 10.0, *) {
            tabBar.tintColor = THEME_COLOR
            tabBar.unselectedItemTintColor = UIColor.darkGray
        }
    }
    
}
