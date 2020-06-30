//
//  YCNewCarParallelImportModel.swift
//  qichehui
//
//  Created by SMART on 2020/2/25.
//  Copyright © 2020 SMART. All rights reserved.
//

import UIKit
import HandyJSON

class YCNewCarParallelImportHotMasterBrandsModel: HandyJSON {
    var logoUrl:String?//": "http://image.bitautoimg.com/wap/car/3/9.png?v=0708",
    var brandId:Int?//": 9,
    var brandName:String?//": "奥迪"
    required init() {}
}

class YCNewCarParallelImportHotModelsModel:  HandyJSON{
    var brandId:Int?//": 9,
    var brandName:String?//": "奥迪",
    var makeId:Int?//": 10000003,
    var makeName:String?//": "奥迪",
    var modelImage:String?//": "http://img1.bitautoimg.com/autoalbum/files/20170527/112/1055281121_8.jpg",
    var modelId:Int?//": 10000003,
    var modelName:String?//": "Q5"
    required init() {}
}

class YCNewCarParallelImportCarBrandModel: HandyJSON {
    var group:String?//": "A",
    var items:[YCNewCarBrandModel]?
    
    required init() {}
}
