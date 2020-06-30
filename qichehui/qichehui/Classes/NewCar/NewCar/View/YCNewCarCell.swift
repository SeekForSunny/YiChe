//
//  YCNewCarCell.swift
//  qichehui
//
//  Created by SMART on 2020/2/1.
//  Copyright © 2020 SMART. All rights reserved.
//

import UIKit

private var YCNewCarBrandCellLabelColor = "YCNewCarBrandCellLabelColor"
class YCNewCarCell: UITableViewCell {
    var model:YCNewCarBrandModel?{didSet{setModel()}}
    private lazy var brandLogo:UIImageView = {
        let imageView = UIImageView()
        self.contentView.addSubview(imageView)
        return imageView
    }()
    
    private lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.font = FONT_SIZE_15
        label.textColor = .darkGray
        self.contentView.addSubview(label)
        return label
    }()
    
    private lazy var infoLabel:UILabel = {
        let label = UILabel()
        label.font = FONT_SIZE_10
        self.contentView.addSubview(label)
        return label
    }()
    
    class func cell(withTableView tableView:UITableView)->YCNewCarCell{
        var cell = tableView.dequeueReusableCell(withIdentifier: String(describing:YCNewCarCell.self))
        if cell == nil {
            cell = YCNewCarCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: String(describing:YCNewCarCell.self))
        }
        cell?.selectionStyle = .none
        return cell as! YCNewCarCell
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI(){ }
    
    func setModel(){
        guard let model = model else{return}
        
        if let url = model.logoUrl {
            brandLogo.loadImage(imageURL: url)
            brandLogo.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.left.equalToSuperview().offset(MARGIN_15)
                make.width.height.equalTo(35*APP_SCALE)
            }
        }
        
        if model.modelType == .common{
            if let title = model.masterName{
                titleLabel.text = title
            }
            
            if let info = model.labelList?.first?.content {
                if let color = model.labelList?.first?.color {
                    infoLabel.textColor = UIColor.hexadecimalColor(hexadecimal: color)
                    UserDefaults.standard.set(color, forKey: YCNewCarBrandCellLabelColor)
                }
                infoLabel.text = info
                infoLabel.isHidden = false
            }else{
                infoLabel.isHidden = true
            }
            
        }else if model.modelType == .preferentialBrand{
            if let title = model.PB_BsName{
                titleLabel.text = title
            }
            
            if let label = model.label{
                infoLabel.text = label
                infoLabel.isHidden = false
                
                if  let color = UserDefaults.standard.string(forKey: YCNewCarBrandCellLabelColor){
                    infoLabel.textColor = UIColor.hexadecimalColor(hexadecimal: color)
                }
            }else{
                infoLabel.isHidden = true
            }
            
        }else if model.modelType == .parallelImport {
            if let title = model.brandName{
                titleLabel.text = title
            }
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(brandLogo.snp_right).offset(MARGIN_15)
        }
        
        infoLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-MARGIN_15)
        }
        
    }
    
}
