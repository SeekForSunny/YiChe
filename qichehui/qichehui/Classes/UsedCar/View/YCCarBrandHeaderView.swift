//
//  YCCarBrandHeaderView.swift
//  qichehui
//
//  Created by SMART on 2019/12/6.
//  Copyright © 2019 SMART. All rights reserved.
//

import UIKit

let YCCarBrandHeaderViewReuseIdentifier = "YCCarBrandHeaderView"
class YCCarBrandHeaderView: UITableViewHeaderFooterView {
    
    var title:String? {didSet {setTitle()}}
    private lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.font = BOLD_FONT_SIZE_15
        label.textColor = UIColor.darkGray
        self.contentView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(MARGIN_20)
        }
        return label
    }()
    
    class func tableView(tableView:UITableView)->YCCarBrandHeaderView{
        var header = tableView.dequeueReusableHeaderFooterView(withIdentifier: YCCarBrandHeaderViewReuseIdentifier) as? YCCarBrandHeaderView
        if header == nil{
            header = YCCarBrandHeaderView.init(reuseIdentifier: YCCarBrandHeaderViewReuseIdentifier)
        }
        return header!
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI(){
        contentView.backgroundColor = UIColor.white
    }
    
    func setTitle(){
        titleLabel.text = title
    }
    
}
