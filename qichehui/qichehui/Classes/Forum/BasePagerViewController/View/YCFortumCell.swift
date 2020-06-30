//
//  YCFortumCell.swift
//  qichehui
//
//  Created by SMART on 2019/12/12.
//  Copyright © 2019 SMART. All rights reserved.
//

import UIKit

class YCFortumCell: UITableViewCell {
    
    let IMAGE_VIEW_WIDTH = 100*APP_SCALE
    let IMAGE_VIEW_HEIGHT = 70*APP_SCALE
    
    private lazy var iView:UIImageView = {
        let imageView = UIImageView()
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-MARGIN_20)
            make.centerY.equalToSuperview()
            make.width.equalTo(IMAGE_VIEW_WIDTH)
            make.height.equalTo(IMAGE_VIEW_HEIGHT)
        }
        return imageView
    }()
    
    private lazy var titleLab:UILabel = {
        let label = UILabel()
        contentView.addSubview(label)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var subLab:UILabel = {
        let label = UILabel()
        contentView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.iView)
            make.left.equalToSuperview().offset(MARGIN_20)
        }
        label.textColor = .lightGray
        label.textAlignment = .left
        label.font = FONT_SIZE_11
        return label
    }()
    
    var model:YCFortumModel?{didSet{setModel()}}
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setModel(){
        
        if let imageUrl = model?.imageList?.first?.fullPath {
            iView.loadImage(imageURL: imageUrl, placeholder: nil,radius: 8*APP_SCALE)
        }
        
        if let title = model?.title {
            let maxSize = CGSize.init(width: SCREEN_WIDTH - IMAGE_VIEW_WIDTH - 3*MARGIN_20, height: CGFloat(MAXFLOAT))
            let  textSize = titleLab.size(text: title, font: FONT_SIZE_15, color: .darkGray, maxSize: maxSize)
            titleLab.snp.remakeConstraints { (make) in
                make.left.equalToSuperview().offset(MARGIN_20)
                make.top.equalTo(self.iView.snp_top)
                make.width.equalTo(SCREEN_WIDTH - IMAGE_VIEW_WIDTH - 3*MARGIN_20)
                make.height.equalTo(textSize.height)
            }
        }
        
        let text = String.init(format: "%@%d季 %d回帖", arguments: [model?.forumName ?? "", model?.serial ?? "",model?.repliesNum ?? ""]);
        subLab.text = text
    }
    
}
