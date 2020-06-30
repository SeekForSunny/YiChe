//
//  YCFortumModel.swift
//  qichehui
//
//  Created by SMART on 2019/12/12.
//  Copyright © 2019 SMART. All rights reserved.
//

import UIKit
import HandyJSON

class YCFortumModel: HandyJSON {
    var title:String?
    var forumName:String?
    var createTime:String?
    var dailyTagName:String?
    var imageList:[image]?
    var imageCount:Int?
    var repliesNum:Int?
    var likeNum:Int?
    var serial:Int?
    required init() { }
}

class image: HandyJSON {
    var path:Any?
    var height:Any?
    var width:Any?
    var fullPath:String?
    var note:String?
    required init() { }
    
}
