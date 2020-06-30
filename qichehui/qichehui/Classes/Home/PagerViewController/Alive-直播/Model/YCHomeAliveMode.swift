//
//  YCHomeAliveMode.swift
//  qichehui
//
//  Created by SMART on 2020/1/11.
//  Copyright © 2020 SMART. All rights reserved.
//

import UIKit
import HandyJSON
class YCHomeAliveListModel: HandyJSON {
    
    var title:String?
    var coverImgs:[String]?
    var type:Int?
    var visitCount:Int?
    var status:Int?
    var user:YCHomeAliveUser?
    var serialName:String?
    var description:String?
    var beginTime:String?
    required init() {}
    
}


class YCHomeAliveUser: HandyJSON {
    var uid:Int?
    var roles:YCHomeLiveRole?
    var opusCount:Any?
    var followType:Any?
    var showname:String?
    var avatarpath:String?
    var fanscount:String?
    var attentioncount:String?
    required init() { }
}

class YCHomeLiveRole: HandyJSON {
    var organization:Any?
    var yicheauthor:Any?
    var liveanchor:Any?
    required init() {}
}

class YCHomeLiveRecommentUserModel: HandyJSON {
    var roles:YCHomeLiveRole?
    var showname:String?
    var avatarpath:String?
    var fanscount:Int?
    var attentioncount:Int?
    
    required init() {}
}

class YCHomeLiveFocusModel: HandyJSON {
    var coverImgs:[String]?
    var type:Int?
    var status:Int?
    var visitCount:Int?
    var publishTime:String?
    var user:YCHomeAliveUser?
    
    required init() {}
}
