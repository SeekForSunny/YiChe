//
//  YCNewEnergyPriceReduceListView.swift
//  qichehui
//
//  Created by SMART on 2020/2/6.
//  Copyright © 2020 SMART. All rights reserved.
//  降价榜

import UIKit

class YCNewEnergyPriceReduceListView: UIView {
    var viewH:CGFloat = 0
    private lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.text = "降价榜"
        self.addSubview(label)
        label.font = BOLD_FONT_SIZE_18
        let labelH = BOLD_FONT_SIZE_18.lineHeight
        label.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(MARGIN_15)
            make.top.equalToSuperview().offset(MARGIN_15)
            make.height.equalTo(labelH)
        }
        self.viewH += labelH + MARGIN_20
        return label
    }()
    
    private var selectedIndex = 0
    private lazy var titles:[String] = [String]()
    private var optionMaxWidth:CGFloat = 0
    private lazy var sectionItems:[[YCNewEnergyPriceReduceListInfos]] = [[YCNewEnergyPriceReduceListInfos]]()
    private lazy var itemViewArr:[YCNewCarEnergyPerCarItemView] = {
        var views = [YCNewCarEnergyPerCarItemView]()
        for _ in 0..<3{ views.append(YCNewCarEnergyPerCarItemView()) }
        let itemH = 100*APP_SCALE
        for (index,view) in views.enumerated(){
            self.addSubview(view)
            view.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(self.viewH)
                make.left.right.equalToSuperview()
                make.height.equalTo(itemH)
            }
            self.viewH += itemH
        }
        return views
    }()
    
    private lazy var optionBtnArr:[UIButton] = [UIButton]()
    
    private lazy var showMoreBtn:UIButton = {
        let btn = UIButton()
        self.addSubview(btn)
        btn.setTitle("查看更多", for: UIControl.State.normal)
        btn.backgroundColor = UIColor.hexadecimalColor(hexadecimal: "#F5F5F5")
        btn.titleLabel?.font = FONT_SIZE_13
        btn.setTitleColor(UIColor.darkGray, for: UIControl.State.normal)
        btn.layer.cornerRadius = 8*APP_SCALE
        return btn
    }()
    
    func bindData(priceReduceList:[YCNewEnergyPriceReduceList]){
        
        priceReduceList.forEach { (item) in
            if let title = item.title{
                let title = title.replacingOccurrences(of: "以上", with: "")
                titles.append(title)
                let titleSize = title.size(font: FONT_SIZE_13, maxSize: CGSize(width: SCREEN_WIDTH, height: CGFloat(MAXFLOAT)))
                if titleSize.width > optionMaxWidth {
                    optionMaxWidth = titleSize.width
                }
            }
            
            if let list = item.list {
                sectionItems.append(list)
            }
            
        }
        
        setupOptions()
        setupListView()
        setupShowMore()
        
    }
    
    @objc
    func btnOnClick(sender:UIButton){
        if let index = optionBtnArr.firstIndex(of: sender){
            
            let btn = optionBtnArr[selectedIndex]
            btn.backgroundColor = UIColor.white
            selectedIndex = index
            let selectedBtn = optionBtnArr[selectedIndex]
            selectedBtn.backgroundColor = UIColor.hexadecimalColor(hexadecimal: "#EFFDFF")
            
            setupListView()
        }
    }
    
    func setupOptions(){
        let btnH = 30*APP_SCALE
        if optionBtnArr.count < titles.count{
            for _ in optionBtnArr.count ..< titles.count {
                let btn = UIButton()
                btn.titleLabel?.font = FONT_SIZE_13
                self.addSubview(btn)
                btn.layer.cornerRadius = btnH*0.5
                optionBtnArr.append(btn)
                btn.addTarget(self, action: #selector(btnOnClick), for: UIControl.Event.touchUpInside)
            }
        }else{
            if  titles.count < optionBtnArr.count {
                for index in titles.count ..< optionBtnArr.count{
                    let btn = optionBtnArr[index]
                    btn.isHidden = true
                }
            }
        }
        
        let col:CGFloat = 4
        let btnW = optionMaxWidth + MARGIN_5
        for (index,title) in titles.enumerated(){
            let btn = optionBtnArr[index]
            btn.setTitleColor(UIColor.darkGray, for: UIControl.State.normal)
            btn.setTitle(title, for: UIControl.State.normal)
            btn.snp.makeConstraints { (make) in
                make.top.equalTo(titleLabel.snp_bottom).offset(MARGIN_15 + CGFloat(index/Int(col))*(btnH+MARGIN_10))
                make.left.equalToSuperview().offset(MARGIN_15 + CGFloat(index%Int(col))*(btnW + MARGIN_5))
                make.height.equalTo(btnH)
                make.width.equalTo(btnW)
            }
        }
        let rows = ceil(CGFloat(titles.count)/CGFloat(col))
        self.viewH += CGFloat(rows) * btnH + CGFloat(rows-1)*MARGIN_10 + MARGIN_20
        
        let btn = optionBtnArr[0]
        btn.backgroundColor = UIColor.hexadecimalColor(hexadecimal: "#EFFDFF")
    }
    
    func setupListView(){
        let items = sectionItems[selectedIndex]
        
        for (index,view) in itemViewArr.enumerated() {
            let item = items[index]
            view.bindData(info:item,rank: index+1)
        }
    }
    
    func setupShowMore(){
        showMoreBtn.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(self.viewH)
            make.left.equalToSuperview().offset(MARGIN_15)
            make.right.equalToSuperview().offset(-MARGIN_15)
            make.height.equalTo(35*APP_SCALE)
        }
        self.viewH += 35*APP_SCALE
        showMoreBtn.addTarget(self, action: #selector(showMore), for: UIControl.Event.touchUpInside)
    }
    
    @objc
    func showMore(){}
    
}
