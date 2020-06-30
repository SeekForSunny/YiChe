//
//  YCHomeType21Cell.swift
//  qichehui
//
//  Created by SMART on 2019/12/30.
//  Copyright © 2019 SMART. All rights reserved.
//

import UIKit
fileprivate let IMAGE_CONTENT_VIEW_HEIGHT = 70*APP_SCALE
class YCHomeType21Cell: UITableViewCell {
    
    private var cellH:CGFloat = 0
    
    private lazy var titleLabel:UILabel = {
        let label = UILabel()
        self.contentView.addSubview(label)
        return label
    }()
    
    private lazy var imageContentView:UIView = {
        let view = UIView()
        self.contentView.addSubview(view)
        return view
    }()
    
    private lazy var commmentLabel:UILabel = {
        let label = UILabel()
        self.contentView.addSubview(label)
        return label
    }()
    
    private lazy var imageArr:[UIImageView] = {return [UIImageView]()}()
    
    var model:YCHomeModel?{didSet{setModel()}}
    
    class func cellWith(tableView:UITableView)->YCHomeType21Cell{
        var cell = tableView.dequeueReusableCell(withIdentifier: String(describing: YCHomeType21Cell.self))
        if cell == nil {
            cell = YCHomeType21Cell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: String(describing: YCHomeType21Cell.self))
        }
        cell?.selectionStyle = .none
        return cell as! YCHomeType21Cell
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func  initUI(){
        
        for _ in 0..<3{
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageArr.append(imageView)
            self.imageContentView.addSubview(imageView)
        }
    }
    
    func setModel(){
        
        
        if let covers = model?.coverImgs{
            
            if imageArr.count < covers.count {
                for _ in imageArr.count..<covers.count{
                    let imageView = UIImageView()
                    imageView.contentMode = .scaleAspectFill
                    imageView.clipsToBounds = true
                    imageArr.append(imageView)
                    self.imageContentView.addSubview(imageView)
                }
            }else{
                if imageArr.count > covers.count{
                    for index in covers.count..<imageArr.count{
                        let imageView = imageArr[index]
                        imageView.isHidden = true
                    }
                }
            }
            
            if covers.count == 1{
                let image_width = (SCREEN_WIDTH - 2*MARGIN_15)/3
                if let coverURL = covers.first {
                    let imageView = imageArr.first
                    imageView?.isHidden = false
                    imageContentView.snp.remakeConstraints { (make) in
                        make.right.equalToSuperview().offset(-MARGIN_15)
                        make.top.equalToSuperview().offset(MARGIN_15)
                        make.width.equalTo(image_width)
                        make.height.equalTo(IMAGE_CONTENT_VIEW_HEIGHT)
                    }
                    imageView?.snp.remakeConstraints({ (make) in
                        make.edges.equalToSuperview()
                    })
                    imageView?.loadImage(imageURL: coverURL, placeholder: nil){[weak self] in
                        guard let strongSelf = self else{return}
                        strongSelf.imageContentView.makeRoundingCorners(8*APP_SCALE)
                    }
                }
                if let title = model?.title {
                    let maxSize = CGSize.init(width: SCREEN_WIDTH - 2*MARGIN_15 - image_width - MARGIN_15, height: CGFloat(MAXFLOAT))
                    let titleSize = titleLabel.size(text: title, font: FONT_SIZE_15, color: UIColor.darkGray, maxSize: maxSize)
                    titleLabel.snp.makeConstraints { (make) in
                        make.top.equalTo(imageContentView)
                        make.left.equalToSuperview().offset(MARGIN_15)
                        make.size.equalTo(titleSize)
                    }
                }
            }else{
                let maxSize = CGSize.init(width: SCREEN_WIDTH - 2*MARGIN_15, height: CGFloat(MAXFLOAT))
                
                if let title = model?.title {
                    let titleSize = titleLabel.size(text: title, font: FONT_SIZE_15, color: UIColor.darkGray, maxSize: maxSize)
                    
                    titleLabel.snp.remakeConstraints { (make) in
                        make.top.equalToSuperview().offset(MARGIN_15)
                        make.left.equalToSuperview().offset(MARGIN_15)
                        make.size.equalTo(titleSize)
                    }
                }
                
                imageContentView.snp.remakeConstraints { (make) in
                    make.top.equalTo(self.titleLabel.snp_bottom).offset(MARGIN_15)
                    make.left.equalToSuperview().offset(MARGIN_15)
                    make.right.equalToSuperview().offset(-MARGIN_15)
                    make.height.equalTo(IMAGE_CONTENT_VIEW_HEIGHT)
                }
                
                let image_width = (SCREEN_WIDTH - 2*MARGIN_15) / CGFloat(covers.count)
                for (index,cover) in covers.enumerated() {
                    let imageView = imageArr[index]
                    imageView.isHidden = false
                    imageView.snp.remakeConstraints { (make) in
                        make.bottom.equalToSuperview()
                        make.left.equalToSuperview().offset(CGFloat(index)*image_width)
                        make.width.equalTo(image_width)
                        make.height.equalToSuperview()
                    }
                    imageView.loadImage(imageURL: cover, placeholder: nil){[weak self] in
                        guard let strongSelf = self else{return}
                        strongSelf.imageContentView.makeRoundingCorners(8*APP_SCALE)
                    }
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
                
                if let commnentCount = model?.commentCount,commnentCount > 0 {
                    mutiStr.append(NSAttributedString.init(string: " \(commnentCount)评论", attributes: attributes))
                }
                
                commmentLabel.attributedText = mutiStr
                commmentLabel.snp.remakeConstraints { (make) in
                    make.bottom.equalToSuperview().offset(-MARGIN_15)
                    make.left.equalToSuperview().offset(MARGIN_15)
                }
            }
            
        }
    }
    
    class func cellH(model:YCHomeModel){
        let maxSize = CGSize.init(width: SCREEN_WIDTH - 2*MARGIN_15, height: CGFloat(MAXFLOAT))
        var rowHeight:CGFloat = 0
        
        if let covers = model.coverImgs{
            
            if covers.count == 1{
                rowHeight = MARGIN_15 + IMAGE_CONTENT_VIEW_HEIGHT + MARGIN_15
            }else{
                if let title = model.title {
                    let titleSize = title.size(font: FONT_SIZE_15, maxSize: maxSize)
                    rowHeight += MARGIN_15 + titleSize.height
                }
                
                if let _ = model.coverImgs{
                    rowHeight += MARGIN_15 + IMAGE_CONTENT_VIEW_HEIGHT
                }
                
                if let text = model.user?.showname {
                    let textHeight = text.size(font: FONT_SIZE_12, maxSize: maxSize).height
                    rowHeight += MARGIN_10 + textHeight + MARGIN_15
                }
            }
        }

        model.rowHeight = rowHeight
        
    }
    
}
