//
//  YCNewCarLuxuryBrandHeaderView.swift
//  qichehui
//
//  Created by SMART on 2020/2/18.
//  Copyright © 2020 SMART. All rights reserved.
//

import UIKit

class YCNewCarLuxuryBrandHeaderView: UIView {
    var viewH:CGFloat = 0
    
    private lazy var colorView:UIView = {
        let view  = UIView()
        self.addSubview(view)
        return view
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
    
    private lazy var worthToBuyTitleLabel:UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "值得买"
        titleLabel.font = BOLD_FONT_SIZE_18
        self.addSubview(titleLabel)
        return titleLabel
    }()
    
    private lazy var worthToBuyView:YCNewCarEnergyWorthToBuyView = {
        let view = YCNewCarEnergyWorthToBuyView()
        self.addSubview(view)
        return view
    }()
    
    private lazy var optionView:YCNewCarLuxuryBrandSelectOptionView = {
        let view = YCNewCarLuxuryBrandSelectOptionView()
        self.addSubview(view)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        colorView.backgroundColor = UIColor.hexadecimalColor(hexadecimal: "#383439")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bindData(
        hotMaster:[YCNewEnergyHotMasterModel],
        priceReduceList:[YCNewEnergyPriceReduceList],
        worthToBuy:[YCNewEnergyWorthToBuyModel]
    ){
        setupHotMasters(hotMaster)
        setupPriceReduceList(priceReduceList)
        setupWorthToBuyTitleLabel()
        setupWorthToBuy(worthToBuy)
        setupOptionView()
        
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
    
    func setupWorthToBuyTitleLabel(){
        worthToBuyTitleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(viewH)
            make.left.equalToSuperview().offset(MARGIN_15)
            make.right.equalToSuperview()
            make.height.equalTo(30*APP_SCALE)
        }
        viewH += 30*APP_SCALE + MARGIN_20
    }
    
    func setupWorthToBuy(_ worthToBuy:[YCNewEnergyWorthToBuyModel]){
        worthToBuyView.bindData(infos: worthToBuy)
        let buyViewH = worthToBuyView.viewH
        worthToBuyView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(self.viewH)
            make.left.right.equalToSuperview()
            make.height.equalTo(buyViewH)
        }
        viewH += buyViewH + MARGIN_20
    }
    
    func setupOptionView(){
        optionView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.viewH)
            make.height.equalTo(30*APP_SCALE)
        }
        viewH += 30*APP_SCALE
    }
    
}
