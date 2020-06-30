//
//  YCNewEnergyModel.swift
//  qichehui
//
//  Created by SMART on 2020/2/4.
//  Copyright © 2020 SMART. All rights reserved.
//

import UIKit
import HandyJSON

class YCNewEnergyHotMasterModel: HandyJSON {
    var image:String?//": "http://image.bitautoimg.com/bt/car/default/images/logo/masterbrand/png/100/m_15_100.png?v=20200120",
    var masterId:Int?//": 15,
    var squence:Int?//": 1,
    var saleStatus:Int?//": 0,
    var masterName:String?//": "比亚迪"
    
    required init() { }
}

class YCNewEnergyWorthToBuyModel: HandyJSON {
    var image:String?//": "http://img3.bitautoimg.com/autoalbum/files/20190215/440/0549114409_4.jpg",
    var subTitle:String?//": "续航500km自主电车",
    var id:Int?//": 9836322,
    var title:String?//": "续航500km电动车",
    var label:String?
    var url:String?//": "bitauto.yicheapp://yiche.app/xuanche.cardescription.detail?newsId=9836322&sourceRequest=0"
    
    required init() { }
}

class YCNewEnergyOppositionsModel: HandyJSON {
    var image:String?//": "http://image.bitautoimg.com/appimage/cms/20190107/w168_h168_b6a27d17901a4d9ca5db059a639bdae2.png",
    var id:Int?//": 1,
    var title:String?//": "附近充电桩",
    var url:String?//": "bitauto.yicheapp://yiche.app/comm.webview?url=https%3A%2F%2Fwww.powerlife.com.cn%2Fh5mbitauto%2Fpile.html"
   
    required init() { }
}

class YCNewEnergySelectConditionsModel: HandyJSON {
    var id:Int?//": 1,
    var title:String?//": "按价格",
    var conditions: [YCNewEnergySelectConditions]?
    
    required init() { }
}
class YCNewEnergySelectConditions: HandyJSON {
    var value:String?//": "5-8万",
    var title:String?//": "f=16,128,512&p=5-8"
    
    required init() { }
}

class YCNewEnergyPriceReduceList:HandyJSON{
    var id:Int?//": 1,
    var title:String?//": "5-8万",
    var list: [YCNewEnergyPriceReduceListInfos]?
    
    required init() { }
}

class YCNewEnergyPriceReduceListInfos:HandyJSON{
    var csId:Int?//": 5290,
    var csShowName:String?//": "宝骏E100",
    var allSpell:String?//": "baojune100",
    var image:String?//": "http://img4.bitautoimg.com/autoalbum/files/20180820/886/1137348866_6.png",
    var dealerPrice:String?//": "4.98-5.98万",
    var dealerCount:String?//": "1.10万",
    var declineRatio:String?//": "18%"
    
    required init() {}
}
