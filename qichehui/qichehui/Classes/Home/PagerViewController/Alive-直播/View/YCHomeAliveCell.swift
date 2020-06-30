//
//  YCHomeAliveCell.swift
//  qichehui
//
//  Created by SMART on 2020/1/11.
//  Copyright © 2020 SMART. All rights reserved.
//

import UIKit

class YCHomeAliveCell: UITableViewCell {
    
    var model:YCHomeAliveListModel?{didSet{setModel()}}
    
    private lazy var titleLabel:UILabel = {
        let label = UILabel();
        self.contentView.addSubview(label);
        return label
    }();
    
    private lazy var coverImage:UIImageView = {
        let imageView = UIImageView()
        self.contentView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp_bottom).offset(MARGIN_10)
            make.left.equalToSuperview().offset(MARGIN_15)
            make.right.equalToSuperview().offset(-MARGIN_15)
            make.height.equalTo(200*APP_SCALE)
        }
        return imageView
    }()
    private lazy var userLabel:UILabel = {
        let label = UILabel()
        self.contentView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(MARGIN_15)
            make.top.equalTo(coverImage.snp_bottom).offset(MARGIN_10)
        }
        return label;
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setModel(){
        guard  let model = model else {
            return
        }
        
        let maxSize = CGSize.init(width: SCREEN_WIDTH - 2*MARGIN_15, height: CGFloat(MAXFLOAT))
        if let title = model.title {
           let titleSize = titleLabel.size(text: title, font: FONT_SIZE_15, color: UIColor.darkGray, maxSize: maxSize, numberOfLine: 1)
            titleLabel.snp.remakeConstraints { (make) in
                make.top.equalToSuperview().offset(MARGIN_15)
                make.left.equalToSuperview().offset(MARGIN_15)
                make.right.equalToSuperview().offset(-MARGIN_15)
                make.height.equalTo(titleSize.height)
            }
        }
        
        if let cover = model.coverImgs?.first {
            coverImage.loadImage(imageURL: cover, placeholder: nil,radius: 15*APP_SCALE)
        }
        
        if let userName = model.user?.showname {
            
            let attachment = NSTextAttachment()
            attachment.image = UIImage(named: "bpk_ico_v_author")
            attachment.bounds = CGRect.init(x: 0, y: FONT_SIZE_12.descender, width: FONT_SIZE_13.lineHeight, height: FONT_SIZE_12.lineHeight)
            let mutiStr = NSMutableAttributedString.init(string: userName)
            mutiStr.append(NSAttributedString.init(string: " "))
            mutiStr.append(NSAttributedString.init(attachment: attachment))
            mutiStr.addAttributes([NSAttributedString.Key.font : FONT_SIZE_12,NSAttributedString.Key.foregroundColor:UIColor.lightGray], range: NSRange.init(location: 0, length: mutiStr.length))
            
            userLabel.attributedText = mutiStr
            
        }
        
        
    }
    
}
