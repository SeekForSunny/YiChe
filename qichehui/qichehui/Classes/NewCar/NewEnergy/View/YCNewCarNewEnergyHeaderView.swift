//
//  YCNewCarNewEnergyHeaderView.swift
//  qichehui
//
//  Created by SMART on 2020/2/4.
//  Copyright © 2020 SMART. All rights reserved.
//

import UIKit

class YCNewCarNewEnergyHeaderView: UIView {
    
    var viewH:CGFloat = 0
    
    private lazy var selectConditionsViews:[YCNewCarEnergySelectConditionsView] = [YCNewCarEnergySelectConditionsView]()
    private lazy var optionBtnArr:[YCCustomButton] = [YCCustomButton]()
    private lazy var colorView:UIView = {
        let colorView = UIView()
        self.addSubview(colorView)
        return colorView
    }()
    
    private lazy var brandView:YCNewCarNewEnergyBrandView = {
        let brandView = YCNewCarNewEnergyBrandView()
        self.addSubview(brandView)
        return brandView
    }()
    
    private lazy var priceReduceListView:YCNewEnergyPriceReduceListView = {
        let listView = YCNewEnergyPriceReduceListView()
        self.addSubview(listView)
        return listView
    }()
    
    private lazy var recommendHeaderView:YCNewCarNewEnergyRecommendHeaderView = {
        let view = YCNewCarNewEnergyRecommendHeaderView()
        self.addSubview(view)
        return view
    }()
    private lazy var worthToBuyView:YCNewCarEnergyWorthToBuyView = {
        let view = YCNewCarEnergyWorthToBuyView()
        self.addSubview(view)
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        colorView.backgroundColor = UIColor.hexadecimalColor(hexadecimal: "#24CDBA")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bindData(
        hotMasters:[YCNewEnergyHotMasterModel],
        worthToBuy:[YCNewEnergyWorthToBuyModel],
        oppositions:[YCNewEnergyOppositionsModel],
        selectConditions:[YCNewEnergySelectConditionsModel],
        priceReduceList:[YCNewEnergyPriceReduceList]
    ){
        
        setupHotMasters(hotMasters)
        setupSelectConditions(selectConditions)
        setupOppositions(oppositions)
        setupPriceReduceList(priceReduceList)
        setupRecommendHeaderView()
        setupWorthToBuy(worthToBuy)
        
        self.backgroundColor = UIColor.white
    }
    
    func setupHotMasters(_ hotMasters:[YCNewEnergyHotMasterModel]){
        
        brandView.bindData(hotMasters: hotMasters)
        let brandViewH = brandView.viewH
        brandView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(MARGIN_10)
            make.right.equalToSuperview().offset(-MARGIN_10)
            make.top.equalToSuperview().offset(MARGIN_15)
            make.height.equalTo(brandViewH)
        }
        
        colorView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(brandViewH - 50*APP_SCALE)
        }
        
        viewH += MARGIN_15 +  brandViewH + MARGIN_15
        
    }
    
    func setupSelectConditions(_ selectConditions:[YCNewEnergySelectConditionsModel]){
        if selectConditionsViews.count < selectConditions.count {
            for _ in selectConditionsViews.count..<selectConditions.count{
                let selectConditionsView = YCNewCarEnergySelectConditionsView()
                selectConditionsViews.append(selectConditionsView)
                self.addSubview(selectConditionsView)
            }
        }else{
            if selectConditions.count < selectConditionsViews.count {
                for index in selectConditions.count ..< selectConditionsViews.count {
                    let view = selectConditionsViews[index]
                    view.isHidden = true
                }
            }
        }
        
        let optionViewH = 30*APP_SCALE
        for (index,item) in selectConditions.enumerated(){
            let optionView = selectConditionsViews[index]
            optionView.bindData(title: item.title ?? "", selections: item.conditions ?? [YCNewEnergySelectConditions]())
            optionView.snp.makeConstraints { (make) in
                make.left.equalToSuperview().offset(MARGIN_15)
                make.right.equalToSuperview().offset(-MARGIN_15)
                make.top.equalToSuperview().offset(viewH + CGFloat(index)*(optionViewH+MARGIN_10))
            }
        }
        
        viewH += CGFloat(selectConditions.count)*optionViewH + CGFloat(selectConditions.count - 1)*MARGIN_10 + MARGIN_20
    }
    
    
    func setupOppositions(_ oppositions:[YCNewEnergyOppositionsModel]){
        if optionBtnArr.count < oppositions.count {
            for _ in optionBtnArr.count..<oppositions.count{
                let btn = YCCustomButton(type: .topImageBottomTitle)
                btn.marginScale = 0
                btn.imageScale = 0.8
                btn.titleLabel?.font = FONT_SIZE_11
                optionBtnArr.append(btn)
                self.addSubview(btn)
            }
        }else{
            if oppositions.count < optionBtnArr.count {
                for index in oppositions.count ..< optionBtnArr.count {
                    let view = selectConditionsViews[index]
                    view.isHidden = true
                }
            }
        }
        
        let col = 4
        let btnW = (SCREEN_WIDTH - 2*MARGIN_15)/CGFloat(col)
        let btnH = 70*APP_SCALE
        for (index,item) in oppositions.enumerated(){
            let btn = optionBtnArr[index]
            btn.isHidden = false
            if let title = item.title {
                btn.setTitle(title, for: UIControl.State.normal)
            }
            if let url = item.image {
                btn.loadImage(imageURL: url)
            }
            btn.snp.makeConstraints { (make) in
                make.width.equalTo(btnW)
                make.height.equalTo(btnH)
                make.left.equalToSuperview().offset(MARGIN_15 + CGFloat(index%col)*btnW)
                make.top.equalToSuperview().offset(viewH + CGFloat(index/col)*(btnH + MARGIN_10))
            }
        }
        
        let rows = ceil(CGFloat(oppositions.count)/CGFloat(col))
        viewH += rows*btnH + (rows-1)*MARGIN_10 + MARGIN_20
    }
    
    
    func setupPriceReduceList(_ priceReduceList:[YCNewEnergyPriceReduceList]){
        priceReduceListView.bindData(priceReduceList:priceReduceList)
        let listViewH = priceReduceListView.viewH
        priceReduceListView.snp.makeConstraints { (make) in
            make.top.equalTo(self.viewH)
            make.left.right.equalToSuperview()
            make.height.equalTo(listViewH)
        }
        viewH += listViewH + MARGIN_20
    }
    
    func setupRecommendHeaderView(){
        recommendHeaderView.bindData()
        let recViewH = recommendHeaderView.viewH
        recommendHeaderView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(self.viewH)
            make.left.right.equalToSuperview()
            make.height.equalTo(recViewH)
        }
        recommendHeaderView.backgroundColor = .white
        self.viewH += recViewH
    }
    
    func setupWorthToBuy(_ worthToBuy:[YCNewEnergyWorthToBuyModel]){
        worthToBuyView.bindData(infos: worthToBuy)
        let buyViewH = worthToBuyView.viewH
        worthToBuyView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(self.viewH)
            make.left.right.equalToSuperview()
            make.height.equalTo(buyViewH)
        }
        viewH += buyViewH
    }
    
}
