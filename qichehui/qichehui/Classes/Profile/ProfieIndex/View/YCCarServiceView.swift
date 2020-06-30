//
//  YCCarService.swift
//  qichehui
//
//  Created by SMART on 2019/12/4.
//  Copyright © 2019 SMART. All rights reserved.
//

import UIKit

class YCCarServiceView: UIView {
    var viewH:CGFloat = 0
    var modulesBtnArr = [YCCustomButton]()
    private var titleH:CGFloat = 0
    // 顶部分割线
    lazy var lineView:UIView = {
        let lineView = UIView()
        lineView.backgroundColor = BACK_GROUND_COLOR
        return lineView
    }()
    
    // 标题
    lazy var titleLab:UILabel = {
        let label = UILabel()
        label.text = "行车服务";
        label.textColor = UIColor.darkGray
        label.font = BOLD_FONT_SIZE_18
        return label
    }()
    
    var carServiceModels:[YCProfileCarServiceModel]?{didSet {setCarServiceModels()}}
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    func setupUI(){
        
        backgroundColor = UIColor.white
        
        // 顶部分割线
        addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(MARGIN_5)
        }
        
        
        //标题
        addSubview(titleLab)
        titleLab.sizeToFit()
        let titleH = titleLab.frame.height
        titleLab.snp.makeConstraints { (make) in
            make.top.equalTo(lineView.snp_bottom).offset(MARGIN_20)
            make.left.equalToSuperview().offset(MARGIN_20)
            make.height.equalTo(titleH)
        }
        self.titleH = titleH
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCarServiceModels(){
        
        viewH = 0
        
        viewH += MARGIN_5
        viewH += MARGIN_20 + titleH
        
        guard let models = carServiceModels else{ return }
        
        let COL:Int = 5
        let count:CGFloat = CGFloat(models.count)
        
        let BTN_H = 60*APP_SCALE
        let BTN_W = (SCREEN_WIDTH - CGFloat(2) * MARGIN_20)/CGFloat(COL)
        
        if modulesBtnArr.count < models.count{
            for _ in modulesBtnArr.count ..< models.count {
                let btn = YCCustomButton(type: .topImageBottomTitle)
                btn.marginScale = 0
                modulesBtnArr.append(btn)
                addSubview(btn)
            }
        }else{
            for index in  models.count ..< modulesBtnArr.count {
                let btn = modulesBtnArr[index]
                btn.isHidden = true
            }
        }
        
        for (index,model) in models.enumerated() {
            let btn = modulesBtnArr[index]
            btn.isHidden = false
            if let url = model.image {btn.loadImage(imageURL: url, placeholder: nil)}
            btn.setTitleColor(UIColor.hexadecimalColor(hexadecimal: "#615D62"), for: UIControl.State.normal)
            btn.setTitle(model.title ?? "", for: UIControl.State.normal)
            btn.titleLabel?.font = FONT_SIZE_11
            let column = CGFloat(index).truncatingRemainder(dividingBy: CGFloat(COL))
            btn.snp.makeConstraints { (make) in
                make.left.equalToSuperview().offset(MARGIN_20 +  column*BTN_W)
                make.top.equalToSuperview().offset(viewH + MARGIN_10 + CGFloat(index/COL)*(BTN_H+MARGIN_10))
                make.width.equalTo(BTN_W)
                make.height.equalTo(BTN_H)
            }
        }
        let rows = ceil(Float(count)/Float(COL))
        viewH += MARGIN_10 + CGFloat(rows)*BTN_H + MARGIN_20
    }
    
}
