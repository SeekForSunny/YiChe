//
//  YCHomeAreaModel.swift
//  qichehui
//
//  Created by SMART on 2020/1/4.
//  Copyright © 2020 SMART. All rights reserved.
//

import UIKit
import HandyJSON
class YCHomeAreaOperatorModel: HandyJSON {
    
    var image:String?
    var id:Int?
    var url:String?
    var title:String?
    
    required init() {}
}

class YCHomeAreaRecomentModel: HandyJSON {
    var button:String?
    var image:String?
    var id:Int?
    var title:String?
    var url:String?
    required init() {}
}
