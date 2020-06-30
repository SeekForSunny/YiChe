//
//  YCHomeType4Cell.swift
//  qichehui
//
//  Created by SMART on 2019/12/30.
//  Copyright © 2019 SMART. All rights reserved.
//

import UIKit
fileprivate let COVER_IMAGE_HEIGHT = 200 * APP_SCALE
class YCHomeType4Cell: UITableViewCell {
    
    private lazy var titleLabel:UILabel = {
        let label = UILabel()
        self.contentView.addSubview(label)
        return label
    }()
    
    private lazy var coverImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        self.contentView.addSubview(imageView)
        imageView.backgroundColor = UIColor.hexadecimalColor(hexadecimal: "#F0F0F0")
        return imageView
    }()
    
    private lazy var playIcon:UIImageView = {
        let iconView = UIImageView()
        self.coverImageView.addSubview(iconView)
        iconView.image = UIImage.init(named: "bpn_card_vedio_play")
        return iconView
    }()
    
    private lazy var playTimeLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.backgroundColor = UIColor.init(white: 0, alpha: 0.2)
        label.font = FONT_SIZE_11
        label.textColor = UIColor.white
        self.coverImageView.addSubview(label)
        return label
    }()
    
    private lazy var commmentLabel:UILabel = {
        let label = UILabel()
        self.contentView.addSubview(label)
        return label
    }()
    
    var model:YCHomeModel?{didSet{setModel()}}
    
    class func cellWith(tableView:UITableView)->YCHomeType4Cell{
        var cell = tableView.dequeueReusableCell(withIdentifier: String(describing: YCHomeType4Cell.self))
        if cell == nil {
            cell = YCHomeType4Cell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: String(describing: YCHomeType4Cell.self))
        }
        cell?.selectionStyle = .none
        return cell as! YCHomeType4Cell
    }
    
    func setModel(){
        let maxSize = CGSize.init(width: SCREEN_WIDTH - 2*MARGIN_15, height: CGFloat(MAXFLOAT))
        if let title = model?.title {
            let textSize = titleLabel.size(text: title, font: FONT_SIZE_15, color: UIColor.darkGray, maxSize: maxSize)
            titleLabel.snp.remakeConstraints { (make) in
                make.top.equalToSuperview().offset(MARGIN_15)
                make.left.equalToSuperview().offset(MARGIN_15)
                make.size.equalTo(textSize)
            }
        }
        
        if let cover = model?.coverImgs?.first{
            coverImageView.snp.remakeConstraints { (make) in
                make.top.equalTo(self.titleLabel.snp_bottom).offset(MARGIN_15)
                make.left.equalToSuperview().offset(MARGIN_15)
                make.right.equalToSuperview().offset(-MARGIN_15)
                make.height.equalTo(COVER_IMAGE_HEIGHT)
            }

            coverImageView.loadImage(imageURL: cover, placeholder: nil,radius: 8*APP_SCALE)
            playIcon.snp.remakeConstraints { (make) in
                make.center.equalToSuperview()
                make.width.height.equalTo(56*APP_SCALE)
            }
        }
        
        if let duration = model?.duration {
            playTimeLabel.text = duration
            playTimeLabel.sizeToFit()
            let textSize = playTimeLabel.frame.size
            playTimeLabel.snp.remakeConstraints { (make) in
                make.right.equalToSuperview().offset(-MARGIN_10)
                make.bottom.equalToSuperview().offset(-MARGIN_10)
                make.size.equalTo(CGSize.init(width: textSize.width + MARGIN_10, height: textSize.height + MARGIN_5))
            }
        }
        
        if let text = model?.user?.showname {
            
            let attributes = [NSAttributedString.Key.font : FONT_SIZE_12,NSAttributedString.Key.foregroundColor:UIColor.lightGray]
            let mutiStr = NSMutableAttributedString.init(string: text, attributes: attributes)
            mutiStr.append(NSAttributedString.init(string: " "))
            if let roles = model?.user?.roles {
                let attachment = NSTextAttachment()
                
                if let _ = roles["yicheaccount"]{
                    attachment.image = UIImage.init(named: "bpk_ico_yv_kong")!
                }
                
                if let _ = roles["organization"]{
                    attachment.image = UIImage.init(named: "bpk_ico_bv_kong")!
                }
                
                if attachment.image != nil {
                    attachment.bounds = CGRect.init(origin: CGPoint.init(x: 0, y: FONT_SIZE_13.descender), size: CGSize.init(width: FONT_SIZE_13.lineHeight, height: FONT_SIZE_13.lineHeight))
                    mutiStr.append(NSAttributedString.init(attachment: attachment))
                }
            }
            
            if let commnentCount = model?.commentCount {
                mutiStr.append(NSAttributedString.init(string: " \(commnentCount)评论", attributes: attributes))
            }
            
            commmentLabel.attributedText = mutiStr
            commmentLabel.snp.remakeConstraints { (make) in
                make.top.equalTo(self.coverImageView.snp_bottom).offset(MARGIN_10)
                make.left.equalToSuperview().offset(MARGIN_15)
            }
        }
        
    }
    
    class func cellH(model:YCHomeModel){
        var rowHeight:CGFloat = 0
        let maxSize = CGSize.init(width: SCREEN_WIDTH - 2*MARGIN_15, height: CGFloat(MAXFLOAT))
        if let title = model.title {
            let titleSize = title.size(font: FONT_SIZE_15, maxSize: maxSize)
            rowHeight += MARGIN_15 + titleSize.height
        }
        
        if let _ = model.coverImgs{
            rowHeight += MARGIN_15 + COVER_IMAGE_HEIGHT
        }
        
        if let text = model.user?.showname {
            let textHeight = text.size(font: FONT_SIZE_13, maxSize: maxSize).height
            rowHeight += MARGIN_10 + textHeight + MARGIN_15
        }
        
        model.rowHeight = rowHeight
        
    }
}
