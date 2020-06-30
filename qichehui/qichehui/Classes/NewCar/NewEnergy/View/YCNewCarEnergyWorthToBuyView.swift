//
//  YCNewCarEnergyWorthToBuyView.swift
//  qichehui
//
//  Created by SMART on 2020/2/8.
//  Copyright © 2020 SMART. All rights reserved.
//

import UIKit

class YCNewEnergyLeftInfoView:UIView{
    private lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.font = BOLD_FONT_SIZE_13
        label.textColor = .darkGray
        self.addSubview(label)
        return label
    }()
    
    private lazy var subtitleLabel:UILabel = {
        let label = UILabel()
        label.font = FONT_SIZE_11
        label.textColor = .lightGray
        self.addSubview(label)
        return label
    }()
    
    private lazy var infoButton:UIButton = {
        let btn = UIButton()
        self.addSubview(btn)
        return btn
    }()
    
    private lazy var imageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        self.addSubview(imageView)
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 8*APP_SCALE
        self.backgroundColor = UIColor.hexadecimalColor(hexadecimal: "#F5F5F5")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bindData(_ info:YCNewEnergyWorthToBuyModel){
        
        if let title = info.title {
            titleLabel.text = title
            titleLabel.snp.remakeConstraints { (make) in
                make.top.equalToSuperview().offset(MARGIN_10)
                make.left.equalToSuperview().offset(MARGIN_10)
                make.right.equalToSuperview().offset(-MARGIN_10)
            }
        }
        
        if let subtitle = info.subTitle{
            subtitleLabel.text = subtitle
            subtitleLabel.snp.remakeConstraints { (make) in
                make.top.equalTo(titleLabel.snp_bottom).offset(MARGIN_5)
                make.left.right.equalTo(titleLabel)
            }
        }
        
        if let url = info.image {
            imageView.loadImage(imageURL: url)
            imageView.snp.remakeConstraints { (make) in
                make.left.equalToSuperview().offset(MARGIN_10)
                make.right.equalToSuperview()
                make.top.equalTo(subtitleLabel.snp_bottom).offset(MARGIN_15)
                make.bottom.equalToSuperview()
            }
        }
        
    }
}

class YCNewCarEnergyRightView:UIView {
    private lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.font = BOLD_FONT_SIZE_13
        label.textColor = .darkGray
        self.addSubview(label)
        return label
    }()
    
    private lazy var subtitleLabel:UILabel = {
        let label = UILabel()
        label.font = FONT_SIZE_11
        label.textColor = .lightGray
        self.addSubview(label)
        return label
    }()
    
    private lazy var infoButton:UIButton = {
        let btn = UIButton()
        self.addSubview(btn)
        return btn
    }()
    
    private lazy var imageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        self.addSubview(imageView)
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 8*APP_SCALE
        self.backgroundColor = UIColor.hexadecimalColor(hexadecimal: "#F5F5F5")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bindData(_ info:YCNewEnergyWorthToBuyModel){
        
        if let title = info.title {
            titleLabel.text = title
            titleLabel.sizeToFit()
            let textSize = titleLabel.frame.size
            titleLabel.snp.remakeConstraints { (make) in
                make.top.left.equalToSuperview().offset(MARGIN_10)
                make.size.equalTo(textSize)
            }
        }
        
        if let subtitle = info.subTitle{
            subtitleLabel.text = subtitle
            subtitleLabel.sizeToFit()
            let textSize = subtitleLabel.frame.size
            subtitleLabel.snp.remakeConstraints { (make) in
                make.left.equalTo(titleLabel)
                make.top.equalTo(titleLabel.snp_bottom).offset(MARGIN_5)
                make.size.equalTo(textSize)
            }
        }
        
        if let url = info.image {
            imageView.loadImage(imageURL: url)
            imageView.snp.remakeConstraints { (make) in
                make.bottom.right.equalToSuperview()
                make.left.equalTo(titleLabel.snp_right).offset(MARGIN_5)
                make.top.equalTo(subtitleLabel)
            }
        }
    }
}

class YCNewCarEnergyWorthToBuyView: UIView {
    var viewH:CGFloat = 0
    
    private lazy var leftInfoView:YCNewEnergyLeftInfoView = {
        let view = YCNewEnergyLeftInfoView()
        self.addSubview(view)
        return view
    }()
    
    private lazy var rightTopInfoView:YCNewCarEnergyRightView = {
        let view = YCNewCarEnergyRightView()
        self.addSubview(view)
        return view
    }()
    
    private lazy var rightBottomInfoView:YCNewCarEnergyRightView = {
        let view = YCNewCarEnergyRightView()
        self.addSubview(view)
        return view
    }()
    
    private lazy var showMoreBtn:UIButton = {
        let btn = UIButton()
        self.addSubview(btn)
        btn.setTitle("查看更多", for: UIControl.State.normal)
        btn.backgroundColor = UIColor.hexadecimalColor(hexadecimal: "#F5F5F5")
        btn.titleLabel?.font = FONT_SIZE_13
        btn.setTitleColor(UIColor.darkGray, for: UIControl.State.normal)
        btn.layer.cornerRadius = 8*APP_SCALE
        return btn
    }()
    
    func bindData(infos:[YCNewEnergyWorthToBuyModel],showMore:Bool = true){
        setupInfoView(infos)
        if showMore {
            setupShowMore()
        }
    }
    
    func setupInfoView(_ infos:[YCNewEnergyWorthToBuyModel]){
        for (index,info) in infos.enumerated() {
            if index == 0{
                leftInfoView.bindData(info)
                leftInfoView.snp.makeConstraints { (make) in
                    make.left.equalToSuperview().offset(MARGIN_15)
                    make.top.equalToSuperview()
                    make.width.equalToSuperview().multipliedBy(0.35)
                    make.height.equalTo(170*APP_SCALE)
                }
            }else if index == 1{
                rightTopInfoView.bindData(info)
                rightTopInfoView.snp.makeConstraints { (make) in
                    make.left.equalTo(leftInfoView.snp_right).offset(MARGIN_10)
                    make.top.equalTo(leftInfoView)
                    make.right.equalToSuperview().offset(-MARGIN_15)
                    make.bottom.equalTo(leftInfoView.snp_centerY).offset(-MARGIN_5)
                }
            }else if index == 2{
                rightBottomInfoView.bindData(info)
                rightBottomInfoView.snp.makeConstraints { (make) in
                    make.left.equalTo(leftInfoView.snp_right).offset(MARGIN_10)
                    make.bottom.equalTo(leftInfoView)
                    make.right.equalToSuperview().offset(-MARGIN_15)
                    make.top.equalTo(leftInfoView.snp_centerY).offset(MARGIN_5)
                }
            }
        }
        viewH += 170*APP_SCALE
    }
    
    func setupShowMore(){
        showMoreBtn.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(self.viewH + MARGIN_20)
            make.left.equalToSuperview().offset(MARGIN_15)
            make.right.equalToSuperview().offset(-MARGIN_15)
            make.height.equalTo(35*APP_SCALE)
        }
        self.viewH += MARGIN_20 + 35*APP_SCALE
        showMoreBtn.addTarget(self, action: #selector(showMore), for: UIControl.Event.touchUpInside)
    }
    
    @objc
    func showMore(){}
    
}
