//
//  YCNewCarLuxuryBrandModelTagsDynamicView.swift
//  qichehui
//
//  Created by SMART on 2020/2/20.
//  Copyright © 2020 SMART. All rights reserved.
//

import UIKit

class YCNewCarLuxuryBrandModelTagsDynamicView: UIView {
    
    var viewH:CGFloat = 0
    var modelTagsDynamic:[modelTagsDynamic]?{didSet{setModelTagsDynamic()}}
    
    private lazy var labelArr:[UILabel] = [UILabel]()
    
    func setModelTagsDynamic(){
        guard let modelTagsDynamic = self.modelTagsDynamic else{return}
        viewH = 0
        
        self.backgroundColor = UIColor.white
        
        if labelArr.count < modelTagsDynamic.count {
            for _ in modelTagsDynamic {
                let label = UILabel()
                label.font = FONT_SIZE_11
                label.layer.cornerRadius = 3*APP_SCALE
                label.clipsToBounds = true
                label.textAlignment = .center
                self.addSubview(label)
                self.labelArr.append(label)
            }
        }else{
            if modelTagsDynamic.count < labelArr.count{
                for index in modelTagsDynamic.count ..< labelArr.count{
                    let label = labelArr[index]
                    label.isHidden = true
                }
            }
        }
        
        var offsetX:CGFloat = 0
        var offsetY:CGFloat = 0
        var labelH:CGFloat = 0
        for (index,item) in modelTagsDynamic.enumerated(){
            let label = labelArr[index]
            if item.id == 12 {
                label.textColor = UIColor.hexadecimalColor(hexadecimal: "#3D66F9")
                label.backgroundColor = UIColor.hexadecimalColor(hexadecimal: "#F3F5FF")
            }else{
                label.textColor = UIColor.hexadecimalColor(hexadecimal: "#F84850")
                label.backgroundColor = UIColor.hexadecimalColor(hexadecimal: "#FFF0F6")
            }
            label.isHidden = false
            label.text = item.value
            label.sizeToFit()
            var labelSize = label.frame.size
            labelSize.width += MARGIN_10
            labelSize.height += MARGIN_5
            labelH = labelSize.height
            let maxWidth:CGFloat = SCREEN_WIDTH - MARGIN_20 - 90*APP_SCALE - MARGIN_15 - MARGIN_20
            let next = offsetX + labelSize.width + MARGIN_5
            
            if next >= maxWidth {
                offsetX = 0
                offsetY += labelSize.height + MARGIN_5
            }
            label.snp.remakeConstraints { (make) in
                make.left.equalToSuperview().offset(offsetX)
                make.top.equalToSuperview().offset(offsetY)
                make.size.equalTo(labelSize)
            }
            offsetX += labelSize.width + MARGIN_5
        }
        viewH = offsetY + labelH
    }
    
}
