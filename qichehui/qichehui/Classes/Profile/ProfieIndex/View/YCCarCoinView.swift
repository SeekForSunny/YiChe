//
//  YCCarCoinView.swift
//  qichehui
//
//  Created by SMART on 2019/12/4.
//  Copyright © 2019 SMART. All rights reserved.
//

import UIKit

class YCCarCoinView: UIView {

    private let SCROLL_VIEW_H:CGFloat = 130*APP_SCALE
    private var btnArr:[YCCarCoinButton] = [YCCarCoinButton]()
    
    var viewH:CGFloat = 0
    private var titleH:CGFloat = 0
    var models:[YCProfileCarCoinModel]?{didSet{setCarCoinModels()}}
    
    // 顶部分割线
    lazy var topLineView:UIView = {
        let lineView = UIView()
        lineView.backgroundColor = BACK_GROUND_COLOR
        return lineView
    }()
    
    // 底部分割线
    lazy var bottomLineView:UIView = {
        let lineView = UIView()
        lineView.backgroundColor = BACK_GROUND_COLOR
        return lineView
    }()
    
    // 标题
    lazy var titleLab:UILabel = {
        let label = UILabel()
        label.text = "车币商城";
        label.textColor = UIColor.darkGray
        label.font = BOLD_FONT_SIZE_18
        return label
    }()
    
    // 更多新品
    private lazy var moreBtn:UIButton = {
        let btn = YCCustomButton(type: .leftTitleRightImage)
        btn.backgroundColor = .randomColor()
        btn.marginScale = 0
        let title = "更多新品"
        btn.setTitle(title, for: UIControl.State.normal)
        btn.setTitleColor(UIColor.darkGray, for: UIControl.State.normal)
        btn.titleLabel?.font = FONT_SIZE_11
        btn.setImage(UIImage.init(named: "bpl_gray_arrow_right"), for: UIControl.State.normal)
        btn.addTarget(self, action: #selector(showMore), for: UIControl.Event.touchUpInside)
        addSubview(btn)
        btn.snp.makeConstraints { (make) in
            make.centerY.equalTo(titleLab)
            make.right.equalToSuperview().offset(-MARGIN_20)
            make.height.equalTo(30*APP_SCALE)
            make.width.equalTo(60*APP_SCALE)
        }
        return btn
    }()
    
    //滚动视图View
    lazy var scrollView:UIScrollView = { return UIScrollView() }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    func showMore(){
        NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "showMore"), object: nil)
    }
    
    func setupUI(){
        
        backgroundColor = UIColor.white
        
        // 顶部分割线
        addSubview(topLineView)
        topLineView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(MARGIN_5)
        }
        
        
        //标题
        addSubview(titleLab)
        titleLab.sizeToFit()
        let titleH = titleLab.frame.height
        titleLab.snp.makeConstraints { (make) in
            make.top.equalTo(topLineView.snp_bottom).offset(MARGIN_20)
            make.left.equalToSuperview().offset(MARGIN_20)
            make.height.equalTo(titleH)
        }
        self.titleH = titleH
        
        
        //滚动视图
        addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalTo(titleLab.snp_bottom).offset(MARGIN_15)
            make.right.equalToSuperview()
            make.height.equalTo(SCROLL_VIEW_H)
        }
        scrollView.backgroundColor = UIColor.white
        scrollView.showsHorizontalScrollIndicator = false
        
        
        addSubview(bottomLineView)
        bottomLineView.snp.makeConstraints { (make) in
            make.top.equalTo(scrollView.snp_bottom).offset(MARGIN_10)
            make.left.right.equalToSuperview()
            make.height.equalTo(MARGIN_5)
        }
        
    }
    
    func setCarCoinModels(){
        viewH = 0
        guard let models = models else { return  }
        viewH += MARGIN_5
        viewH += MARGIN_5 + MARGIN_10
        viewH += MARGIN_15 + SCROLL_VIEW_H
        viewH += MARGIN_20 + titleH
        moreBtn.backgroundColor = UIColor.white
        
        let BTN_W = SCREEN_WIDTH / 4.3
        let BTN_MARGIN = MARGIN_10
        
        
        if btnArr.count < models.count{
            for _ in btnArr.count ..< models.count {
                let btn = YCCarCoinButton()
                btnArr.append(btn)
                scrollView.addSubview(btn)
            }
        }else{
            for index in  models.count ..< btnArr.count {
                let btn = btnArr[index]
                btn.isHidden = true
            }
        }
        
        for (index,model) in models.enumerated(){
            let btn = btnArr[index]
            btn.model = model
            btn.snp.makeConstraints { (make) in
                make.left.equalToSuperview().offset(MARGIN_20 + CGFloat(index)*(BTN_W+BTN_MARGIN))
                make.top.equalToSuperview()
                make.width.equalTo(BTN_W)
                make.height.equalToSuperview()
            }
            
        }
        scrollView.contentSize = CGSize.init(width: 2*MARGIN_20 + CGFloat(models.count) * BTN_W + CGFloat(models.count-1) * MARGIN_10, height: 0)
        
    }
    
}
