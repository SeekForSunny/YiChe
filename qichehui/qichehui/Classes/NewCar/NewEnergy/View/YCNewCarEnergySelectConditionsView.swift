//
//  YCNewCarEnergyOptionsView.swift
//  qichehui
//
//  Created by SMART on 2020/2/4.
//  Copyright © 2020 SMART. All rights reserved.
//

import UIKit

class YCNewCarEnergySelectConditionsView: UIView {
    
    private lazy var titleLabel:UILabel = {
        let label = UILabel()
        self.addSubview(label)
        return label
    }()

    private lazy var selectionBtnArr:[UIButton] = [UIButton]()
    
    func bindData(title:String,selections:[YCNewEnergySelectConditions]){
        
        titleLabel.text = title
        titleLabel.font = FONT_SIZE_11
        titleLabel.textColor = UIColor.lightGray
        titleLabel.sizeToFit()
        let titleSize = titleLabel.frame.size
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalToSuperview()
            make.width.equalTo(titleSize.width)
        }
        
        if selectionBtnArr.count < selections.count{
            for _ in selectionBtnArr.count ..< selections.count{
                let btn = UIButton()
                btn.titleLabel?.font = FONT_SIZE_11
                btn.setTitleColor(UIColor.darkGray, for: UIControl.State.normal)
                selectionBtnArr.append(btn)
                self.addSubview(btn)
            }
        }else{
            for index in selections.count..<selectionBtnArr.count{
                let btn = selectionBtnArr[index]
                btn.isHidden = true
            }
        }
        
        let col = 4
        let btnW = (SCREEN_WIDTH - 2*MARGIN_15 - titleSize.width)/CGFloat(col)
        for (index,item) in selections.enumerated() {
            let btn = selectionBtnArr[index]
            btn.isHidden = false
            btn.setTitle(item.value, for: UIControl.State.normal)
            btn.snp.makeConstraints { (make) in
                make.left.equalTo(titleLabel.snp.right).offset(btnW*CGFloat(index%col))
                make.top.height.equalToSuperview()
                make.width.equalTo(btnW)
                make.height.equalToSuperview()
            }
        }
    }
    
}
