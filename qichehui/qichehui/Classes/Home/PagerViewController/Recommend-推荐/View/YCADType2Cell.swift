//
//  YCADType2Cell.swift
//  qichehui
//
//  Created by SMART on 2020/1/1.
//  Copyright © 2020 SMART. All rights reserved.
//

import UIKit
fileprivate let COVER_IMAGE_HEIGHT = 190*APP_SCALE
class YCADType2Cell: UITableViewCell {
    
    var model:YCADSModel? {didSet {setModel()}}
    func setModel(){
        let maxSize = CGSize.init(width: SCREEN_WIDTH - 2*MARGIN_15, height: CGFloat(MAXFLOAT))

        if let title = model?.result?.title {
            let textSize = titleLabel.size(text: title, font: FONT_SIZE_15, color: UIColor.darkGray, maxSize: maxSize)
            titleLabel.snp.remakeConstraints { (make) in
                make.top.equalToSuperview().offset(MARGIN_15)
                make.left.equalToSuperview().offset(MARGIN_15)
                make.size.equalTo(textSize)
            }
        }
        
        if let cover = model?.result?.picUrl {
            coverImageView.snp.remakeConstraints { (make) in
                make.top.equalTo(self.titleLabel.snp_bottom).offset(MARGIN_15)
                make.left.equalToSuperview().offset(MARGIN_15)
                make.right.equalToSuperview().offset(-MARGIN_15)
                make.height.equalTo(COVER_IMAGE_HEIGHT)
            }

            coverImageView.loadImage(imageURL: cover, placeholder: nil,radius: 8*APP_SCALE)
        }
        
        adLogo.snp.remakeConstraints { (make) in
            make.top.equalTo(coverImageView.snp_bottom).offset(MARGIN_10)
            make.left.equalTo(coverImageView)
            make.size.equalTo(CGSize.init(width: 22*APP_SCALE, height: 14*APP_SCALE))
        }
        
       self.selectionStyle = .none
        
    }
    
    class func cellWith(tableView:UITableView)->YCADType2Cell{
        var cell = tableView.dequeueReusableCell(withIdentifier: String(describing: YCADType2Cell.self))
        if cell == nil {
            cell = YCADType2Cell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: String(describing: YCADType2Cell.self))
        }
        cell?.selectionStyle = .none
        return cell as! YCADType2Cell
    }
    
    private lazy var titleLabel:UILabel = {
        let label = UILabel()
        self.contentView.addSubview(label)
        return label
    }()
    
    private lazy var coverImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        self.contentView.addSubview(imageView)
        return imageView
    }()
    
    private lazy var adLogo:UIImageView = {
        let logo = UIImageView()
        self.contentView.addSubview(logo)
        logo.image = UIImage.init(named: "bpn_ad_logo")
        return logo
    }()
    
    
    class func cellH(model:YCADSModel){
        
        var rowHeight:CGFloat = 0
        let maxSize = CGSize.init(width: SCREEN_WIDTH - 2*MARGIN_15, height: CGFloat(MAXFLOAT))
        
        if let title = model.result?.title {
            let titleSize = title.size(font: FONT_SIZE_15, maxSize: maxSize)
            rowHeight += MARGIN_15 + titleSize.height
        }
        
        if let _ = model.result?.picUrl{
            rowHeight += MARGIN_15 + COVER_IMAGE_HEIGHT
        }
        
        rowHeight += MARGIN_10 + 14*APP_SCALE  + MARGIN_15
        
        model.rowHeight = rowHeight
        
    }
    
}
