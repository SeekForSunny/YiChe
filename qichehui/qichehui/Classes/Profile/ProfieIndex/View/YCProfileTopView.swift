//
//  YCUserInfoView.swift
//  qichehui
//
//  Created by SMART on 2019/12/3.
//  Copyright © 2019 SMART. All rights reserved.
//

import UIKit
import SnapKit

// 头像宽高
fileprivate let AVATAR_VIEW_WH = 70*APP_SCALE
class YCProfileTopView: UIView {
    
    // view累计高度
    var viewH:CGFloat = 0

    
    var userInfo:YCUserInfo?{didSet {setUserInfo()}}
    var modules:[YCProfileModule]?{didSet {setModules()}}
    var memberStatusInfo:YCProfileMemberStatusInfo?{didSet {setMemberStatusInfo()} }
    var tagModules:[YCProfileTagModel]?{ didSet {setTagModules()} }
    var orderModules:[YCProfileOrderModel]?{didSet{setOrderModules()}}
    // 头像
    lazy var avatarView:UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = AVATAR_VIEW_WH * 0.5
        imageView.clipsToBounds = true
        addSubview(imageView)
        return imageView
    }()
    // 昵称
    lazy var nickNameLabel:UILabel = {
        let label = UILabel()
        label.font = BOLD_FONT_SIZE_18
        label.textColor = UIColor.darkGray
        addSubview(label)
        return label
    }()
    
    // 关注 粉丝 车币
    lazy var moduleBtnArr:[UIButton] = {
        let btnArr = [UIButton]()
        return btnArr
    }()
    
    // 签到
    lazy var signLabel:UILabel = {
        let label = UILabel()
        label.font = FONT_SIZE_13
        label.textColor = UIColor.white
        label.text = "签到"
        label.textAlignment = .center
        label.backgroundColor = UIColor.hexadecimalColor(hexadecimal: "#3069FF")
        addSubview(label)
        return label
    }()
    
    // MO卡会员
    lazy var MOCardView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named:"bg_moka")
        addSubview(imageView)
        return imageView
    }()
    // 提示文字
    lazy var copyWriterLabel:UILabel = {
        let label = UILabel()
        label.font = FONT_SIZE_13
        label.textColor = UIColor.white
        MOCardView.addSubview(label)
        return label
    }()
    // 按钮
    lazy var copyWriterBtn:UIButton = {
        let btn = UIButton()
        btn.setTitleColor(UIColor.lightGray, for: UIControl.State.normal)
        btn.backgroundColor = UIColor.white
        btn.titleLabel?.font = FONT_SIZE_13
        MOCardView.addSubview(btn)
        return btn
    }()
    
    // 收藏/足迹/发布/卡券/草稿
    lazy var modulesBtnArrA = {return [YCCustomButton]()}()
    
    // 商城订单/购车红包/违章代缴/易车惠/订单
    lazy var modulesBtnArrB = {return [YCCustomButton]()}()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // UI初始化
    func setupUI(){ }
    
    // MARK: - 数据绑定
    func setUserInfo(){
        viewH = 0
        guard let userInfo = userInfo else{return}
        if let url = userInfo.avatarPath {
            avatarView.snp.makeConstraints { (make) in
                make.left.equalToSuperview().offset(MARGIN_20)
                make.width.height.equalTo(AVATAR_VIEW_WH)
                make.top.equalToSuperview().offset(-15*APP_SCALE)
            }
            avatarView.loadImage(imageURL: url, placeholder: nil)
            viewH += AVATAR_VIEW_WH + -15*APP_SCALE
        }
        if let nickName = userInfo.showName {
            nickNameLabel.text = nickName
            nickNameLabel.sizeToFit()
            nickNameLabel.snp.makeConstraints { (make) in
                make.top.equalTo(avatarView.snp_bottom).offset(MARGIN_10)
                make.left.equalTo(avatarView)
                make.height.equalTo(nickNameLabel.frame.height)
            }
            viewH += MARGIN_10 + nickNameLabel.frame.height
        }
        
        signLabel.layer.cornerRadius = 25*APP_SCALE*0.5
        signLabel.layer.masksToBounds = true
        signLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(avatarView)
            make.right.equalToSuperview().offset(-MARGIN_20)
            make.size.equalTo(CGSize.init(width: 70*APP_SCALE, height: 25*APP_SCALE))
        }
    }
    
    func setModules(){
        guard let modules = self.modules else { return  }
        var btnH:CGFloat = 0
        
        if moduleBtnArr.count < modules.count{
            for _ in moduleBtnArr.count ..< modules.count {
                let btn = YCCustomButton(type: .topImageBottomTitle)
                moduleBtnArr.append(btn)
                addSubview(btn)
            }
        }else{
            for index in  modules.count ..< moduleBtnArr.count {
                let btn = moduleBtnArr[index]
                btn.isHidden = true
            }
        }
        
        for (index,module) in modules.enumerated(){
            
            let btn = moduleBtnArr[index]
            let title = module.name ?? ""
            let text = NSMutableAttributedString.init(string: title + " ", attributes: [NSAttributedString.Key.font:FONT_SIZE_13,NSAttributedString.Key.foregroundColor:UIColor.lightGray])
            let numText = NSAttributedString.init(string: String.init(describing: module.tip ?? 0), attributes: [NSAttributedString.Key.font:FONT_SIZE_13,NSAttributedString.Key.foregroundColor:UIColor.darkGray])
            text.append(numText)
            btn.setAttributedTitle(text, for: UIControl.State.normal)
            btn.sizeToFit()
            let btnSize = btn.frame.size
            btn.snp.makeConstraints { (make) in
                make.left.equalToSuperview().offset(MARGIN_20 + MARGIN_5 + CGFloat(index)*(btnSize.width + MARGIN_15))
                make.top.equalTo(nickNameLabel.snp.bottom).offset(MARGIN_10)
                make.size.equalTo(btnSize)
            }
            btnH =  btnSize.height
            
        }
        viewH += MARGIN_10 + btnH
    }
    
    func setMemberStatusInfo(){
        
        guard let memberStatusInfo = memberStatusInfo else{return}
        MOCardView.snp.makeConstraints { (make) in
            make.top.equalTo(moduleBtnArr[0].snp_bottom).offset(MARGIN_15)
            make.left.equalToSuperview().offset(15*APP_SCALE)
            make.width.equalTo(347*APP_SCALE)
            make.height.equalTo(74*APP_SCALE)
        }
        viewH += MARGIN_15 + 74*APP_SCALE
        
        if let notice = memberStatusInfo.copyWriter{
            copyWriterLabel.text = notice
            copyWriterLabel.sizeToFit()
            copyWriterLabel.snp.makeConstraints { (make) in
                make.left.equalToSuperview().offset(MARGIN_20)
                make.bottom.equalToSuperview().offset(-MARGIN_15)
            }
        }
        
        if let text = memberStatusInfo.btnCopyWriter {
            copyWriterBtn.setTitle(text, for: UIControl.State.normal)
            copyWriterBtn.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.right.equalToSuperview().offset(-MARGIN_20)
                make.size.equalTo(CGSize.init(width: 75*APP_SCALE, height: 25*APP_SCALE))
            }
            copyWriterBtn.layer.cornerRadius = 25*APP_SCALE*0.5
        }
        
    }
    
    func setTagModules(){
        
        guard let models = tagModules else{return}
        let btnWidth = (SCREEN_WIDTH - CGFloat(2) * MARGIN_20)/CGFloat(models.count)
        
        if modulesBtnArrA.count < models.count{
            for _ in modulesBtnArrA.count ..< models.count {
                let btn = YCCustomButton(type: .topImageBottomTitle)
                modulesBtnArrA.append(btn)
                addSubview(btn)
            }
        }else{
            for index in  models.count ..< modulesBtnArrA.count {
                let btn = modulesBtnArrA[index]
                btn.isHidden = true
            }
        }
        
        for (index,model) in models.enumerated() {
            let btn = modulesBtnArrA[index]
            btn.isHidden = false
            if let url = model.image { btn.loadImage(imageURL: url, placeholder: nil) }
            btn.setTitleColor(UIColor.hexadecimalColor(hexadecimal: "#615D62"), for: UIControl.State.normal)
            btn.setTitle(model.title ?? "", for: UIControl.State.normal)
            btn.titleLabel?.font = FONT_SIZE_11
            btn.snp.makeConstraints { (make) in
                make.left.equalToSuperview().offset(MARGIN_20 + CGFloat(index)*btnWidth)
                make.top.equalTo(MOCardView.snp_bottom).offset(MARGIN_15)
                make.width.equalTo(btnWidth)
                make.height.equalTo(50*APP_SCALE)
            }
            
        }
        viewH += MARGIN_15 + 50*APP_SCALE
    }
    
    func setOrderModules(){
        guard let models = orderModules else{return}
        let btnWidth = (SCREEN_WIDTH - CGFloat(2) * MARGIN_20)/CGFloat(models.count)
        
        if modulesBtnArrB.count < models.count{
            for _ in modulesBtnArrB.count ..< models.count {
                let btn = YCCustomButton(type: .topImageBottomTitle)
                modulesBtnArrB.append(btn)
                addSubview(btn)
            }
        }else{
            for index in  models.count ..< modulesBtnArrB.count {
                let btn = modulesBtnArrB[index]
                btn.isHidden = true
            }
        }
        
        for (index,model) in models.enumerated() {
            let btn = modulesBtnArrB[index]
            btn.isHidden = false
            if let url = model.icon {btn.loadImage(imageURL: url, placeholder: nil)}
            btn.setTitleColor(UIColor.hexadecimalColor(hexadecimal: "#615D62"), for: UIControl.State.normal)
            btn.setTitle(model.title ?? "", for: UIControl.State.normal)
            btn.titleLabel?.font = FONT_SIZE_11
            btn.snp.makeConstraints { (make) in
                make.left.equalToSuperview().offset(MARGIN_20 + CGFloat(index)*btnWidth)
                make.top.equalTo(modulesBtnArrA[0].snp_bottom).offset(MARGIN_10)
                make.width.equalTo(btnWidth)
                make.height.equalTo(50*APP_SCALE)
            }
        }
        
        viewH += MARGIN_10 + 50*APP_SCALE + MARGIN_20
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .white
    }
    
}
