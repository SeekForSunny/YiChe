//
//  YCCustomButton.swift
//  qichehui
//
//  Created by SMART on 2019/12/3.
//  Copyright © 2019 SMART. All rights reserved.
//

import UIKit
import SnapKit
class YCCustomButton: UIButton {
    
    enum YCButtonType {
        case topImageBottomTitle
        case leftTitleRightImage
    }
    
    var imageScale:CGFloat = 0.7
    var marginScale:CGFloat = 0.1
    
    let type:YCButtonType
    var imageModel:UIView.ContentMode = .scaleAspectFit
    
    init(frame: CGRect = CGRect.zero,type:YCButtonType) {
        self.type = type
        super.init(frame: frame)
        
        if self.type == YCButtonType.topImageBottomTitle{
            imageScale = 0.7
            marginScale = 0.1
        }else if self.type == .leftTitleRightImage{
            imageScale = 0.15
            marginScale = 0.1
        }
        
        backgroundColor = UIColor.white
        setTitleColor(UIColor.darkGray, for: UIControl.State.normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if type == .topImageBottomTitle {
            titleLabel?.textAlignment = .center
            imageView?.contentMode = imageModel
        }else if type == .leftTitleRightImage {
            titleLabel?.textAlignment = .center
            imageView?.contentMode = imageModel
        }
        
    }
    
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        let iframe = contentRect
        if type == .topImageBottomTitle {
            let iWidth = fitWidth(frame:contentRect,scale:imageScale)
            let iHeight = fitHeight(frame:contentRect,scale:imageScale)
            let iX:CGFloat = (iframe.width - iWidth)/CGFloat(2)
            let iY:CGFloat = 0;
            return CGRect.init(x: iX, y: iY, width: iWidth, height: iHeight)
        } else if type == .leftTitleRightImage {
            let iWidth = fitWidth(frame:contentRect,scale:imageScale)
            let iHeight = contentRect.size.height*(1-marginScale);//fitHeight(frame:contentRect,scale:imageScale)
            let iX:CGFloat = iframe.width - iWidth - iframe.width*marginScale
            let iY:CGFloat = (iframe.size.height - iHeight)/CGFloat(2)
            return CGRect.init(x: iX, y: iY, width: iWidth, height: iHeight)
        }
        return iframe
    }
    
    func fitHeight(frame:CGRect,scale:CGFloat)->CGFloat{
        return (1-marginScale)*frame.height * scale
    }
    
    func fitWidth(frame:CGRect,scale:CGFloat)->CGFloat{
        return (1-marginScale)*frame.width * scale
    }
    
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        let iframe = contentRect
        if type == .topImageBottomTitle {
            let iWidth = iframe.size.width
            let iHeight = fitHeight(frame: contentRect, scale: (1 - imageScale))
            let iX:CGFloat = 0
            let iY:CGFloat = iframe.height - iHeight
            return CGRect.init(x: iX, y: iY, width: iWidth, height: iHeight)
        }else if type == .leftTitleRightImage {
            let iWidth = fitWidth(frame: contentRect, scale: (1 - imageScale))
            let iHeight = iframe.size.height
            let iX:CGFloat = 0
            let iY:CGFloat = 0
            return CGRect.init(x: iX, y: iY, width: iWidth, height: iHeight)
        }
        return iframe
    }
    
    
}
