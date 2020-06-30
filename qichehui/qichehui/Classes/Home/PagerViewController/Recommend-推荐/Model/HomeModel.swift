//
//  HomeModel.swift
//  qichehui
//
//  Created by SMART on 2019/12/30.
//  Copyright © 2019 SMART. All rights reserved.
//

import UIKit
import HandyJSON
class YCHomeModel: HandyJSON {

    var title:String?
    var coverImgs:[String]?
    var type:Int?
    var imgCount:Int?
    var commentCount:Int?
    var supportCount:Int?
    var visitCount:Int?
    var videoType:Int?
    var mp4Link:String?
    var duration:String?
    var shareData:[ShareData]?
    var user:User?
    var ts:String?
    var newsDetail: String?
    var resource:[Resource]?
    var description:String?
    var rowHeight:CGFloat = 0
    var rc_para: rc_para?
    
    required init() {}
}

class rc_para: HandyJSON {
    var ext:String?
    var dma: String?
    var bk:String?
    var t:String?
    var f:String?
    required init() {}
}

class User: HandyJSON {
    var uid:Int?
    var username:String?
    var showname:String?
    var avatarpath:String?
    var fanscount:Int?
    var attentioncount:Int?
    var roles:[String:Role]?
    
    required init() {}
}

class ShareData: HandyJSON {
    var newsId:Int?
    var type:Int?
    var newsType:Int?
    var videoType:Int?
    var videoUrlData:String?
    var img:String?
    var title:String?
    var content:String?
    var link:String?
    required init() { }
}

class Resource: HandyJSON {
    var name:String?
    var url:String?
    
    required init() { }
}

class Role: HandyJSON {
    var state:Int?
    var description:String?
    required init() { }
}



class YCADSModel:HandyJSON{
    var result: Result?
    var type:Int?
    var rowHeight:CGFloat = 0
    required init() {}
}

class Result: HandyJSON {
    var brandId:Int?;
    var title:String?;
    var videoUrl:String?;
    var content:String?;
    var picUrl:String?;
    required init() { }
}
