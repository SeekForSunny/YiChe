//
//  YCUsedCarModels.swift
//  qichehui
//
//  Created by SMART on 2019/12/6.
//  Copyright © 2019 SMART. All rights reserved.
//

import UIKit
import HandyJSON

class YCUsedCarCarBrandModel: HandyJSON {
    
    var masterName:String?
    var logoUrl:String?
    var weight:Int?
    var initial:String?
    var spell:String?
    var saleStatus:Int?
    var labelList:[Any]?
    
    required init() { }
    
}

class YCUsedCarHeaderCartopimageModel:HandyJSON {
    
    var image:String?
    var urlschema:String?
    
    required init() {
        
    }
}

class YCUsedCarHeaderBrandsListModel:HandyJSON{
    var brandName:String?
    var logoUrl:String?
    var brandId:String?
    
    required init() {
        
    }
}


class YCUsedCarHeaderLabelsListMoel:HandyJSON{
    var id:UInt?
    var paramsKey:String?
    var name:String?
    var paramsValue:String?
    
    required init() {
        
    }
}

class YCUsedCarHeadertagsListModel:HandyJSON{
    var id:Int?
    var image:String?
    var urlschema:String?
    var title:String?
    var type:String?
    
    required init() {
        
    }
}

class YCUsedCarguessFavorVoListModel:HandyJSON{
    var uCarId:String?
    var serialId:Int?
    var carName:String?
    var cityId:Int?
    var carYear:String?
    var serialName:String?
    var cityName:String?
    var displayPrice:String?
    var financialPrice:Any?
    var downPayment:String?
    var monthlyPayment:String?
    var drivingMileage:String?
    var coverUrl:String?
    var licenseDate:String?
    var referPrice:String?
    var videoCount:String?
    var tradeNumber:Int?
    var extUCarId:String?
    var source:Int?
    var labels:[Any]?
    var highlights:[Any]?
    var promotion:Any?
    
    required init() {
        
    }
}


class YCUsedCarAdInfoModelSub:HandyJSON{
    var exposureTp:String?
    var videoUrl:String?
    var picUrl:String?
    var url:String?
    var title:String?
    
    required init() { }
}

class YCUsedCarAdInfoModel:HandyJSON{
    var statusMsg:String?
    var statusCode:Int?
    var result: YCUsedCarAdInfoModelSub?
    required init() { }
}

