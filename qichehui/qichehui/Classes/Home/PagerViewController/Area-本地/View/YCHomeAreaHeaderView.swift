//
//  YCHomeAreaHeaderView.swift
//  qichehui
//
//  Created by SMART on 2020/1/4.
//  Copyright © 2020 SMART. All rights reserved.
//

import UIKit

class YCHomeAreaHeaderView: UIView {
    private lazy var operateList:[YCHomeAreaOperatorModel] = {return [YCHomeAreaOperatorModel]()}()
    private lazy var recommendList:[YCHomeAreaRecomentModel] = {return [YCHomeAreaRecomentModel]()}()
    
    private lazy var recommentBtnArr:[YCCustomButton] = {return [YCCustomButton]()}()
    private lazy var operatorBtnArr:[UIButton] = {return [UIButton]()}()
    
    
    private lazy var scrollView:UIScrollView = {
        let scrollView = UIScrollView()
        self.addSubview(scrollView)
        self.backgroundColor = UIColor.white
        scrollView.backgroundColor = UIColor.white
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    var viewH:CGFloat = 0
    
    func bindData(operateList:[YCHomeAreaOperatorModel],recommendList:[YCHomeAreaRecomentModel]){
        self.operateList = operateList
        self.recommendList = recommendList
        
        viewH = 0
        
        setupRecommentList()
        setupOperatorList()
        
    }
    
    func setupRecommentList(){
        let COL = 4
        let OPERATOR_BTN_H = 70*APP_SCALE
        let OPEARTOR_BTN_W = (SCREEN_WIDTH - 2*MARGIN_15)/CGFloat(COL)
        if recommentBtnArr.count < recommendList.count {
            for index in recommentBtnArr.count..<recommendList.count {
                let btn = YCCustomButton(type: .topImageBottomTitle)
                btn.titleLabel?.font = FONT_SIZE_11
                recommentBtnArr.append(btn)
                self.addSubview(btn)
                btn.snp.makeConstraints { (make) in
                    make.top.equalToSuperview().offset(MARGIN_5 + CGFloat(index/COL)*(OPERATOR_BTN_H + MARGIN_10))
                    make.left.equalTo(MARGIN_15 + CGFloat(index%COL)*(OPEARTOR_BTN_W))
                    make.width.equalTo(OPEARTOR_BTN_W)
                    make.height.equalTo(OPERATOR_BTN_H)
                }
            }
        }else{
            if recommentBtnArr.count > recommendList.count{
                for index in recommendList.count..<recommentBtnArr.count {
                    let btn = recommentBtnArr[index]
                    btn.isHidden = true
                }
            }
        }
        
        for (index,item) in recommendList.enumerated() {
            let btn = recommentBtnArr[index]
            btn.isHidden = false
            btn.setTitle(item.title, for: UIControl.State.normal)
            if let url = item.image {
                btn.loadImage(imageURL: url, placeholder: nil)
            }
        }
        
        viewH += MARGIN_5 + CGFloat(recommendList.count/COL)*(OPERATOR_BTN_H + MARGIN_10)
    }
    
    func setupOperatorList(){
        let SCROLLVIEW_H = 70*APP_SCALE
        scrollView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(viewH)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(SCROLLVIEW_H)
        }
        viewH += SCROLLVIEW_H
        
        let COL:CGFloat = 3.5
        let BTN_W = (SCREEN_WIDTH - 2*MARGIN_15 - CGFloat(COL-1)*MARGIN_10)/COL
        if operatorBtnArr.count < operateList.count{
            for index in operatorBtnArr.count..<operateList.count{
                let btn = UIButton()
                operatorBtnArr.append(btn)
                scrollView.addSubview(btn)
                btn.snp.makeConstraints { (make) in
                    make.left.equalToSuperview().offset(MARGIN_15 + CGFloat(index)*(BTN_W+MARGIN_10))
                    make.top.equalToSuperview()
                    make.width.equalTo(BTN_W)
                    make.height.equalToSuperview()
                }
            }
        }else {
            if operatorBtnArr.count > operateList.count{
                for index in operateList.count..<operatorBtnArr.count {
                    let btn = operatorBtnArr[index]
                    btn.isHidden = true
                }
            }
        }
        
        for (index,item) in operateList.enumerated(){
            let btn = operatorBtnArr[index]
            btn.isHidden = false
            if let url = item.image {
                btn.loadImage(imageURL: url, placeholder: nil)
            }
            
        }
        scrollView.contentSize = CGSize.init(width: MARGIN_15 + BTN_W * CGFloat(operateList.count) + CGFloat(operateList.count-1)*MARGIN_10 , height: 0)
        
    }
    
}
