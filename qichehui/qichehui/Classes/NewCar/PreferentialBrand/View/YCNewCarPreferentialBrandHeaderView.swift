//
//  YCNewCarPreferentialBrandHeaderView.swift
//  qichehui
//
//  Created by SMART on 2020/2/20.
//  Copyright © 2020 SMART. All rights reserved.
//

import UIKit

class YCNewCarPreferentialBrandHeaderView: UIView {
    var viewH:CGFloat = 0
    
    private lazy var optionBtnArr = [YCCustomButton]()
    
    private lazy var merchandiseShowView:YCNewCarEnergyWorthToBuyView = {
        let view = YCNewCarEnergyWorthToBuyView()
        self.addSubview(view)
        return view
    }()
    
    func bindData(
        tangdou:[YCNewCarPreferentialBrandTangDouModel],
        merchandiseShow:[YCNewEnergyWorthToBuyModel]
    ){
        setupTanggou(tangdou)
        setupMerchandiseShow(merchandiseShow)
    }
    
    func setupTanggou(_ tangdou:[YCNewCarPreferentialBrandTangDouModel]){
        
        if optionBtnArr.count < tangdou.count{
            for _ in optionBtnArr.count ..< tangdou.count {
                let btn = YCCustomButton(type: .topImageBottomTitle)
                btn.marginScale = 0
                btn.titleLabel?.font = FONT_SIZE_11
                optionBtnArr.append(btn)
                self.addSubview(btn)
            }
        }else{
            if tangdou.count < optionBtnArr.count{
                for index in tangdou.count ..< optionBtnArr.count {
                    let btn = optionBtnArr[index]
                    btn.isHidden = true
                }
            }
        }
        
        let COL = 4
        let btn_wh = (SCREEN_WIDTH - 2*MARGIN_20)/CGFloat(COL)
        for (index,item) in tangdou.enumerated() {
            let btn = optionBtnArr[index]
            btn.isHidden = false
            if let title = item.name {
                btn.setTitle(title, for: UIControl.State.normal)
            }
            if let url = item.tupian{
                btn.loadImage(imageURL: url)
            }
            btn.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(CGFloat(index/COL)*(MARGIN_20 + btn_wh + MARGIN_10))
                make.left.equalToSuperview().offset(MARGIN_20 + CGFloat(index%COL)*btn_wh)
                make.width.height.equalTo(btn_wh)
            }
        }
        let rows = ceil(CGFloat(tangdou.count)/CGFloat(COL))
        viewH += rows*btn_wh + (rows-1)*MARGIN_10 + MARGIN_20
    }
    
    func setupMerchandiseShow(_ merchandiseShow:[YCNewEnergyWorthToBuyModel]){
        merchandiseShowView.bindData(infos: merchandiseShow,showMore:false)
        merchandiseShowView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(viewH)
            make.left.right.equalToSuperview()
            make.height.equalTo(merchandiseShowView.viewH)
        }
        viewH += merchandiseShowView.viewH + MARGIN_20
    }
}
