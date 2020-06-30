//
//  YCHomeShortVideoModel.swift
//  qichehui
//
//  Created by SMART on 2020/1/15.
//  Copyright © 2020 SMART. All rights reserved.
//

import UIKit
import HandyJSON
class YCHomeShortVideoListModel: HandyJSON {
    var videoHight:String?
    var videoWidth:String?
    var videoUrl:String?
    var videoDuration:Int?
    var commentNumber:Int?
    var praiseNumber:Int?
    var initPraiseNumber:Int?
    var praise:Bool?
    var viewNumber:Int?
    var initViewNumber:Int?
    var videoId:String?
    var title:String?
    var imageUrl:String?
    var firstFrame:String?
    var imageHight:CGFloat?
    var imageWidth:CGFloat?
    var topicName:String?
    var userName:String?
    var userImage:String?
    var auditStatus:Int?
    var previewUrl:String?
    var downloadUrl:String?
    var sourceType:Int?
    var rowHeight:CGFloat = 0
    var imageH:CGFloat = 0
    required init() {}
}

class YCHomeShortVideoTagsModel: HandyJSON {
    var image:String?
    var urlschema:String?
    var title:String?
    var type:Int?
    var tagslist:[Any]?
    required init() {}
}

class YCHomeShortVideoStreamModel: HandyJSON {
    
    var title:String?
    var hintLanguage:String?
    var buttonName:String?
    var position:Int?
    var urlschema:String?
    var type:Int?
    var image:String?
    var needLogin:Bool?
    var rowHeight:CGFloat = 0
    var imageH:CGFloat = 0
    required init() {}
    
}

