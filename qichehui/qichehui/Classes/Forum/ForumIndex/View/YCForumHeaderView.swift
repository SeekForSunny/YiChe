//
//  YCForumHeaderView.swift
//  qichehui
//
//  Created by SMART on 2019/12/11.
//  Copyright © 2019 SMART. All rights reserved.
//

import UIKit

//MARK: FortumModel
struct FortumModel {
    var colorName:String
    var iconName:String
    var title:String
    
    init(colorName:String,iconName:String,title:String) {
        self.iconName = iconName
        self.colorName = colorName
        self.title = title
    }
}

//MARK:YCForumPerCardView
class YCForumPerCardView:UIView{
    private lazy var colorView:UIImageView = {
        let colorView = UIImageView()
        addSubview(colorView)
        colorView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        return colorView;
    }()
    
    private lazy var iconView:UIImageView = {
        let iconView = UIImageView()
        addSubview(iconView)
        iconView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(MARGIN_10)
            make.left.equalToSuperview().offset(MARGIN_10)
        }
        return iconView;
    }()
    
    private lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = BOLD_FONT_SIZE_18
        addSubview(label)
        label.snp.makeConstraints { (make) in
            make.top.equalTo(self.iconView.snp_bottom).offset(MARGIN_5)
            make.left.equalTo(self.iconView)
        }
        return label
    }()
    
    convenience init(model:FortumModel) {
        self.init()
        
        colorView.image = UIImage.init(named: model.colorName)
        iconView.image = UIImage.init(named: model.iconName)
        titleLabel.text = model.title
    }
    
}

//MARK:YCForumHeaderView
class YCForumHeaderView: UIView {
    
    private let CARD_VIEW_W = 106*APP_SCALE
    private let CARD_VIEW_H = 80*APP_SCALE
    private lazy var fortumViewArr = {return [YCForumPerCardView]()}()
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    private lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.text = "精选日报"
        addSubview(label)
        label.textColor = UIColor.darkGray
        label.font = boldSystemFont(ofSize: 23)
        label.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(MARGIN_20)
            make.bottom.equalToSuperview().offset(-MARGIN_20)
        }
        return label
    }()
    
    private lazy var subtitleLabel:UILabel = {
        let label = UILabel()
        label.text = "每日7点，18点更新"
        addSubview(label)
        label.textColor = UIColor.lightGray
        label.font = FONT_SIZE_10
        label.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-MARGIN_20)
            make.centerY.equalTo(self.titleLabel.snp_centerY)
        }
        return label
    }()
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var models:[FortumModel] = {
        return [
            FortumModel.init(colorName: "bpk_sqsy_bg_cxlt", iconName: "bpk_susy_ico_ht", title: "车型论坛"),
            FortumModel.init(colorName: "bpk_sqsy_bg_dult", iconName: "bpk_susy_ico_ht", title: "地区论坛"),
            FortumModel.init(colorName: "bpk_sqsy_bg_ztlt", iconName: "bpk_susy_ico_ht", title: "主题论坛")
        ]
    }()
    
    func initUI(){
        
        let MARGIN = (SCREEN_WIDTH - CGFloat(models.count)*CARD_VIEW_W - 2*MARGIN_20)/CGFloat(models.count - 1)
        for index in 0..<3 {
            let model = models[index]
            let view = YCForumPerCardView.init(model: model)
            let tapGes = UITapGestureRecognizer.init(target: self, action: #selector(clickCard))
            view.addGestureRecognizer(tapGes)
            fortumViewArr.append(view)
            addSubview(view)
            view.snp.makeConstraints { (make) in
                make.left.equalToSuperview().offset(MARGIN_20 + CGFloat(index)*(CARD_VIEW_W+MARGIN))
                make.top.equalToSuperview().offset(MARGIN_20)
                make.width.equalTo(CARD_VIEW_W)
                make.height.equalTo(CARD_VIEW_H)
            }
        }
        
        subtitleLabel.backgroundColor = UIColor.clear
        
    }
    
    @objc func clickCard(ges:UITapGestureRecognizer){
        if let index = fortumViewArr.firstIndex(of: (ges.view as! YCForumPerCardView)) {
            print("title = ",models[index].title)
        }
    }
    
}
