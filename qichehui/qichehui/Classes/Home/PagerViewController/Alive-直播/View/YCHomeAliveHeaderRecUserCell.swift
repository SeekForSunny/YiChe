//
//  YCHomeAliveHeaderRecUserCell.swift
//  qichehui
//
//  Created by SMART on 2020/1/14.
//  Copyright © 2020 SMART. All rights reserved.
//

import UIKit

class YCHomeAliveHeaderRecUserCell: UICollectionViewCell {
    
    var model:YCHomeLiveRecommentUserModel?{didSet{setModel()}}
    
    private lazy var avatarView:UIImageView = {
        let imageView = UIImageView()
        self.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(MARGIN_5)
            make.left.right.equalToSuperview()
            make.height.equalTo(self.snp_width)
        }
        return imageView
    }()
    
    private lazy var showNameLabel:UILabel = {
        let label = UILabel()
        self.addSubview(label)
        label.textAlignment = .center
        label.textColor = UIColor.darkGray
        label.font = FONT_SIZE_10
        label.snp.makeConstraints { (make) in
            make.top.equalTo(self.avatarView.snp_bottom).offset(MARGIN_5)
            make.left.right.equalToSuperview()
        }
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI() {}
    
    func setModel(){
        guard let model = model else{return}
        
        if let cover = model.avatarpath {
            avatarView.loadImage(imageURL: fixedURL(cover), placeholder: nil,radius: self.width)
        }
        
        if let showname = model.showname {
            showNameLabel.text = showname
        }
    }
    
    func fixedURL(_ url:String)->String{
        // http://img4.baa.bitautotech.com/newavatar/2019/08/27/17396769_120_0344ec13-94b9-4044-aa1d-24963f3a9290.jpg
        var url = url.replacingOccurrences(of: "{0}", with: "120")
        if !url.contains("http:"){
            url = "http:" + url
        }
        return url
    }
    
}
