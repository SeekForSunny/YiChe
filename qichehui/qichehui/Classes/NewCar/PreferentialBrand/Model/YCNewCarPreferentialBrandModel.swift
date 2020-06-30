//
//  YCNewCarPreferentialBrandModel.swift
//  qichehui
//
//  Created by SMART on 2020/2/20.
//  Copyright © 2020 SMART. All rights reserved.
//

import UIKit
import HandyJSON

class YCNewCarPreferentialBrandTangDouModel: HandyJSON {
    var tupian:String?//": "https://image.bitautoimg.com/brandmarket/goods/image/20190514/6369345248168883923295794.png",
    var name:String?//": "旗舰店活动",
    var URL:String?//": "http://shoplist.mai.m.yiche.com/?externalrfpa_tracker=17_31_3_2699_3"
    required init() { }
}

class YCNewCarPreferentialBrandMerchandiseShowModel: HandyJSON {
    var Maintitle:String?//": "全新MAZDA CX-4",
    var Subtitle:String?//": "享888元红包返现",
    var pbid:String?//: "1145",
    var label:String?//": "购车红包",
    var chetu:String?//": "https://image.bitautoimg.com/brandmarket/goods/image/20200115/6371469625194811521563833.png"
    required init() {}
}

class YCNewCarPreferentialBrandCarModel:HandyJSON{
    var PB_BsId:String?//":"25",
    var PB_BsName:String?//":"三菱",
    var Spell:String?//":"S"
    var logoUrl:String?
    var label:String?
    required init() {}
}

class YCNewCarPreferentialBrandTreelabel:HandyJSON{
    var label:String?//": "2020元礼包",
    var brandid:String?//": "8",
    var name:String?//": "上汽大众"
    required init() {}
}
