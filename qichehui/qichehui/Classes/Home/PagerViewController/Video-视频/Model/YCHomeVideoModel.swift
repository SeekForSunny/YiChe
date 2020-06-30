//
//  YCHomeVideoModel.swift
//  qichehui
//
//  Created by SMART on 2020/1/1.
//  Copyright © 2020 SMART. All rights reserved.
//

import UIKit
import HandyJSON
class YCHomeVideoModel: HandyJSON {
    var commentCount:Int?
    var coverImgs:[String]?
    var description:String?
    var duration:String?
    var followType:Int?
    var imgCount:Int?
    var mp4Link:String?
    var publishTime:CLongLong?
    var rc_para:[String:Any]?
    var resource:[[String:String]]?
    var shareData:[String:Any]?
    var supportCount:Int?
    var supportStatus:Int?
    var title:String?
    var type:Int?
    var url:String?
    var user:YCHomeVideoUser?
    var visitCount:Int?
    var rowHeight:CGFloat = 0
    
    required init() {}
}

class YCHomeVideoUser:HandyJSON{
    var attentioncount:Int?//":0,
    var avatarpath:String? 
    var fanscount:Int?//":9025,
    var roles:YCHomeVideoRole?
    var showname:String?//":"知车一分钟",
    var uid:String?//":51595607,
    var username:String?//":"车手13401329OR"
    required init() { }
}

class YCHomeVideoRole: HandyJSON {
    var appauthentication:Any?//":null,
    var caridentification:Any?//":null,
    var liveanchor:Any?//":null,
    var media:Any?//":null,
    var organization:Any?//":null,
    var yicheaccount:yicheaccount?
    var yicheauthor:Any?//":null
    required init() { }
}

class yicheaccount:HandyJSON{
    var description:String?//":"汽车评测，汽车资讯，用车知识",
    var state:Int?//":1
    required init() { }
}
