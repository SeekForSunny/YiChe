//
//  UIColorExtenssion.swift
//  EveryTimes
//
//  Created by SMART on 2019/6/15.
//  Copyright © 2019 SMART. All rights reserved.
//

import UIKit

extension UIColor{
    
    class func hexadecimalColor(hexadecimal:String)->UIColor{
        return hexadecimalColor(hexadecimal: hexadecimal, alpha: 1);
    }
    
    class func hexadecimalColor(hexadecimal:String,alpha:CGFloat)->UIColor{
        var cstr = hexadecimal.trimmingCharacters(in:  CharacterSet.whitespacesAndNewlines).uppercased() as NSString;
        if(cstr.length < 6){
            return UIColor.clear;
        }
        if(cstr.hasPrefix("0X")){
            cstr = cstr.substring(from: 2) as NSString
        }
        if(cstr.hasPrefix("#")){
            cstr = cstr.substring(from: 1) as NSString
        }
        if(cstr.length != 6){
            return UIColor.clear;
        }
        var range = NSRange.init()
        range.location = 0
        range.length = 2
        //r
        let rStr = cstr.substring(with: range);
        //g
        range.location = 2;
        let gStr = cstr.substring(with: range)
        //b
        range.location = 4;
        let bStr = cstr.substring(with: range)
        var r :UInt32 = 0x0;
        var g :UInt32 = 0x0;
        var b :UInt32 = 0x0;
        Scanner.init(string: rStr).scanHexInt32(&r);
        Scanner.init(string: gStr).scanHexInt32(&g);
        Scanner.init(string: bStr).scanHexInt32(&b);
        return UIColor.init(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: alpha);
    }
    
    
    //根据颜色值生成颜色
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1.0) {
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }
    
    //随机色
    class func randomColor () -> UIColor{
        
        let red = CGFloat(arc4random_uniform(255))
        let green = CGFloat(arc4random_uniform(255))
        let blue = CGFloat(arc4random_uniform(255))
        
        return UIColor(r: red, g: green, b: blue)
    }
    
    //根据颜色返回rgb值
    func getRGBValueOfColor() -> (r:Int, g:Int, b:Int) {
        
        guard let components = self.cgColor.components  else {
            fatalError("Error: not a rgb color!")
        }
        if components.count < 3 {
            fatalError("Error: not a rgb color!")
        }
        
        let red   = Int(components[0]*255)
        let green = Int(components[1]*255)
        let blue  = Int(components[2]*255)
        
        return (r:red,g:green,b:blue)
    }
    
}
