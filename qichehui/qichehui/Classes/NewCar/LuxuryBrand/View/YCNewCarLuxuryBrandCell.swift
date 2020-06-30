//
//  YCNewCarLuxuryBrandCell.swift
//  qichehui
//
//  Created by SMART on 2020/2/12.
//  Copyright © 2020 SMART. All rights reserved.
//

import UIKit

class YCNewCarLuxuryBrandCell: UITableViewCell {
    
    private lazy var iconView:UIImageView = {
        let imageView = UIImageView()
        self.contentView.addSubview(imageView)
        return imageView
    }()
    
    private lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.font = BOLD_FONT_SIZE_15
        self.contentView.addSubview(label)
        return label
    }()
    
    private lazy var referPriceLabel:UILabel = {
        let label = UILabel()
        label.font = FONT_SIZE_13
        self.contentView.addSubview(label)
        return label
    }()
    
    private lazy var modelTagsStaticLabel:UILabel = {
        let label = UILabel()
        label.font = FONT_SIZE_11
        label.textColor = UIColor.darkGray
        self.contentView.addSubview(label)
        return label
    }()
    
    private lazy var tagsDynamicView:YCNewCarLuxuryBrandModelTagsDynamicView = {
        let view = YCNewCarLuxuryBrandModelTagsDynamicView()
        self.contentView.addSubview(view)
        return view
    }()
    
    private lazy var matchCountBtn:UIButton = {
        let btn = YCCustomButton(type: .leftTitleRightImage)
        btn.marginScale = 0
        btn.setTitleColor(UIColor.darkGray, for: UIControl.State.normal)
        btn.titleLabel?.font = FONT_SIZE_10
        self.contentView.addSubview(btn)
        return btn
    }()
    
    var model:YCNewCarLuxuryBrandListModel?{didSet {setModel()}}
    class func cellWithTableView(_ tableview:UITableView)->YCNewCarLuxuryBrandCell{
        var cell = tableview.dequeueReusableCell(withIdentifier: String(describing:YCNewCarLuxuryBrandCell.self))
        if cell == nil {
            cell = YCNewCarLuxuryBrandCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: String(describing:YCNewCarLuxuryBrandCell.self))
        }
        cell?.selectionStyle = .none
        return cell as! YCNewCarLuxuryBrandCell
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI(){
        self.backgroundColor = UIColor.white
    }
    
    func setModel(){
        var viewH:CGFloat = 0
        guard let model = self.model else{return}
        
        if let url = model.whiteImg {
            iconView.loadImage(imageURL: url)
            iconView.snp.makeConstraints({ (make) in
                make.left.top.equalToSuperview().offset(MARGIN_20)
                make.width.equalTo(90*APP_SCALE)
                make.height.equalTo(60*APP_SCALE)
            })
            viewH += MARGIN_20
        }
        
        if let title = model.serialName {
            titleLabel.text = title
            titleLabel.snp.makeConstraints { (make) in
                make.left.equalTo(iconView.snp_right).offset(MARGIN_15)
                make.top.equalTo(iconView)
            }
            viewH += BOLD_FONT_SIZE_15.lineHeight
        }
        
        if let text = model.referPrice {
            let mutiStr = NSMutableAttributedString(string: "指导价  ", attributes: [NSAttributedString.Key.font : FONT_SIZE_13,NSAttributedString.Key.foregroundColor:UIColor.darkGray])
            mutiStr.append(NSAttributedString(string: text, attributes: [NSAttributedString.Key.font : FONT_SIZE_13,NSAttributedString.Key.foregroundColor:UIColor.red]))
            if let dealerCount = model.dealerCount,dealerCount.count > 0 {
                mutiStr.append(NSAttributedString(string: "  ↓\(dealerCount)万", attributes: [NSAttributedString.Key.font : BOLD_FONT_SIZE_13,NSAttributedString.Key.foregroundColor: UIColor.hexadecimalColor(hexadecimal: "#22BF6A")]))
            }
            referPriceLabel.attributedText = mutiStr
            referPriceLabel.snp.makeConstraints { (make) in
                make.top.equalTo(titleLabel.snp_bottom).offset(MARGIN_3)
                make.left.equalTo(titleLabel)
            }
            
            viewH += MARGIN_3 + BOLD_FONT_SIZE_13.lineHeight
        }
        
        if let text = model.modelTagsStatic {
            modelTagsStaticLabel.text = text
            modelTagsStaticLabel.snp.makeConstraints { (make) in
                make.left.equalTo(titleLabel)
                make.top.equalTo(referPriceLabel.snp_bottom).offset(MARGIN_3)
            }
            viewH += MARGIN_3 + FONT_SIZE_11.lineHeight
        }
        
        if let modelTagsDynamic = model.modelTagsDynamic{
            tagsDynamicView.modelTagsDynamic = modelTagsDynamic
            let tagsViewH = tagsDynamicView.viewH
            tagsDynamicView.snp.remakeConstraints { (make) in
                make.top.equalTo(modelTagsStaticLabel.snp_bottom).offset(MARGIN_5)
                make.left.equalTo(titleLabel)
                make.right.equalToSuperview().offset(-MARGIN_20)
                make.height.equalTo(tagsViewH)
            }
            viewH += MARGIN_5 + tagsViewH
        }
        
        if let count = model.carIdList?.split(separator: ",").count {
            let title = "共\(count)款车符合条件"
            let titleSize = title.size(font: FONT_SIZE_10, maxSize: CGSize(width: SCREEN_WIDTH, height: CGFloat(MAXFLOAT)))
            let btnWidth = titleSize.width + 10*APP_SCALE
            matchCountBtn.setTitle(title, for: UIControl.State.normal)
            matchCountBtn.setImage(UIImage(named: "bpl_gray_arrow_right"), for: UIControl.State.normal)
            matchCountBtn.snp.remakeConstraints { (make) in
                make.left.equalTo(titleLabel)
                make.top.equalTo(viewH + MARGIN_5)
                make.size.equalTo(CGSize(width: btnWidth, height: titleSize.height))
            }
        }
        
    }
    
    class func cellH(model:YCNewCarLuxuryBrandListModel){
        var viewH:CGFloat = 0
        
        if let _ = model.whiteImg {
            viewH += MARGIN_20
        }
        
        if let _ = model.serialName {
            viewH += BOLD_FONT_SIZE_15.lineHeight
        }
        
        if let _ = model.referPrice {
            viewH += MARGIN_3 + BOLD_FONT_SIZE_13.lineHeight
        }
        
        if let _ = model.modelTagsStatic {
            viewH += MARGIN_3 + FONT_SIZE_11.lineHeight
        }
        
        if let modelTagsDynamic = model.modelTagsDynamic,modelTagsDynamic.count > 0{
            var tagsH:CGFloat = 0
            var offsetX:CGFloat = 0
            modelTagsDynamic.forEach { (item) in
                if let label = item.value {
                    var labelSize = label.size(font: FONT_SIZE_10, maxSize: CGSize(width: SCREEN_WIDTH, height: CGFloat(MAXFLOAT)))
                    labelSize.width += MARGIN_10
                    let maxWidth:CGFloat = SCREEN_WIDTH - MARGIN_20 - 90*APP_SCALE - MARGIN_15 - MARGIN_20
                    let next = offsetX + labelSize.width + MARGIN_5
                    if next >= maxWidth {
                        offsetX = 0
                        tagsH += labelSize.height + MARGIN_5
                    }else{
                        offsetX += labelSize.width + MARGIN_5
                    }
                }
                
            }
            viewH += MARGIN_5 + tagsH + MARGIN_20
        }
        
        if let _ = model.carIdList?.split(separator: ",").count {
            viewH += MARGIN_5 + FONT_SIZE_10.lineHeight + MARGIN_20
        }
        
        model.rowHeight = viewH
    }
    
}
