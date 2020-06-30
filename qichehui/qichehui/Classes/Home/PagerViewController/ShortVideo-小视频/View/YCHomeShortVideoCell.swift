//
//  YCHomeShortVideoCell.swift
//  qichehui
//
//  Created by SMART on 2020/1/15.
//  Copyright © 2020 SMART. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

let itemWidth = (SCREEN_WIDTH - 2*MARGIN_15 - MARGIN_10)/2

class YCHomeShortVideoCell: UICollectionViewCell {
    
    var model:Any?{didSet{setModel()}}
    
    private lazy var iView:UIImageView = {
        let iView = UIImageView()
        self.contentView.addSubview(iView)
        return iView
    }()
    
    private lazy var titleLabel:UILabel = {
        let label = UILabel()
        self.contentView.addSubview(label)
        return label
    }()
    
    private lazy var topicBtn: UIButton = {
        let btn = UIButton()
        self.contentView.addSubview(btn)
        btn.titleLabel?.font = FONT_SIZE_10
        btn.setTitleColor(UIColor.darkGray, for: UIControl.State.normal)
        btn.backgroundColor = UIColor.hexadecimalColor(hexadecimal: "#FBF7FC")
        btn.layer.cornerRadius = (FONT_SIZE_10.lineHeight + MARGIN_10) * 0.5
        btn.clipsToBounds = true
        return btn
    }()
    
    private lazy var avatarView:UIImageView = {
        let avatarView = UIImageView()
        self.contentView.addSubview(avatarView)
        return avatarView
    }()
    
    private lazy var showNameLabel:UILabel = {
        let label = UILabel()
        label.font = FONT_SIZE_10
        label.textColor = UIColor.white
        self.contentView.addSubview(label)
        return label
    }()
    
    private lazy var playcountLabel:UILabel = {
        let label = UILabel()
        self.contentView.addSubview(label)
        label.textColor = .white
        label.font = FONT_SIZE_10
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI(){
        self.backgroundColor = UIColor.white
    }
    
    func setModel(){
        guard let model = model else {return}
        
        if (model as AnyObject).isKind(of: YCHomeShortVideoListModel.self){
            if let model = model as? YCHomeShortVideoListModel{
                let maxSize = CGSize(width: itemWidth, height: CGFloat(MAXFLOAT))
                if let cover = model.imageUrl {
                    
                    iView.loadImage(imageURL: cover, placeholder: nil,radius: 8*APP_SCALE)
                    
                    iView.snp.remakeConstraints{ (make) in
                        make.left.right.top.width.equalToSuperview()
                        make.height.equalTo(model.imageH)
                    }
                }
                
                if let avatarURL = model.userImage {
                    
                    avatarView.loadImage(imageURL: avatarURL, placeholder: nil,radius: 15*APP_SCALE*0.5)
                    avatarView.snp.makeConstraints { (make) in
                        make.left.equalTo(iView).offset(MARGIN_5)
                        make.bottom.equalTo(iView).offset(-MARGIN_5)
                        make.height.width.equalTo(15*APP_SCALE)
                    }
                }
                
                if let showname = model.userName {
                    showNameLabel.text = showname
                    showNameLabel.snp.remakeConstraints { (make) in
                        make.left.equalTo(avatarView.snp_right).offset(MARGIN_5)
                        make.centerY.equalTo(avatarView)
                    }
                }
                
                if let playCount = model.viewNumber {
                    playcountLabel.text = String(describing:playCount)
                    playcountLabel.snp.makeConstraints { (make) in
                        make.right.equalTo(iView).offset(-MARGIN_5)
                        make.centerY.equalTo(avatarView)
                    }
                }
                
                if let title = model.title{
                    let titleSize =  titleLabel.size(text: title, font: FONT_SIZE_13, color: UIColor.darkGray, maxSize: maxSize, numberOfLine: 2)
                    titleLabel.snp.remakeConstraints { (make) in
                        make.top.equalTo(iView.snp_bottom).offset(MARGIN_5)
                        make.left.equalTo(iView)
                        make.size.equalTo(CGSize(width: maxSize.width, height: titleSize.height))
                    }
                    titleLabel.isHidden = false
                }else{
                    titleLabel.isHidden = true
                }
                
                if let topic = model.topicName {
                    topicBtn.setImage(UIImage(named:"bpv_topic"), for: UIControl.State.normal)
                    topicBtn.setTitle(topic, for: UIControl.State.normal)
                    topicBtn.sizeToFit()
                    let btnSize = topicBtn.frame.size
                    topicBtn.snp.remakeConstraints { (make) in
                        make.top.equalTo(titleLabel.snp_bottom).offset(MARGIN_5)
                        make.left.equalTo(titleLabel)
                        make.height.equalTo(FONT_SIZE_10.lineHeight + MARGIN_10)
                        make.width.equalTo(btnSize.width + MARGIN_10)
                    }
                    topicBtn.isHidden = false
                }else{
                    topicBtn.isHidden = true
                }
                
                iView.isHidden = false
                titleLabel.isHidden = false
                avatarView.isHidden = false
                showNameLabel.isHidden = false
                playcountLabel.isHidden = false
                
            }
            
        }
        
        if (model as AnyObject).isKind(of: YCHomeShortVideoStreamModel.self){
            if let model = model as? YCHomeShortVideoStreamModel{
                if let cover = model.image, cover.count > 0 {
                    iView.loadImage(imageURL: cover, placeholder: nil,radius: 8*APP_SCALE)
                    iView.snp.remakeConstraints{ (make) in
                        make.left.right.top.width.equalToSuperview()
                        make.height.equalTo(model.imageH)
                    }
                    iView.isHidden = false
                }else{
                    iView.isHidden = true
                }
                titleLabel.isHidden = true
                topicBtn.isHidden = true
                avatarView.isHidden = true
                showNameLabel.isHidden = true
                playcountLabel.isHidden = true
                
            }
        }
    }
    
    class func rowHeight(model:Any){
        let maxSize = CGSize(width: itemWidth, height: CGFloat(MAXFLOAT))
        
        if (model as AnyObject).isKind(of: YCHomeShortVideoListModel.self){
            if let model = model as? YCHomeShortVideoListModel {
                
                let height =  model.imageHight!
                let width = model.imageWidth!
                let rate = width/itemWidth
                let iHeight = height / rate
                model.imageH = iHeight
                model.rowHeight += iHeight
                
                if let title = model.title{
                    let titleSize = title.size(font: FONT_SIZE_13, maxSize: maxSize)
                    model.rowHeight += titleSize.height + MARGIN_5
                }
                
                if let topic = model.topicName {
                    let topicSize = topic.size(font: FONT_SIZE_10, maxSize: maxSize)
                    model.rowHeight += topicSize.height + MARGIN_10 + MARGIN_5
                }
            }
        }
        
        if (model as AnyObject).isKind(of: YCHomeShortVideoStreamModel.self){
            if let model = model as? YCHomeShortVideoStreamModel{
                let height:CGFloat =  217
                let width:CGFloat = 217
                let rate = width/itemWidth
                
                let iHeight = height / rate
                
                model.imageH = iHeight
                model.rowHeight = iHeight
            }
        }
        
    }
    
}
