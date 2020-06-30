//
//  YCHomeShortVideoTagView.swift
//  qichehui
//
//  Created by SMART on 2020/1/15.
//  Copyright © 2020 SMART. All rights reserved.
//

import UIKit

class YCHomeShortVideoTagView: UIView {

    private var model:YCHomeShortVideoTagsModel?
    internal lazy var backgoundView:UIImageView = {
        let imageView = UIImageView()
        self.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var iconView:UIImageView = {
        let imageView = UIImageView()
        self.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(MARGIN_5)
            make.width.height.equalTo(15*APP_SCALE)
        }
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "bpn_autoShow_top_white")
        return imageView
    }()
    
    private lazy var titleLabel:UILabel = {
        let label = UILabel()
        self.addSubview(label)
        label.textColor = UIColor.white
        label.font = BOLD_FONT_SIZE_18
        label.numberOfLines = 0
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI(){}
    
    func bindData(model:YCHomeShortVideoTagsModel,backgoundImageName:String){
        self.model = model
        
        backgoundView.image = UIImage(named: backgoundImageName)
        
        if let title = model.title {
            titleLabel.text = title
            titleLabel.snp.makeConstraints { (make) in
                make.left.equalToSuperview().offset(MARGIN_5)
                make.top.equalTo(iconView.snp_bottom).offset(MARGIN_5)
                make.right.equalToSuperview().offset(-MARGIN_5)
            }
        }
        
    }

}
