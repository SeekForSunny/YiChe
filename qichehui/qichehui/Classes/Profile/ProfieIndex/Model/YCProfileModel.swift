//
//  YCProfileModule.swift
//  qichehui
//
//  Created by SMART on 2019/12/3.
//  Copyright © 2019 SMART. All rights reserved.
//

import UIKit
import ObjectMapper
import HandyJSON

// 用户信息
class YCUserInfo: NSObject, Mappable, NSCoding {
    
    var showName:String?
    var avatarPath:String?
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        showName <- map["showName"]
        avatarPath <- map["avatarPath"]
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(showName, forKey: "showName")
        aCoder.encode(avatarPath, forKey: "avatarPath")
    }
    
    required init?(coder aDecoder: NSCoder) {
        showName = aDecoder.decodeObject(forKey: "showName") as? String
        avatarPath = aDecoder.decodeObject(forKey: "avatarPath") as? String
    }
    
}

class YCProfileModule: Mappable {
    var tip:Int?
    var name:String?
    var iconUrl:String?
    var schema:String?
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        tip <- map["tip"]
        name <- map["name"]
        iconUrl <- map["iconUrl"]
        schema <- map["schema"]
    }
    
}

class YCProfileMemberStatusInfo: Mappable {
    var copyWriter:String?
    var btnCopyWriter: String?
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        copyWriter <- map["copyWriter"]
        btnCopyWriter <- map["btnCopyWriter"]
    }
    
}

class YCProfileTagModel: Mappable {
    var image:String?
    var title:String?
    var urlschema:String?
    var isneedlogin:Bool?
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        image <- map["image"]
        title <- map["title"]
        urlschema <- map["urlschema"]
        isneedlogin <- map["isneedlogin"]
    }
    
}

class YCProfileOrderModel: Mappable {
    
    var title:String?
    var subtitle:String?
    var icon:String?
    var url:String?
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        title <- map["title"]
        subtitle <- map["subtitle"]
        icon <- map["icon"]
        url <- map["url"]
    }
}

class YCProfileCarServiceModel: HandyJSON {
    var title:String?
    var urlschema:String?
    var image:String?
    
    required init() { }
    
}

class YCProfileCarCoinModel: HandyJSON {
    var name:String?
    var coins:UInt?
    var cover:String?
    var labels:[[String:Any]]?
    
    required init() { }
    
}

class YCProfileCommonMaterialModel:HandyJSON{
    var image:String?
    var activityId:String?
    var title:String?
    var url:String?
    
    required init() { }
}
