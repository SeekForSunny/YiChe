//
//  YCCarCoinButton.swift
//  qichehui
//
//  Created by SMART on 2019/12/4.
//  Copyright © 2019 SMART. All rights reserved.
//

import UIKit

class YCCarCoinButton: UIView {
    
    var model:YCProfileCarCoinModel? {didSet {setModel()}}
    
    // 图片
    lazy var imageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    // 标识
    lazy var flagLabel:UILabel = {
        let label = UILabel()
        label.font = FONT_SIZE_11
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.hexadecimalColor(hexadecimal: "#3069FF")
        label.layer.cornerRadius = 3*APP_SCALE
        label.textAlignment = .center
        return label
    }()
    
    // 标题
    lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGray
        label.font = FONT_SIZE_12
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .center
        return label
    }()
    
    // 子标题
    lazy var subTitleLabel:UILabel = {
        let label = UILabel()
        label.font = FONT_SIZE_11
        label.textColor = THEME_COLOR
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    func setupUI(){
        
        backgroundColor = UIColor.white
        
        addSubview(flagLabel)
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(subTitleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setModel(){
        
        if let url = model?.cover {
            imageView.loadImage(imageURL: url, placeholder: nil)
            imageView.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(MARGIN_10)
                make.centerX.equalToSuperview()
                make.height.width.equalToSuperview().multipliedBy(0.6)
            }
        }
        
        if let label = model?.labels?.first?["name"] as? String{
            flagLabel.isHidden = false
            addSubview(flagLabel)
            flagLabel.text = label
            flagLabel.sizeToFit()
            let iW = flagLabel.frame.size.width + MARGIN_10
            let iH = flagLabel.frame.size.height + MARGIN_5
            flagLabel.layer.masksToBounds = true
            flagLabel.snp.makeConstraints { (make) in
                make.left.equalToSuperview().offset(MARGIN_5)
                make.top.equalTo(imageView)
                make.width.equalTo(iW)
                make.height.equalTo(iH)
            }
        }else{
            flagLabel.isHidden = true
        }
        
        if let title = model?.name {
            addSubview(titleLabel)
            titleLabel.text = title
            titleLabel.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.top.equalTo(imageView.snp_bottom).offset(MARGIN_5)
                make.left.equalToSuperview()
                make.right.equalToSuperview()
            }
        }
        
        if let subTitle = model?.coins {
            addSubview(subTitleLabel)
            subTitleLabel.snp.makeConstraints { (make) in
                make.top.equalTo(titleLabel.snp_bottom).offset(MARGIN_5)
                make.centerX.equalToSuperview()
            }
            subTitleLabel.text = "\(subTitle)车币"
        }
    }
    
    
}
