//
//  YCNewCarLuxuryBrandModel.swift
//  qichehui
//
//  Created by SMART on 2020/2/18.
//  Copyright © 2020 SMART. All rights reserved.
//

import UIKit
import HandyJSON

class YCNewCarLuxuryBrandListModel: HandyJSON {
    
    var masterId:Int?//": 9,
    var serialId:Int?//": 2593,
    var serialName:String?//": "奥迪A4L",
    var allSpell:String?//": "quanxinaodia4l",
    var carIdList:String?//": "131315,131316,131317,131318,131319,131320,131321,132275,132276,132277,132278,132279,",
    var carNum:Int?//": 12,
    var PVNum:Int?//": 68509,
    var HeatRank:Int?//": 8,
    var whiteImg:String?//": "http://img2.bitautoimg.com/autoalbum/files/20190102/923/0248189235_6.png",
    var referPrice:String?//": "28.68-40.18万",
    var dealerCount:String?//": "6.88",
    var saleStatus:Int?//": 1,
    var carMarket:Any?//": null,
    var modelTagsStatic:String?//": "一汽奥迪/国产/中型车/豪华品牌",
    var modelTagsDynamic:[modelTagsDynamic]?
    var promotionLogo:String?//": "",
    var promotionTitle:String?//": "",
    var promotionLink:String?//": "",
    var arStatus:Bool?//": false
    var rowHeight:CGFloat = 0
    required init() {}
}

class modelTagsDynamic: HandyJSON {
    var id:Int?//": 13,
    var value:String?//": "点评排行No.8",
    var type:Int?//": 4
    required init() { }
}
