//
//  YCNewCarBrandModel.swift
//  qichehui
//
//  Created by SMART on 2020/2/1.
//  Copyright © 2020 SMART. All rights reserved.
//

import UIKit
import HandyJSON

enum YCNewCarModelType {
    case common
    case preferentialBrand
    case parallelImport
}

class YCNewCarBrandModel:HandyJSON {
    var id:Int?//": 0,
    var masterId:Int?//": 3,
    var masterName:String?//": "宝马",
    var logoUrl:String?//": "http://image.bitautoimg.com/bt/car/default/images/logo/masterbrand/png/100/m_3_100.png?version=20200120154417",
    var weight:Int?//": 80,
    var initial:String?//": "B",
    var spell:String?//": "baoma",
    var saleStatus:Int?//": 1,
    var modelType = YCNewCarModelType.common
    var labelList:[labelList]?//": [ { "content": "购车优惠", "color": "#FF4B3B" } ]
    
    // preferentialBrand
    var PB_BsId:String?//":"25",
    var PB_BsName:String?//":"三菱",
    var Spell:String?//":"S"
    var label:String?
    
    // parallelImport
    var brandId:Int?//": 92,
    var brandName:String?//": "阿尔法·罗密欧"
    
    required init() {}
}

class labelList: HandyJSON {
    
    var content:String?//": "购车优惠",
    var color:String?//": "#FF4B3B"
    
    required init() { }
}

class hotCarSerial:HandyJSON{
    var csId:Int?//": 2370,
    var csShowName:String?//": "朗逸",
    var image:String?//": "http://img4.bitautoimg.com/autoalbum/files/20191203/135/0340111354_6.jpg",
    var dealerPrice:String?//": "9.99-16.19万"
    required init() { }
}

class carIcon:HandyJSON{
    var id:Int?//": 2801,
    var image:String?//": "http://image.bitautoimg.com/appimage/cms/20190701/w168_h168_11bc8ca6dd8e4f80a5b8975c6ecc9385.png",
    var urlschema:String?//": "bitauto.yicheapp://yiche.app/xuanche.carrank?type=0&from=0&level=&button=xinchexiaoliangpaihang",
    var title:String?//": "销量排行",
    var type:Int?//": 53,
    var marker:String?//": "http://image.bitautoimg.com/appimage/cms/20190701/w90_h48_ceabfae6be6144ba81a774c01aaad8dc.png"
    required init() { }
}

class carPrice:HandyJSON{
    var id:Int?//": 1,
    var title:String?//": "5万以下",
    var condition:String?//": "p=0-5"
    required init() { }
}

class carLevel: HandyJSON {
    var id:Int?//": 1,
    var title:String?//": "紧凑型车",
    var condition:String?//": "l=3"
    required init() { }
}

class hotCarBrand:HandyJSON{
    var masterId:Int?//": 8,
    var masterName:String?//": "大众",
    var image:String?//": "http://image.bitautoimg.com/bt/car/default/images/logo/masterbrand/png/100/m_8_100.png?version=20200120154417",
    var squence:Int?//": 4,
    var saleStatus:Int?//": 1
    required init() { }
}
