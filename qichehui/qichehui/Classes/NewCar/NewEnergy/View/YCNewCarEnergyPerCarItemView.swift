//
//  YCNewCarEnergyPerCarItemView.swift
//  qichehui
//
//  Created by SMART on 2020/2/6.
//  Copyright © 2020 SMART. All rights reserved.
//

import UIKit

class YCNewCarEnergyPerCarItemView: UIView {
    
    private lazy var rankView:UIImageView = {
        let imageView = UIImageView()
        self.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var iconView:UIImageView = {
        let imageView = UIImageView()
        self.addSubview(imageView)
        return imageView
    }()
    
    private lazy var nameLabel:UILabel = {
        let label = UILabel()
        label.font = BOLD_FONT_SIZE_15
        self.addSubview(label)
        return label
    }()
    
    private lazy var priceLabel:UILabel = {
        let label = UILabel()
        label.font = FONT_SIZE_13
        label.textColor = UIColor.hexadecimalColor(hexadecimal: "#FC4B41")
        self.addSubview(label)
        return label
    }()
    
    private lazy var priceReduceLabel:UILabel = {
        let label = UILabel()
        label.font = BOLD_FONT_SIZE_15
        label.textColor = UIColor.hexadecimalColor(hexadecimal: "#22BF6A")
        self.addSubview(label)
        return label
    }()
    
    private lazy var reduceRateLabel:UILabel = {
        let label = UILabel()
        label.font = FONT_SIZE_13
        label.textColor = UIColor.hexadecimalColor(hexadecimal: "#22BF6A")
        self.addSubview(label)
        return label
    }()
    
    func bindData(info:YCNewEnergyPriceReduceListInfos,rank:Int){
        
        rankView.image = UIImage(named: "ic_paihang_top"+"\(rank)")
        rankView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(MARGIN_15)
            make.top.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.5)
            make.width.equalTo(30*APP_SCALE)
        }
        
        if let url = info.image {
            iconView.loadImage(imageURL: url)
            iconView.contentMode = .scaleAspectFit
            iconView.snp.makeConstraints { (make) in
                make.left.equalToSuperview().offset(MARGIN_15)
                make.centerY.equalToSuperview()
                make.size.equalTo(CGSize(width: 90*APP_SCALE, height: 90*APP_SCALE))
            }
        }
        
        if let name = info.csShowName {
            nameLabel.text = name
            nameLabel.snp.remakeConstraints { (make) in
                make.bottom.equalTo(self.iconView.snp_centerY).offset(-MARGIN_5)
                make.left.equalTo(iconView.snp_right).offset(MARGIN_15)
            }
        }
        
        if let dealerPrice = info.dealerPrice {
            priceLabel.text = dealerPrice
            priceLabel.snp.makeConstraints { (make) in
                make.top.equalTo(self.iconView.snp_centerY).offset(MARGIN_5)
                make.left.equalTo(nameLabel)
            }
        }
        
        if let dealerCount = info.dealerCount{
            priceReduceLabel.text = "↓ " + String(describing: dealerCount)
            priceReduceLabel.snp.remakeConstraints { (make) in
                make.right.equalToSuperview().offset(-MARGIN_15)
                make.bottom.equalTo(nameLabel)
            }
        }
        
        if let ratio = info.declineRatio{
            reduceRateLabel.text = "降幅" + ratio
            reduceRateLabel.snp.remakeConstraints { (make) in
                make.right.equalTo(priceReduceLabel)
                make.top.equalTo(priceLabel)
            }
        }
    }
}
