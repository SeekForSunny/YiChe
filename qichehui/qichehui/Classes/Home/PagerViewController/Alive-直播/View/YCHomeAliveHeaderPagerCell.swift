//
//  YCHomeAliveHeaderPagerCell.swift
//  qichehui
//
//  Created by SMART on 2020/1/12.
//  Copyright © 2020 SMART. All rights reserved.
//

import UIKit
import FSPagerView
class YCHomeAliveHeaderPagerCell: FSPagerViewCell {
    
    var model:YCHomeLiveFocusModel?{didSet{setModel()}}
    private lazy var coverImageView:UIImageView = {
        let imageView = UIImageView()
        self.addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.snp.makeConstraints({ (make) in
            make.edges.equalToSuperview()
        })
        return imageView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI(){}
    
    func setModel(){
        guard let model = model else{return}
        if let cover = model.coverImgs?.first {
            coverImageView.loadImage(imageURL: cover, placeholder: nil,radius: 15*APP_SCALE)
        }
    }
}
