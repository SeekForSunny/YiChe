//
//  UIImage+Color.swift
//  XiaoHongshu_Swift
//
//  Created by SMART on 2017/7/6.
//  Copyright © 2017年 com.smart.swift. All rights reserved.
//

import UIKit

extension UIImage {
    
    static func image(color:UIColor)->UIImage? {
        
        // 描述矩形
        let rect=CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0);
        
        return image(color: color, size: rect.size)
        
    }
    
    //生成颜色图片
    static func image(color:UIColor,size:CGSize) -> UIImage? {
        
        // 描述矩形
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height);
        
        // 开启位图上下文
        UIGraphicsBeginImageContext(rect.size);
        
        // 获取位图上下文
        let context = UIGraphicsGetCurrentContext();
        
        // 使用color演示填充上下文
        context!.setFillColor(color.cgColor);
        
        // 渲染上下文
        context!.fill(rect);
        
        // 从上下文中获取图片
        let image = UIGraphicsGetImageFromCurrentImageContext();
        
        // 结束上下文
        UIGraphicsEndImageContext();
        
        return image;
    }
    
}
