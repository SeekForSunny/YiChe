//
//  YCHomeVideoCell.swift
//  qichehui
//
//  Created by SMART on 2020/1/1.
//  Copyright © 2020 SMART. All rights reserved.
//

import UIKit
fileprivate let COVER_IMAGE_HEIGHT = 200 * APP_SCALE
fileprivate let BOOTOM_TOOL_BAR_HEIGHT = 30 * APP_SCALE
fileprivate let V_LOGO_HEIGHT = 15 * APP_SCALE
class YCHomeVideoCell: UITableViewCell {
    
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
    
    private lazy var bottomToolBar:UIView = {
        let toolBar = UIView()
        self.contentView.addSubview(toolBar)
        return toolBar
    }()
    
    private lazy var avatarView:UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        self.bottomToolBar.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview()
            make.width.height.equalTo(BOOTOM_TOOL_BAR_HEIGHT)
        }
        return imageView
    }()
    
    private lazy var userNameLabel:UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = FONT_SIZE_11
        self.bottomToolBar.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(self.avatarView.snp_right).offset(MARGIN_5)
        }
        return label
    }()
    
    private lazy var VIcon:UIImageView = {
        let imageView = UIImageView()
        self.bottomToolBar.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.right.equalTo(self.avatarView)
            make.bottom.equalTo(self.avatarView)
            make.width.height.equalTo(V_LOGO_HEIGHT)
        }
        return imageView
    }()
    
    private lazy var moreBtn:UIButton = {
        let btn = UIButton()
        self.bottomToolBar.addSubview(btn)
        btn.setImage(UIImage.init(named: "bpn_newlist_more"), for: UIControl.State.normal)
        btn.setTitle("0", for: UIControl.State.normal)
        btn.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview()
        }
        return btn
    }()
    
    private lazy var praiseBtn:UIButton = {
        let btn = UIButton()
        self.bottomToolBar.addSubview(btn)
        btn.setImage(UIImage.init(named: "bpn_newlist_zan"), for: UIControl.State.normal)
        btn.setTitle("0", for: UIControl.State.normal)
        btn.titleLabel?.font = FONT_SIZE_11
        btn.imageEdgeInsets.right = MARGIN_5
        btn.setTitleColor(UIColor.lightGray, for: UIControl.State.normal)
        return btn
    }()
    
    private lazy var commentBtn:UIButton = {
        let btn = UIButton()
        self.bottomToolBar.addSubview(btn)
        btn.setImage(UIImage.init(named: "bpn_newlist_pinglun"), for: UIControl.State.normal)
        btn.setTitle("0", for: UIControl.State.normal)
        btn.imageEdgeInsets.right = MARGIN_5
        btn.titleLabel?.font = FONT_SIZE_11
        btn.setTitleColor(UIColor.lightGray, for: UIControl.State.normal)
        return btn
    }()
    
    var model:YCHomeVideoModel?{didSet{setModel()}}
    
    class func cellWith(tableView:UITableView)->YCHomeType4Cell{
        var cell = tableView.dequeueReusableCell(withIdentifier: String(describing: YCHomeType4Cell.self))
        if cell == nil {
            cell = YCHomeType4Cell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: String(describing: YCHomeType4Cell.self))
        }
        cell?.selectionStyle = .none
        return cell as! YCHomeType4Cell
    }
    
    func fixedURL(url:String)->String{
        var url = url.replacingOccurrences(of: "{0}", with: "120")
        if !url.contains("https:"){
            url = "https:" + url
        }
        return url
    }
    
    func setModel(){
        self.selectionStyle = .none
        
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
        
        bottomToolBar.snp.makeConstraints { (make) in
            make.top.equalTo(self.coverImageView.snp_bottom).offset(MARGIN_10)
            make.left.equalToSuperview().offset(MARGIN_15)
            make.right.equalToSuperview().offset(-MARGIN_15)
            make.height.equalTo(BOOTOM_TOOL_BAR_HEIGHT)
        }
        
        if let cover = model?.user?.avatarpath {
            avatarView.loadImage(imageURL: fixedURL(url: cover), placeholder: nil,radius: BOOTOM_TOOL_BAR_HEIGHT*0.5)
        }
        
        if let role = model?.user?.roles {
            var image = UIImage()
            if let _ = role.yicheaccount{
                image = UIImage.init(named: "bpy_user_v_small_y")!
            }
            
            if let _ = role.organization{
                image = UIImage.init(named: "bpy_user_v_small_b")!
            }
            self.VIcon.image = image
        }
        
        if let text = model?.user?.showname {
            userNameLabel.text = text
        }
        
        if let commentCount = model?.commentCount {
            self.commentBtn.setTitle("\(commentCount)", for: UIControl.State.normal)
            commentBtn.sizeToFit()
            let btnSize = commentBtn.frame.size
            commentBtn.snp.remakeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.right.equalTo(self.praiseBtn.snp_left).offset(-MARGIN_30)
                make.size.equalTo(CGSize.init(width: btnSize.width + MARGIN_5, height: btnSize.height))
            }
        }
        
        if let praiseCount = model?.supportCount {
            self.praiseBtn.setTitle("\(praiseCount)", for: UIControl.State.normal)
            praiseBtn.sizeToFit()
            let btnSize = praiseBtn.frame.size
            praiseBtn.snp.remakeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.right.equalTo(self.moreBtn.snp_left).offset(-MARGIN_30)
                make.size.equalTo(CGSize.init(width: btnSize.width + MARGIN_5, height: btnSize.height))
            }
        }
        
    }
    
    class func cellH(model:YCHomeVideoModel){
        var rowHeight:CGFloat = 0
        let maxSize = CGSize.init(width: SCREEN_WIDTH - 2*MARGIN_15, height: CGFloat(MAXFLOAT))
        if let title = model.title {
            let titleSize = title.size(font: FONT_SIZE_15, maxSize: maxSize)
            rowHeight += MARGIN_15 + titleSize.height
        }
        
        if let _ = model.coverImgs{
            rowHeight += MARGIN_15 + COVER_IMAGE_HEIGHT
        }
        
        rowHeight += MARGIN_10 + BOOTOM_TOOL_BAR_HEIGHT + MARGIN_15
        
        model.rowHeight = rowHeight
        
    }
    
}
