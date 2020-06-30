//
//  YCShowMoreTitleView.swift
//  qichehui
//
//  Created by SMART on 2019/12/9.
//  Copyright © 2019 SMART. All rights reserved.
//

import UIKit

class YCShowMoreTitleView: UICollectionReusableView {
    
    private var selectedIndex = 0
    var categories:[YCShowMoreCategoryModel]?{didSet{setCategories()}}
    private var titleBtnArr = [UIButton]()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCategories(){
        
        guard let models = categories else{return}
        if titleBtnArr.count < models.count {
            for _ in titleBtnArr.count ..< models.count {
                let btn = UIButton()
                btn.isHighlighted = false
                btn.titleLabel?.font = FONT_SIZE_13
                btn.setTitleColor(UIColor.white, for: UIControl.State.selected)
                btn.setTitleColor(UIColor.darkGray, for: UIControl.State.normal)
                titleBtnArr.append(btn)
                addSubview(btn)
            }
        }else{
            for index in  models.count ..< titleBtnArr.count {
                let btn = titleBtnArr[index]
                btn.isHidden = true
            }
        }
        let BTN_W = (SCREEN_WIDTH - 2*MARGIN_20 - CGFloat(models.count)*MARGIN_15) / CGFloat(models.count)
        let BTN_H = 25*APP_SCALE
        for (index,model) in models.enumerated() {
            let btn = titleBtnArr[index]
            btn.isHidden = false
            btn.setTitle(model.name, for: UIControl.State.normal)
            btn.snp.makeConstraints { (make) in
                make.left.equalToSuperview().offset(MARGIN_20+CGFloat(index)*(MARGIN_15 + BTN_W))
                make.centerY.equalToSuperview()
                make.height.equalTo(BTN_H)
                make.width.equalTo(BTN_W)
            }
        }
        
        let btn = titleBtnArr[selectedIndex]
        btn.backgroundColor = THEME_COLOR
        btn.layer.cornerRadius = BTN_H*0.5
        btn.layer.masksToBounds = true
        btn.isSelected = true
        
    }
    
}
