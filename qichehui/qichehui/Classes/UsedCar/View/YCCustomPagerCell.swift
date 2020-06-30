//
//  YCCustomPagerCell.swift
//  qichehui
//
//  Created by SMART on 2019/12/7.
//  Copyright © 2019 SMART. All rights reserved.
//

import UIKit
import FSPagerView
let YCCustomPagerCellResueIdentifier = "YCCustomPagerCell"
class YCCustomPagerCell:  FSPagerViewCell{
    
    private lazy var iMageView:UIImageView = {
        let imageView = UIImageView()
        addSubview(imageView)
        return imageView
    }()
    
    var model:YCUsedCarHeaderCartopimageModel?{didSet{setModel()}}
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        iMageView.snp.makeConstraints({ (make) in
            make.left.equalToSuperview().offset(MARGIN_20)
            make.right.equalToSuperview().offset(-MARGIN_20)
            make.top.bottom.equalToSuperview()
        })

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setModel(){
        guard let model = self.model else{return}
        if let url = model.image {
            iMageView.loadImage(imageURL: url, placeholder: nil,radius: 8*APP_SCALE)
        }
    }
}
