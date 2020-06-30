//
//  YCCarBrandCell.swift
//  qichehui
//
//  Created by SMART on 2019/12/6.
//  Copyright © 2019 SMART. All rights reserved.
//

import UIKit
let YCCarBrandCellReuseIdentifier:String = "YCCarBrandCell"
class YCCarBrandCell: UITableViewCell {
    private lazy var lineView:UIView = {
        let lineView = UIView()
        lineView.backgroundColor = BACK_GROUND_COLOR
        return lineView
    }()
    
    private lazy var logoImageView:UIImageView = { return UIImageView() }()
    private lazy var masterNameLabel:UILabel = { return UILabel() }()
    var model:YCUsedCarCarBrandModel?{didSet {setModel()}}
    
    class func tableview(tableview:UITableView) -> YCCarBrandCell{
        var cell = tableview.dequeueReusableCell(withIdentifier: YCCarBrandCellReuseIdentifier) as? YCCarBrandCell
        if cell == nil {
            cell = YCCarBrandCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: YCCarBrandCellReuseIdentifier)
        }
        cell?.selectionStyle = .none
        return cell!
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI(){
        
        contentView.addSubview(logoImageView)
        logoImageView.snp.remakeConstraints({ (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(MARGIN_20)
            make.width.height.equalTo(35*APP_SCALE)
        })
        
        contentView.addSubview(masterNameLabel)
        masterNameLabel.snp.remakeConstraints({ (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(logoImageView.snp_right).offset(MARGIN_15)
        })
        masterNameLabel.font = FONT_SIZE_15
        masterNameLabel.textColor = UIColor.darkGray
        
        contentView.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.height.equalTo(APP_SCALE)
            make.bottom.left.right.equalToSuperview()
        }
        
    }
    
    func setModel(){
        
        if let logoUrl = model?.logoUrl {
            logoImageView.loadImage(imageURL: logoUrl, placeholder: nil)
        }
        
        if let masterName = model?.masterName {
            masterNameLabel.text = masterName
        }
        
    }
    
}
