//
//  YCNewCarNewEnergyRecommendHeaderView.swift
//  qichehui
//
//  Created by SMART on 2020/2/8.
//  Copyright © 2020 SMART. All rights reserved.
//

import UIKit

class YCNewCarNewEnergyRecommendHeaderView: UIView {

    let viewH:CGFloat = 80*APP_SCALE
    private lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.font = BOLD_FONT_SIZE_18
        self.addSubview(label)
        return label
    }()
    
    private lazy var imageView:UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFit
        self.addSubview(imageView)
        return imageView
    }()
    
    func bindData(){
        
        imageView.image = UIImage(named: "BPC_XinNengYuanzdm")
        imageView.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-MARGIN_15)
            make.top.equalToSuperview()
            make.height.equalTo(viewH)
            make.width.equalTo(120*APP_SCALE)
        }
        
        titleLabel.text = "沈腾推荐您买"
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(MARGIN_15)
        }
    }

}
