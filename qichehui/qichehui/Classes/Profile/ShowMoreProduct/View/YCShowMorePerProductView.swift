//
//  YCShowMorePerProductView.swift
//  qichehui
//
//  Created by SMART on 2019/12/10.
//  Copyright © 2019 SMART. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class YCShowMorePerProductView: UIView {
    private let IMG_VIEW_H = 150*APP_SCALE
    private lazy var imageView:UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8*APP_SCALE
        imageView.clipsToBounds = true
        addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(IMG_VIEW_H)
        }
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = BACK_GROUND_COLOR
        return imageView
    }()
    private lazy var titleLabel:UILabel = {
        let label = UILabel()
        addSubview(label)
        label.textColor = UIColor.darkGray
        label.font = FONT_SIZE_12
        return label
    }()
    
    private lazy var subtitleLabel:UILabel = {
        let label = UILabel()
        addSubview(label)
        return label
    }()
    var model:YCSHowMoreProductModel?{didSet{setModel()}}
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setModel(){
        if let imageUrl = model?.cover {
            imageView.loadImage(imageURL: imageUrl, placeholder: nil)
        }
        
        if let text = model?.name {
            titleLabel.text = text
            titleLabel.sizeToFit()
            titleLabel.snp.makeConstraints { (make) in
                make.top.equalTo(imageView.snp_bottom).offset(MARGIN_10)
                make.left.right.equalToSuperview()
                make.height.equalTo(titleLabel.frame.size.height)
            }
        }
        
        if let coins = model?.coins {
            let attrText = NSMutableAttributedString.init(string: "\(coins)", attributes: [NSAttributedString.Key.font : BOLD_FONT_SIZE_15,NSAttributedString.Key.foregroundColor:UIColor.red])
            attrText.append(NSAttributedString.init(string: "易车币", attributes: [NSAttributedString.Key.font : FONT_SIZE_10,NSAttributedString.Key.foregroundColor:UIColor.lightGray]))
            subtitleLabel.attributedText = attrText
            subtitleLabel.sizeToFit()
            subtitleLabel.snp.makeConstraints { (make) in
                make.top.equalTo(titleLabel.snp_bottom).offset(MARGIN_10)
                make.left.right.equalToSuperview()
                make.height.equalTo(subtitleLabel.frame.size.height)
            }
        }
    }
    
    
}
