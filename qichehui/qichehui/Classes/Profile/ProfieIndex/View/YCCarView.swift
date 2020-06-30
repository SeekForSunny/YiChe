//
//  YCCardView.swift
//  qichehui
//
//  Created by SMART on 2019/12/4.
//  Copyright © 2019 SMART. All rights reserved.
//

import UIKit

class YCCarView: UIView {
    
    private let ADD_BTN_WIDTH = 130*APP_SCALE
    private let ADD_BTN_HEIGHT = 35*APP_SCALE
    
    var viewH:CGFloat = 0
    
    // 顶部分割线
    lazy var lineView:UIView = {
        let lineView = UIView()
        lineView.backgroundColor = BACK_GROUND_COLOR
        return lineView
    }()
    // 按钮
    lazy var addBtn:UIButton = {
        let btn = UIButton()
        btn.setTitle("+ 添加一辆爱车", for: UIControl.State.normal)
        btn.titleLabel?.font = FONT_SIZE_15
        btn.backgroundColor = UIColor.hexadecimalColor(hexadecimal: "#EDF2FF")
        btn.setTitleColor(UIColor.hexadecimalColor(hexadecimal: "#2E68FE"), for: UIControl.State.normal)
        return btn
    }()
    
    // 提示
    lazy var tipLabel:UILabel = {
        let label = UILabel()
        label.text = "可认证并点亮车主标识，免费查违章"
        label.textColor = UIColor.lightGray
        label.font = FONT_SIZE_11
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){

        // 顶部分割线
        addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(MARGIN_5)
        }
        viewH += MARGIN_5
        
        // 按钮
        addSubview(addBtn)
        addBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(lineView.snp_bottom).offset(MARGIN_20)
            make.size.equalTo(CGSize.init(width: ADD_BTN_WIDTH, height: ADD_BTN_HEIGHT))
        }
        addBtn.layer.cornerRadius = ADD_BTN_HEIGHT*0.5
        viewH += MARGIN_20 + ADD_BTN_HEIGHT
        
        //提示
        addSubview(tipLabel)
        tipLabel.sizeToFit()
        let tipLabelSize = tipLabel.frame.size
        tipLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(addBtn.snp_bottom).offset(MARGIN_10)
            make.height.equalTo(tipLabelSize.height)
        }
        backgroundColor = UIColor.white
        viewH += MARGIN_10 + tipLabelSize.height
        viewH += MARGIN_20
    }
}
