//
//  YCSubjectModel.swift
//  qichehui
//
//  Created by SMART on 2019/12/9.
//  Copyright © 2019 SMART. All rights reserved.
//

import UIKit
import HandyJSON

class YCShowMoreSubjectModel: HandyJSON {
    var cover:String?
    var link:String?
    required init() {}
}

class YCShowMoreCategoryModel: HandyJSON {
    var id:Int?
    var name:String?
    required init() { }
}


class YCSHowMoreProductModel: HandyJSON {
    var id:Int?
    var productType:Int?
    var name:String?
    var cover:String?
    var coins:Int?
    var labels:[String]?
    required init() { }
}
