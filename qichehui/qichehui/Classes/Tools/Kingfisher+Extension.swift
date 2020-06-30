//
//  UIImageView+Extension.swift
//  EveryTimes
//
//  Created by SMART on 2019/11/14.
//  Copyright © 2019 SMART. All rights reserved.
//

import UIKit
import Kingfisher
public typealias CompletionHandler = (() -> Void)

extension UIView {
    func makeRoundingCorners(_ radius:CGFloat){
        let size = CGSize(width: radius, height: radius)
        let path = UIBezierPath.init(roundedRect: self.bounds, byRoundingCorners: UIRectCorner.allCorners, cornerRadii: size)
        let shapelayer = CAShapeLayer.init()
        shapelayer.frame = self.bounds
        shapelayer.path = path.cgPath
        self.layer.mask = shapelayer
    }
}

extension UIImageView {
    
    func loadImage(imageURL:String,placeholder:String?=nil,radius:CGFloat=CGFloat.zero,completionHandler:CompletionHandler? = nil){
        guard let url = URL(string: imageURL) else{ return }
        let resource = ImageResource(downloadURL: url)
        
        var Placeholder: Placeholder?
        if let placeholder = placeholder {
            Placeholder = UIImage(named: placeholder)
        }
        weak var weakSelf = self
        let options:KingfisherOptionsInfo = [.transition(.fade(0.2)),.backgroundDecode,.callbackDispatchQueue(DispatchQueue.global())]
        self.kf.setImage(with: resource, placeholder: Placeholder, options: options ){ (image, _, _, url) in
            if radius != CGFloat.zero {
                guard let strongSelf = weakSelf else{return}
                strongSelf.makeRoundingCorners(radius)
            }
            if completionHandler != nil {completionHandler!()}
        }
    }
    
}

extension UIButton {
    
    func loadImage(imageURL:String,placeholder:String?=nil,radius:CGFloat=CGFloat.zero,status:UIControl.State = UIControl.State.normal){
        guard let url = URL(string: imageURL) else{ return }
        let resource = ImageResource(downloadURL: url)
        
        var Placeholder: UIImage?
        if let placeholder = placeholder {
            Placeholder = UIImage(named: placeholder)
        }
        weak var weakSelf = self
        let options:KingfisherOptionsInfo = [.transition(.fade(0.2)),.backgroundDecode,.callbackDispatchQueue(DispatchQueue.global())]
        self.kf.setImage(with: resource, for: status,placeholder: Placeholder, options: options ){ (image, _, _, url) in
            if radius != CGFloat.zero {
                guard let strongSelf = weakSelf else{return}
                strongSelf.imageView?.makeRoundingCorners(radius)
            }
        }
    }
    
}
