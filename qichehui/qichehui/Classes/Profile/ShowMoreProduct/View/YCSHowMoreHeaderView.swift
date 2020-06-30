//
//  YCSHowMoreHeaderView.swift
//  qichehui
//
//  Created by SMART on 2019/12/9.
//  Copyright © 2019 SMART. All rights reserved.
//

import UIKit

class YCSHowMoreHeaderView: UIView {
    
    private lazy var imageViewArr:[UIImageView] = {return [UIImageView]()}()
    var viewH:CGFloat = 0
    var models:[YCShowMoreSubjectModel]?{didSet{setModels()}}
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setModels(){
        viewH = 0
        guard let models = models else { return }
        if imageViewArr.count < models.count {
            for _ in imageViewArr.count ..< models.count {
                let imageView = UIImageView()
                imageView.contentMode = .scaleAspectFit
                imageViewArr.append(imageView)
                addSubview(imageView)
            }
        } else {
            for index in models.count ..< imageViewArr.count  {
                let imageView = imageViewArr[index]
                imageView.isHidden = true
            }
        }
        
        var ih:CGFloat = 0
        var iw:CGFloat = 0
        for (index,model) in models.enumerated() {
            let imageView = imageViewArr[index]
            imageView.isHidden = false
            
            if let cover = model.cover {
                let substrings: [Substring] = cover.split(separator: "/")
                let iName = substrings.last
                let components = iName?.split(separator: "_")
                if let iW = components?[0] as NSString?{
                    iw =  CGFloat((iW.replacingOccurrences(of: "w", with: "") as NSString).intValue)
                }
                if let iH = components?[1] as NSString? {
                    ih = CGFloat((iH.replacingOccurrences(of: "h", with: "") as NSString).intValue)
                }
                
                imageView.loadImage(imageURL: cover, placeholder: nil,radius: 8*APP_SCALE)
                
            }
            let rate = (SCREEN_WIDTH - 2*MARGIN_20)/iw
            ih = ih*rate
            iw = iw*rate
            imageView.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(CGFloat(index)*(ih+MARGIN_15))
                make.centerX.equalToSuperview()
                make.height.equalTo(ih)
                make.width.equalTo(iw)
            }
        }
        viewH += (ih + MARGIN_15) * CGFloat(models.count)
        
    }
    
}
