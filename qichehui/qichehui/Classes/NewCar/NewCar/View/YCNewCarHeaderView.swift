//
//  YCNewCarHeaderView.swift
//  qichehui
//
//  Created by SMART on 2020/2/2.
//  Copyright © 2020 SMART. All rights reserved.
//

import UIKit

class YCNewCarHeaderView: UIView {
    
    var viewH:CGFloat = 0
    private lazy var carIconBtnArr:[YCCustomButton] = [YCCustomButton]()
    private lazy var carBrandBtnArr:[YCCustomButton] = [YCCustomButton]()
    private lazy var carPriceBtnArr:[UIButton] = [UIButton]()
    private lazy var carLevelBtnArr:[UIButton] = [UIButton]()
    private lazy var carSerialBtnArr:[UIButton] = [UIButton]()
    
    private lazy var scrollView:UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        self.addSubview(scrollView)
        return scrollView
    }()
    
    private lazy var lineView:UIView = {
        let lineView = UIView()
        self.addSubview(lineView)
        lineView.backgroundColor = BACK_GROUND_COLOR
        return lineView
    }()
    func bindData(carIcons:[carIcon],carBrands:[hotCarBrand],carPrices:[carPrice],carLevels:[carLevel],carSerials:[hotCarSerial]){
        setupCarIcons(carIcons)
        setupCarBrands(carBrands)
        setupCarPrices(carPrices)
        setupCarLevels(carLevels)
        setupCarSerials(carSerials)
        
        lineView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.width.equalTo(SCREEN_WIDTH)
            make.top.equalToSuperview().offset(viewH + MARGIN_15)
            make.height.equalTo(10*APP_SCALE)
        }
        viewH +=  MARGIN_15 + 10*APP_SCALE
    }
    
    func setupCarIcons(_ carIcons:[carIcon]){
        let col = 5
        let btn_width = (SCREEN_WIDTH - 2*MARGIN_15) / CGFloat(col)
        let btn_height = 60*APP_SCALE
        let carIcons = carIcons[0..<5]
        if carIconBtnArr.count < carIcons.count{
            for index in carIconBtnArr.count ..< carIcons.count {
                let btn = YCCustomButton(type: .topImageBottomTitle)
                btn.marginScale = 0
                carIconBtnArr.append(btn)
                self.addSubview(btn)
                let model = carIcons[index]
                if let url = model.image {
                    btn.loadImage(imageURL: url)
                }
                if let title = model.title{
                    btn.setTitle(title, for: UIControl.State.normal)
                    btn.titleLabel?.font = FONT_SIZE_11
                }
                btn.snp.makeConstraints { (make) in
                    make.left.equalToSuperview().offset(MARGIN_15 + CGFloat(index%col)*btn_width)
                    make.top.equalToSuperview().offset(MARGIN_15 + CGFloat(index/col)*btn_height)
                    make.width.equalTo(btn_width)
                    make.height.equalTo(btn_height)
                }
            }
            
        }
        
        if carIcons.count <  carIconBtnArr.count{
            for index in carIcons.count ..< carIconBtnArr.count  {
                let btn = carIconBtnArr[index]
                btn.isHidden = true
            }
        }
        
        viewH += MARGIN_15 + ceil(CGFloat(carIcons.count/col))*btn_height + MARGIN_10
        
    }
    
    func setupCarBrands(_ carBrands:[hotCarBrand]){
        let col = 5
        let btn_width = (SCREEN_WIDTH - 2*MARGIN_15) / CGFloat(col)
        let btn_height = 60*APP_SCALE
        if carBrandBtnArr.count < carBrands.count{
            for _ in carBrandBtnArr.count ..< carBrands.count {
                let btn = YCCustomButton(type: .topImageBottomTitle)
                btn.imageScale = 0.5
                btn.marginScale = 0
                carBrandBtnArr.append(btn)
                self.addSubview(btn)
            }
            
            if carBrands.count <  carBrandBtnArr.count{
                for index in carBrands.count ..< carIconBtnArr.count  {
                    let btn = carBrandBtnArr[index]
                    btn.isHidden = true
                }
            }
            
            for (index,model) in carBrands.enumerated() {
                let btn = carBrandBtnArr[index]
                btn.isHidden = false
                if let url = model.image {
                    btn.loadImage(imageURL: url)
                }
                if let title = model.masterName{
                    btn.setTitle(title, for: UIControl.State.normal)
                    btn.titleLabel?.font = FONT_SIZE_11
                }
                btn.snp.makeConstraints { (make) in
                    make.left.equalToSuperview().offset(MARGIN_15 + CGFloat(index%col)*btn_width)
                    make.top.equalToSuperview().offset(CGFloat(index/col)*btn_height + viewH)
                    make.width.equalTo(btn_width)
                    make.height.equalTo(btn_height)
                }
            }
        }
        
        viewH += ceil(CGFloat(carBrands.count/col))*btn_height + MARGIN_10
    }
    
    func setupCarPrices(_ carPrices:[carPrice]){
        let col = 5
        let btn_height = 30*APP_SCALE
        let btn_width = (SCREEN_WIDTH - CGFloat(2)*MARGIN_15 - CGFloat(col-1)*MARGIN_10)/CGFloat(col)
        if carPriceBtnArr.count < carPrices.count{
            for _ in carPriceBtnArr.count..<carPrices.count{
                let btn = UIButton()
                btn.titleLabel?.font = FONT_SIZE_11
                btn.titleLabel?.textAlignment = .center
                btn.setTitleColor(UIColor.darkGray, for: UIControl.State.normal)
                btn.layer.cornerRadius = btn_height * 0.5
                self.addSubview(btn)
                carPriceBtnArr.append(btn)
                btn.backgroundColor = UIColor.hexadecimalColor(hexadecimal: "#EDF2FF")
            }
        }else{
            if carPrices.count  <  carPriceBtnArr.count{
                for index in carPrices.count..<carPriceBtnArr.count{
                    let btn = carPriceBtnArr[index]
                    btn.isHidden = true
                }
            }
        }
        
        for (index,item) in carPrices.enumerated(){
            let btn = carPriceBtnArr[index]
            btn.isHidden = false
            if let title = item.title {
                btn.setTitle(title, for: UIControl.State.normal)
            }
            
            btn.snp.makeConstraints { (make) in
                make.width.equalTo(btn_width)
                make.height.equalTo(btn_height)
                make.top.equalToSuperview().offset(MARGIN_15 + viewH + CGFloat(index/col)*(btn_height + MARGIN_10))
                make.left.equalToSuperview().offset(MARGIN_15 + CGFloat(index%col)*(btn_width + MARGIN_10))
            }
        }
        let rows = ceil(CGFloat(carPrices.count/col))
        viewH += MARGIN_15 + rows*btn_height + (rows-1)*MARGIN_10 + MARGIN_10
    }
    
    func setupCarLevels(_ carLevels:[carLevel]){
        let col = 5
        let btn_height = 30*APP_SCALE
        let btn_width = (SCREEN_WIDTH - CGFloat(2)*MARGIN_15 - CGFloat(col-1)*MARGIN_10)/CGFloat(col)
        if carLevelBtnArr.count < carLevels.count{
            for _ in carLevelBtnArr.count..<carLevels.count{
                let btn = UIButton()
                btn.titleLabel?.font = FONT_SIZE_11
                btn.titleLabel?.textAlignment = .center
                btn.setTitleColor(UIColor.darkGray, for: UIControl.State.normal)
                btn.layer.cornerRadius = btn_height * 0.5
                self.addSubview(btn)
                carLevelBtnArr.append(btn)
                btn.backgroundColor = UIColor.hexadecimalColor(hexadecimal: "#EDF2FF")
            }
        }else{
            if carLevels.count  <  carLevelBtnArr.count{
                for index in carLevels.count..<carLevelBtnArr.count{
                    let btn = carPriceBtnArr[index]
                    btn.isHidden = true
                }
            }
        }
        
        for (index,item) in carLevels.enumerated(){
            let btn = carLevelBtnArr[index]
            btn.isHidden = false
            if let title = item.title {
                btn.setTitle(title, for: UIControl.State.normal)
            }
            
            btn.snp.makeConstraints { (make) in
                make.width.equalTo(btn_width)
                make.height.equalTo(btn_height)
                make.top.equalToSuperview().offset(viewH + CGFloat(index/col)*(btn_height + MARGIN_10))
                make.left.equalToSuperview().offset(MARGIN_15 + CGFloat(index%col)*(btn_width + MARGIN_10))
            }
        }
        let rows = ceil(CGFloat(carLevels.count/col))
        viewH += rows*btn_height + (rows-1)*MARGIN_10 + MARGIN_10
    }
    
    func setupCarSerials(_ carSerials:[hotCarSerial]){
        let scrollViewH:CGFloat = 25*APP_SCALE
        scrollView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.width.equalTo(SCREEN_WIDTH)
            make.height.equalTo(scrollViewH)
            make.top.equalToSuperview().offset(viewH)
        }
        
        if carSerialBtnArr.count < carSerials.count{
            for _ in carSerialBtnArr.count ..< carSerials.count{
                let btn = UIButton()
                btn.layer.cornerRadius = scrollViewH*0.5
                btn.titleLabel?.textAlignment = .center
                btn.titleLabel?.font = FONT_SIZE_11
                btn.setTitleColor(UIColor.darkGray, for: UIControl.State.normal)
                self.scrollView.addSubview(btn)
                self.carSerialBtnArr.append(btn)
                btn.backgroundColor = BACK_GROUND_COLOR
            }
        }else{
            if carSerials.count < carSerialBtnArr.count{
                for index in carSerials.count  ..< carSerialBtnArr.count{
                    let btn = carSerialBtnArr[index]
                    btn.isHidden = true
                }
            }
        }
        
        var offsetX:CGFloat = 0
        for (index,item) in carSerials.enumerated(){
            let btn = carSerialBtnArr[index]
            if let title = item.csShowName{
                btn.setTitle(title, for: UIControl.State.normal)
            }
            btn.sizeToFit()
            let btnSize = btn.frame.size
            btn.snp.makeConstraints { (make) in
                make.left.equalToSuperview().offset(MARGIN_15 + offsetX)
                make.top.equalToSuperview()
                make.height.equalToSuperview()
                make.width.equalTo(btnSize.width + 20*APP_SCALE)
            }
            offsetX += (btnSize.width + 20*APP_SCALE) + MARGIN_10
        }
        
        scrollView.contentSize = CGSize(width: offsetX + 2*MARGIN_15 - MARGIN_10, height: 0)
        viewH += scrollViewH
    }
    
}
