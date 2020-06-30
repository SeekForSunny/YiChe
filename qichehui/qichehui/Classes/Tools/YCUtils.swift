//
//  YCUtils.swift
//  qichehui
//
//  Created by SMART on 2019/12/2.
//  Copyright © 2019 SMART. All rights reserved.
//

import SwiftyJSON
import Foundation

import UIKit

import Kingfisher

@objc
protocol ScrollContentDelegate:class {
    @objc optional
    func scrollView(scrollView:UIScrollView,scrolling withStartOffsetX:CGFloat);
}

@objc
protocol ScrollViewDidScrollDelegate:class {
    @objc optional
    func scrollView(didScroll scrollView:UIScrollView);
}

func loadJsonFromFile(sourceName:String)->JSON?{
    guard let path = Bundle.main.path(forResource: sourceName, ofType: nil) else {return nil}
    guard let data = try? Data.init(contentsOf: URL.init(fileURLWithPath: path)) else {return nil}
    guard let json = try? JSON.init(data: data) else{return nil}
    return json
}

func cleanMemoryCache(){
    ImageCache.default.clearMemoryCache()
}

//获取启动图片
func getLaunchImage()->String{
    
    let val = "\(Int(SCREEN_WIDTH))px" + " × " +  "\(Int(SCREEN_HEIGHT))px"
    
    switch val {
    case "320px × 480px": // 640px × 960px@2x
        return "LaunchImage-700"
    case "320px × 568px": // Retina 4 640px × 1136px@2x
        return "LaunchImage-700-568h"
    case "375px × 667px": //Retina HD 4.7  750px × 1334px@2x
        return "LaunchImage-800-667h"
    case "375px × 812px": // X/XS 1125px × 2436px@3x
        return "LaunchImage-1100-Portrait-2436h"
    case "414px × 736px": //Retina HD 5.5 1242px × 2208px@3x
        return "LaunchImage-800-Portrait-736h"
    case "414px × 896px": // Xr 828px × 1792px@2x // XS MAX 1242px × 2688px@3x
        switch UIDevice.current.modelName {
        case "iPhone Xr":
            return  "LaunchImage-1200-Portrait-1792h"
        default:
            return "LaunchImage-1200-Portrait-2688h"
        }
    default:
        return "LaunchImage-1200-Portrait-1792h"
    }
    
}

extension String {
    
    func size(font:UIFont, maxSize:CGSize)-> CGSize{
        
        let paragraphStyle = NSMutableParagraphStyle.init()
        paragraphStyle.lineBreakMode = .byWordWrapping
        paragraphStyle.lineSpacing = 3 * APP_SCALE

        let attributes = [NSAttributedString.Key.font : font,
                          NSAttributedString.Key.paragraphStyle:paragraphStyle,
                          NSAttributedString.Key.kern:1.0] as [NSAttributedString.Key : Any]
        
        let size = self.boundingRect(with: maxSize, options: [NSStringDrawingOptions.usesLineFragmentOrigin, NSStringDrawingOptions.usesFontLeading], attributes: attributes, context: nil).size
        return CGSize(width:ceil(size.width),height:ceil(size.height));
    }
    
}

extension UILabel {
    
    func size(text:String,font:UIFont,color:UIColor,maxSize:CGSize,numberOfLine:Int = 0)->CGSize{
        
        self.numberOfLines = numberOfLine
        
        let paragraphStyle = NSMutableParagraphStyle.init()
        paragraphStyle.lineBreakMode = .byWordWrapping
        paragraphStyle.lineSpacing = 3 * APP_SCALE

        let attributes = [
            NSAttributedString.Key.font : font,
            NSAttributedString.Key.foregroundColor:color,
            NSAttributedString.Key.paragraphStyle:paragraphStyle,
            NSAttributedString.Key.kern:1.0 * APP_SCALE
            ] as [NSAttributedString.Key : Any]

        self.attributedText = NSAttributedString.init(string: text, attributes: attributes)
        let size = text.size(font: font, maxSize: maxSize)
        return size
    }
    
}
