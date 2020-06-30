//
//  YCNewCarNewEnergyBrandView.swift
//  qichehui
//
//  Created by SMART on 2020/2/8.
//  Copyright © 2020 SMART. All rights reserved.
//

import UIKit

class YCNewCarNewEnergyBrandView: UIView {

    var viewH:CGFloat = 0
    private lazy var hotMasterBtnArr:[YCCustomButton] = [YCCustomButton]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI() {
        self.layer.cornerRadius = 8*APP_SCALE
        self.backgroundColor = UIColor.white
        self.layer.shadowColor = BACK_GROUND_COLOR.cgColor
        self.layer.shadowOffset = CGSize(width: 6, height: 6)
        self.layer.shadowRadius = 6
        self.layer.shadowOpacity = 0.6
    }
    
    func bindData(hotMasters:[YCNewEnergyHotMasterModel]){
        var hotMasters = hotMasters
        
        let item = YCNewEnergyHotMasterModel()
        item.masterName = "更多"
        item.image = "bpn_newlist_more"
        hotMasters.append(item)
        
        if hotMasterBtnArr.count < hotMasters.count{
            for _ in hotMasterBtnArr.count ..< hotMasters.count {
                let btn = YCCustomButton(type: .topImageBottomTitle)
                btn.titleLabel?.font = FONT_SIZE_11
                self.hotMasterBtnArr.append(btn)
                self.addSubview(btn)
            }
        }else{
            if hotMasters.count < hotMasterBtnArr.count {
                for index in hotMasters.count..<hotMasterBtnArr.count {
                    let btn = hotMasterBtnArr[index]
                    btn.isHidden = true
                }
            }
        }
        
        let col = 5
        let btn_height = 60*APP_SCALE
        let btn_width = (SCREEN_WIDTH - 2*MARGIN_10 - 2*MARGIN_15)/CGFloat(col)
        
        for (index,item) in hotMasters.enumerated() {
            let btn = hotMasterBtnArr[index]
            if let title = item.masterName {
                btn.setTitle(title, for: UIControl.State.normal)
            }
            if let url = item.image {
                if url.contains("http"){
                    btn.loadImage(imageURL: url)
                }else{
                    btn.setImage(UIImage(named: url), for: UIControl.State.normal)
                }
            }
            
            btn.snp.makeConstraints { (make) in
                make.height.equalTo(btn_height)
                make.width.equalTo(btn_width)
                make.left.equalToSuperview().offset(MARGIN_15 + CGFloat(index%col)*btn_width)
                make.top.equalToSuperview().offset(MARGIN_15 + CGFloat(index/col)*(btn_height + MARGIN_15))
            }
            
        }
        
        let rows = ceil(CGFloat(hotMasters.count)/CGFloat(col))
        viewH = 3*MARGIN_15 + rows * btn_height
    }

}
