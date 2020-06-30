//
//  UserAccount.swift
//  EveryTimes
//
//  Created by SMART on 2019/6/15.
//  Copyright © 2019 SMART. All rights reserved.
//

import UIKit
import Foundation
import AsyncDisplayKit

// MARK: - 适配
//适配比例
let APP_SCALE = UIScreen.main.bounds.size.width/375;

// MARK: - 间隙
let MARGIN_3 = 3*APP_SCALE
let MARGIN_4 = 4*APP_SCALE
let MARGIN_5 = 5*APP_SCALE
let MARGIN_10 = 10*APP_SCALE
let MARGIN_15 = 15*APP_SCALE
let MARGIN_20 = 20*APP_SCALE
let MARGIN_30 = 30*APP_SCALE

let IS_IPHONEX = (UIScreen.main.bounds.size.height == 812 || UIScreen.main.bounds.size.height == 896)
let NAVIGATION_BAR_HEIGHT: CGFloat = IS_IPHONEX ? (64.0 + 24.0) : 64.0
let TAB_BAR_HEIGHT: CGFloat = IS_IPHONEX ? 49.0 + 34.0 : 49.0
let STATUS_BAR_HEIGHT: CGFloat = IS_IPHONEX ? 44.0 : 20.0
let iPhoneXBottomH: CGFloat = 34.0
let iPhoneXTopH: CGFloat = 24.0

//屏幕宽度
let SCREEN_WIDTH = UIScreen.main.bounds.size.width;
//屏幕高度
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height;

//屏幕高度
let CONTENT_VIEW_WIDTH =  SCREEN_WIDTH - 2*MARGIN_30;

// MARK: - 颜色相关
//背景颜色
let BACK_GROUND_COLOR = UIColor.init(red: 247/255.0, green: 250/255.0, blue: 252/255.0, alpha: 1.0)

//导航栏颜色
let NAV_BAR_COLOR =  UIColor.white

//随机色
let RANDOM_COLOR = UIColor.init(red: CGFloat(arc4random_uniform(255))/255.0, green: CGFloat(arc4random_uniform(255))/255.0, blue: CGFloat(arc4random_uniform(255))/255.0, alpha: 1.0)

// 主题色
let THEME_COLOR = UIColor.init(red: 252/255.0, green: 50/255.0, blue: 46/255.0, alpha: 1.0)

// MARK: - 字体
let FONT_SIZE_18 = UIFont.systemFont(ofSize: 18*APP_SCALE)
let FONT_SIZE_17 = UIFont.systemFont(ofSize: 17*APP_SCALE)
let FONT_SIZE_16 = UIFont.systemFont(ofSize: 16*APP_SCALE)
let FONT_SIZE_15 = UIFont.systemFont(ofSize: 15*APP_SCALE)
let FONT_SIZE_14 = UIFont.systemFont(ofSize: 14*APP_SCALE)
let FONT_SIZE_13 = UIFont.systemFont(ofSize: 13*APP_SCALE)
let FONT_SIZE_12 = UIFont.systemFont(ofSize: 12*APP_SCALE)
let FONT_SIZE_11 = UIFont.systemFont(ofSize: 11*APP_SCALE)
let FONT_SIZE_10 = UIFont.systemFont(ofSize: 10*APP_SCALE)
let FONT_SIZE_9 = UIFont.systemFont(ofSize: 9*APP_SCALE)
let FONT_SIZE_8 = UIFont.systemFont(ofSize: 8*APP_SCALE)
let FONT_SIZE_7 = UIFont.systemFont(ofSize: 7*APP_SCALE)
let FONT_SIZE_6 = UIFont.systemFont(ofSize: 6*APP_SCALE)
let FONT_SIZE_5 = UIFont.systemFont(ofSize: 5*APP_SCALE)
let FONT_SIZE_4 = UIFont.systemFont(ofSize:4*APP_SCALE)

let BOLD_FONT_SIZE_32 = UIFont.boldSystemFont(ofSize: 32*APP_SCALE)
let BOLD_FONT_SIZE_19 = UIFont.boldSystemFont(ofSize: 19*APP_SCALE)
let BOLD_FONT_SIZE_18 = UIFont.boldSystemFont(ofSize: 18*APP_SCALE)
let BOLD_FONT_SIZE_17 = UIFont.boldSystemFont(ofSize: 17*APP_SCALE)
let BOLD_FONT_SIZE_16 = UIFont.boldSystemFont(ofSize: 16*APP_SCALE)
let BOLD_FONT_SIZE_15 = UIFont.boldSystemFont(ofSize: 15*APP_SCALE)
let BOLD_FONT_SIZE_14 = boldSystemFont(ofSize: 14*APP_SCALE)
let BOLD_FONT_SIZE_13 = boldSystemFont(ofSize: 13*APP_SCALE)
let BOLD_FONT_SIZE_12 = boldSystemFont(ofSize: 12*APP_SCALE)
let BOLD_FONT_SIZE_11 = boldSystemFont(ofSize: 11*APP_SCALE)
let BOLD_FONT_SIZE_10 = boldSystemFont(ofSize: 10*APP_SCALE)
let BOLD_FONT_SIZE_9 = boldSystemFont(ofSize: 9*APP_SCALE)
let BOLD_FONT_SIZE_8 = boldSystemFont(ofSize: 8*APP_SCALE)
let BOLD_FONT_SIZE_7 = boldSystemFont(ofSize: 7*APP_SCALE)

let HOME_CONTENT_WIDTH = SCREEN_WIDTH - 2*MARGIN_10 - 2*35*APP_SCALE - 2*5*APP_SCALE


let BASE_URL:String = "";


//  图片大小限制为512KB
let IMAGE_MAX_SIZE = 1024 * 512

// MARK: -  打印日志
func logger<T> (message: T, fileName: String = #file, funcName: String = #function, lineNum: Int = #line) {
    #if DEBUG
    let file = (fileName as NSString).lastPathComponent
    print("[\(file)][\(lineNum)]:\(funcName): \(message)")
    #endif
}

func systemFont(ofSize:CGFloat)->UIFont{ return UIFont.systemFont(ofSize: ofSize) }
func boldSystemFont(ofSize:CGFloat)->UIFont{  return UIFont.boldSystemFont(ofSize: ofSize) }

