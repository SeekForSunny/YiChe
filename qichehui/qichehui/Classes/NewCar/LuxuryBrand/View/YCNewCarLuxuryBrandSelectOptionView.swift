//
//  YCNewCarLuxuryBrandSelectOptionView.swift
//  qichehui
//
//  Created by SMART on 2020/2/20.
//  Copyright © 2020 SMART. All rights reserved.
//

import UIKit

class YCNewCarLuxuryBrandSelectOptionView: UIView {

    private let labels:[String] = ["品牌","价格","级别","配置"]
    private lazy var optionBtnArr:[YCCustomButton] = [YCCustomButton]()
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    private lazy var sortBtn:UIButton = {
        let btn = UIButton()
        self.addSubview(btn)
        btn.setImage(UIImage(named: "bpk_pub_sort"), for: UIControl.State.normal)
        return btn
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI(){
        
        let btn_w = 50*APP_SCALE
        for (index,title) in labels.enumerated() {
            let btn = YCCustomButton(type: .leftTitleRightImage)
            btn.titleLabel?.font = FONT_SIZE_11
            btn.marginScale = 0
            btn.imageScale = 0.2
            btn.setTitle(title, for: UIControl.State.normal)
            btn.setImage(UIImage(named: "bpc_ic_zongheyouhui_down"), for: UIControl.State.normal)
            optionBtnArr.append(btn)
            self.addSubview(btn)
            
            btn.snp.makeConstraints { (make) in
                make.left.equalToSuperview().offset(MARGIN_20 + CGFloat(index)*(btn_w + MARGIN_30) )
                make.top.bottom.equalToSuperview()
                make.width.equalTo(btn_w)
            }
        }
        
        sortBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-MARGIN_20)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(25*APP_SCALE)
        }
    }
    
}
