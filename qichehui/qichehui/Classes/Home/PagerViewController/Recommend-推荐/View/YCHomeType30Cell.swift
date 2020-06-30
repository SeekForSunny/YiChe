//
//  YCHomeType30Cell.swift
//  qichehui
//
//  Created by SMART on 2020/1/5.
//  Copyright © 2020 SMART. All rights reserved.
//

import UIKit
fileprivate let IMAGE_CONTENT_H = 170*APP_SCALE
fileprivate let IMAGE_CONTENT_W = SCREEN_WIDTH - 2*MARGIN_15
class YCHomeType30Cell: UITableViewCell {
    
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
    
    private lazy var userLabel:UILabel = {
        let label = UILabel()
        self.contentView.addSubview(label)
        return label
    }()
    
    private lazy var imageViewArr:[UIImageView] = {return [UIImageView]() }()
    
    var model:YCHomeModel?{didSet{setModel()}}
    class func cellWith(tableView:UITableView)->YCHomeType30Cell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: String(describing: YCHomeType30Cell.self))
        if cell == nil {
            cell = YCHomeType30Cell.init(style: YCHomeType30Cell.CellStyle.default, reuseIdentifier: String(describing: YCHomeType30Cell.self))
        }
        cell?.selectionStyle = .none
        return cell as! YCHomeType30Cell
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func  initUI(){
        
        for index in 0..<3 {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.backgroundColor = UIColor.hexadecimalColor(hexadecimal: "#F0F0F0")
            imageView.clipsToBounds = true
            imageContentView.addSubview(imageView)
            imageViewArr.append(imageView)
            if index == 0{
                imageView.snp.makeConstraints { (make) in
                    make.top.left.equalToSuperview()
                    make.height.equalToSuperview()
                    make.width.equalToSuperview().multipliedBy(0.7)
                }
            }else if index == 1 {
                imageView.snp.makeConstraints { (make) in
                    make.top.right.equalToSuperview()
                    make.height.equalToSuperview().multipliedBy(0.5)
                    make.left.equalTo(imageViewArr[0].snp_right).offset(APP_SCALE)
                    
                }
            }else{
                imageView.snp.makeConstraints { (make) in
                    make.bottom.right.equalToSuperview()
                    make.top.equalTo(imageViewArr[1].snp_bottom).offset(APP_SCALE)
                    make.left.equalTo(imageViewArr[0].snp_right).offset(APP_SCALE)
                }
            }
        }
        
    }
    
    func setModel(){
        let maxSize = CGSize.init(width: SCREEN_WIDTH - 2*MARGIN_15, height: CGFloat(MAXFLOAT))
        
        if let title = model?.title {
            let attachment = NSTextAttachment.init()
            attachment.image = UIImage.init(named: "ic_evaluate")
            let height = FONT_SIZE_15.lineHeight
            let width = 32 * (FONT_SIZE_15.lineHeight / 20)
            attachment.bounds = CGRect.init(x: 0, y: FONT_SIZE_15.descender, width: width, height: height)
            let mutiAtrr = NSMutableAttributedString.init(attributedString: NSAttributedString.init(attachment: attachment))
            mutiAtrr.append(NSAttributedString.init(string: " "))
            mutiAtrr.append(NSAttributedString.init(string: title))
            mutiAtrr.addAttributes([NSAttributedString.Key.font : FONT_SIZE_15], range: NSRange.init(location: 0, length: mutiAtrr.length))
            
            titleLabel.attributedText = mutiAtrr
            let titleSize = mutiAtrr.boundingRect(with: maxSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil).size
            titleLabel.snp.remakeConstraints { (make) in
                make.top.left.equalToSuperview().offset(MARGIN_15)
                make.size.equalTo(CGSize(width: ceil(titleSize.width), height: titleSize.height))
            }
        }
        
        if let covers = model?.coverImgs {
            imageContentView.snp.makeConstraints { (make) in
                make.top.equalTo(titleLabel.snp_bottom).offset(MARGIN_15)
                make.left.equalTo(MARGIN_15)
                make.right.equalToSuperview().offset(-MARGIN_15)
                make.height.equalTo(IMAGE_CONTENT_H)
            }
            
            for (index,item) in imageViewArr.enumerated() {
                item.loadImage(imageURL: fixedURL(covers[index]), placeholder: nil){[weak self] in
                    guard let strongSelf = self else{return}
                    strongSelf.imageContentView.makeRoundingCorners(8*APP_SCALE)
                }
            }
        }
        
    }
    
    func fixedURL(_ url:String)->String{
        let url = url.replacingOccurrences(of: "{0}", with: "380").replacingOccurrences(of: "{1}", with: "0")
        return url
    }
    
    class func cellH(model:YCHomeModel){
        var rowHeight:CGFloat = 0
        let maxSize = CGSize.init(width: SCREEN_WIDTH - 2*MARGIN_15, height: CGFloat(MAXFLOAT))
        
        if let title = model.title {
            let attachment = NSTextAttachment.init()
            attachment.image = UIImage.init(named: "ic_evaluate")
            attachment.bounds = CGRect.init(x: 0, y: FONT_SIZE_15.descender,width: 32*APP_SCALE, height: 20*APP_SCALE)
            let mutiAtrr = NSMutableAttributedString.init(attributedString: NSAttributedString.init(attachment: attachment))
            mutiAtrr.append(NSAttributedString.init(string: " "))
            mutiAtrr.append(NSAttributedString.init(string: title))
            mutiAtrr.addAttributes([NSAttributedString.Key.font : FONT_SIZE_15], range: NSRange.init(location: 0, length: mutiAtrr.length))
            
            let titleSize = mutiAtrr.boundingRect(with: maxSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil).size
            
            rowHeight += MARGIN_15 + titleSize.height
        }
        
        if let _ = model.coverImgs {
            rowHeight += MARGIN_15 + IMAGE_CONTENT_H + MARGIN_15
        }
        model.rowHeight = rowHeight
        
    }
    
}
