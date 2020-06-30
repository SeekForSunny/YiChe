//
//  YCUsedCarFavorView.swift
//  qichehui
//
//  Created by SMART on 2019/12/8.
//  Copyright © 2019 SMART. All rights reserved.
//

import UIKit

class YCUsedCarFavorView: UIView {
    
    private lazy var iView:UIImageView = {
        let imageView = UIImageView()
        addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.6)
        }
        return imageView
    }()
    
    private lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.font = BOLD_FONT_SIZE_12
        label.textColor = UIColor.darkGray
        label.lineBreakMode = .byTruncatingTail
        addSubview(label)
        return label
    }()
    
    private lazy var priceLabel:UILabel = {
        let label = UILabel()
        label.font = FONT_SIZE_10
        label.textColor = UIColor.red
        addSubview(label)
        return label
    }()
    
    private lazy var subtitleLabel:UILabel = {
        let label = UILabel()
        label.font = FONT_SIZE_10
        label.textColor = UIColor.lightGray
        label.lineBreakMode = .byTruncatingTail
        addSubview(label)
        label.sizeToFit()
        return label
    }()
    
    var model:YCUsedCarguessFavorVoListModel?{didSet{setModel()}}
    func setModel(){
        
        guard let model = model else{return}
        
        if let imageUrl = model.coverUrl {
            iView.loadImage(imageURL: imageUrl, placeholder: nil,radius: 8*APP_SCALE)
        }
        
        let title = "\(model.serialName ?? "") \(model.carName ?? "")"
        titleLabel.text = title
        titleLabel.sizeToFit()
        let size = titleLabel.frame.size
        titleLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.iView.snp_bottom).offset(MARGIN_5)
            make.height.equalTo(size.height)
        }
        
        let price = "\(model.displayPrice ?? "") \("万")"
        priceLabel.text = price
        priceLabel.sizeToFit()
        let priceLabelsize = priceLabel.frame.size
        priceLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalTo(self.titleLabel.snp_bottom).offset(MARGIN_5)
            make.size.equalTo(priceLabelsize)
        }
        
        
        let subtitle = "\(model.licenseDate ?? "") \("/") \(model.drivingMileage ?? "")"
        subtitleLabel.text = subtitle
        subtitleLabel.sizeToFit()
        let subtitleSize = subtitleLabel.frame.size
        subtitleLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.priceLabel.snp_bottom).offset(MARGIN_5)
            make.height.equalTo(subtitleSize.height)
        }
        
    }
    
}
