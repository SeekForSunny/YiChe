//
//  YCProfileHeaderView.swift
//  qichehui
//
//  Created by SMART on 2019/12/5.
//  Copyright © 2019 SMART. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class YCProfileHeaderView: UIView {

    // view累计高度
    var viewH:CGFloat = 0
    
    var userInfo:YCUserInfo?
    var modules:[YCProfileModule]?
    var memberStatusInfo:YCProfileMemberStatusInfo?
    var tagModules:[YCProfileTagModel]?
    var orderModules:[YCProfileOrderModel]?
    
    var carServiceModels:[YCProfileCarServiceModel]?
    var carCoinModels:[YCProfileCarCoinModel]?
    
    // 顶部View
    lazy var topView:YCProfileTopView = { return YCProfileTopView() }()
    
    // 添加爱车
    lazy var carView:YCCarView = { return YCCarView() }()
    
    // 行车服务
    lazy var carServiceView:YCCarServiceView = { return YCCarServiceView() }()
    
    // 车币商城
    lazy var carCoinView:YCCarCoinView = { YCCarCoinView() }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI(){
        backgroundColor = UIColor.white
        
        addSubview(topView)
        
        addSubview(carView)
        
        addSubview(carServiceView)
        
        addSubview(carCoinView)
    }
    
    func setUserInfo(){
        topView.userInfo = userInfo
    }
    
    func bindData(){
         viewH = 0
        
        topView.userInfo = userInfo
        topView.modules = modules
        topView.memberStatusInfo = memberStatusInfo
        topView.tagModules = tagModules
        topView.orderModules = orderModules
        carServiceView.carServiceModels = carServiceModels
        carCoinView.models = carCoinModels
        
        topView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(topView.viewH)
        }
        viewH += topView.viewH
        
        carView.snp.makeConstraints { (make) in
            make.top.equalTo(topView.snp_bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(carView.viewH)
        }
        viewH += carView.viewH
        
        carServiceView.snp.makeConstraints { (make) in
            make.top.equalTo(carView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(carServiceView.viewH)
        }
        viewH += carServiceView.viewH
        
        carCoinView.snp.makeConstraints { (make) in
            make.top.equalTo(carServiceView.snp_bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(carCoinView.viewH)
        }
        viewH += carCoinView.viewH
    }
    
}
