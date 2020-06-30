//
//  YCNewCarParallelImportHeaderView.swift
//  qichehui
//
//  Created by SMART on 2020/2/20.
//  Copyright © 2020 SMART. All rights reserved.
//

import UIKit

class YCNewCarParallelImportHeaderView: UIView {
    
    var viewH:CGFloat = 0
    
    private lazy var optionBtnArr:[YCCustomButton] = [YCCustomButton]()
    func bindData(
        hotMasterBrand: [YCNewCarParallelImportHotMasterBrandsModel],
        hotModels :[YCNewCarParallelImportHotModelsModel]
    ){

        setupHotMasterBrand(hotMasterBrand)
        setupHotModels()
    }
    
    func setupHotMasterBrand(_ hotMasterBrand: [YCNewCarParallelImportHotMasterBrandsModel]){
        viewH = 0
        if optionBtnArr.count < hotMasterBrand.count{
            for _ in optionBtnArr.count ..< hotMasterBrand.count {
                let btn = YCCustomButton(type: .topImageBottomTitle)
                btn.marginScale = 0
                btn.titleLabel?.font = FONT_SIZE_11
                optionBtnArr.append(btn)
                self.addSubview(btn)
            }
        }else{
            if hotMasterBrand.count < optionBtnArr.count{
                for index in hotMasterBrand.count ..< optionBtnArr.count {
                    let btn = optionBtnArr[index]
                    btn.isHidden = true
                }
            }
        }
        
        let COL = 5
        let btn_wh = (SCREEN_WIDTH - 2*MARGIN_20)/CGFloat(COL)
        for (index,item) in hotMasterBrand.enumerated() {
            let btn = optionBtnArr[index]
            btn.isHidden = false
            if let title = item.brandName {
                btn.setTitle(title, for: UIControl.State.normal)
            }
            if let url = item.logoUrl{
                btn.loadImage(imageURL: url)
            }
            btn.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(MARGIN_20 + CGFloat(index/COL)*(btn_wh + MARGIN_10))
                make.left.equalToSuperview().offset(MARGIN_20 + CGFloat(index%COL)*btn_wh)
                make.width.height.equalTo(btn_wh)
            }
        }
        let rows = ceil(CGFloat(hotMasterBrand.count)/CGFloat(COL))
        viewH += MARGIN_20 + rows*btn_wh + (rows-1)*MARGIN_10 + MARGIN_20
    }
    
    func setupHotModels(){
        
    }
    
}
