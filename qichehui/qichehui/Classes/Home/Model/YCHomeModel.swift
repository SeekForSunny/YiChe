//
//  YCHomeModel.swift
//  qichehui
//
//  Created by SMART on 2019/12/29.
//  Copyright © 2019 SMART. All rights reserved.
//

import UIKit
import HandyJSON

class YCHomeTabModel: HandyJSON {
    
    var image:String?
    var title:String?
    
    required init() {}
}

class YCHomeFocusModel:HandyJSON{
    var image:String?
    var urlschema:String?
    var title:String?
    
    required init() {}
    
}
