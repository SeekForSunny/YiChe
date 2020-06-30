//
//  LocationManager.swift
//  EveryTimes
//
//  Created by SMART on 2019/6/19.
//  Copyright © 2019 SMART. All rights reserved.
//

import UIKit
import CoreLocation

class LocationManager:NSObject {
    
    static let shareInstance = LocationManager()
    
    lazy var locationManager:CLLocationManager = {
        
        let locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        //使用应用程序期间允许访问位置数据
        locationManager.requestWhenInUseAuthorization()
        //设置iOS设备是否可暂停定位来节省电池的电量。如果该属性设为“YES”，则当iOS设备不再需要定位数据时，iOS设备可以自动暂停定位。
        locationManager.pausesLocationUpdatesAutomatically = true
        //定位方式
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //iOS8.0以上才可以使用
        if(UIDevice.current.systemVersion >= "8.0"){
            //始终允许访问位置信息
            locationManager.requestAlwaysAuthorization()
            //使用应用程序期间允许访问位置数据
            locationManager.requestWhenInUseAuthorization()
        }
        return locationManager
    }()
    
    var callback: ((_ address:String?, _ lon:String?, _ lat:String?, _ error:String?)->())?
    
    func loadLocation(callback: @escaping ((_ address: String?, _ lon: String?, _ lat: String?, _ error:String?)->())){
        self.callback = callback
        
        locationManager.delegate = self
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.startUpdatingLocation()
        }else{
            let error = "当前定位服务不可用"
            if let callback = self.callback {callback(nil,nil,nil,error) }
        }
        
    }
    
}

extension LocationManager:CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let newLoca = locations.last {
            CLGeocoder().reverseGeocodeLocation(newLoca, completionHandler: {[weak self] (pms, err) -> Void in
                guard let `self` = self else{return}
                if let newCoordinate = pms?.last?.location?.coordinate {
                    manager.stopUpdatingLocation()
                    let placemark:CLPlacemark = (pms?.last)!
                    let addressDic = placemark.addressDictionary;
                    let lat = "\(newCoordinate.latitude)"
                    let lon = "\(newCoordinate.longitude)"
                    var city = addressDic?["City"] as? NSString
                    city = city?.replacingOccurrences(of: "市", with: "") as NSString?
                    if let callback = self.callback {callback(city as String?,lon,lat,nil) }
                    self.locationManager.stopUpdatingLocation();
                    self.locationManager.delegate = nil
                }else{
                    let error = err?.localizedDescription
                    if let callback = self.callback {callback(nil,nil,nil,error) }
                }
            })
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        if (error as NSError).domain == kCLErrorDomain && (error as NSError).code == CLError.Code.denied.rawValue {
            // User denied your app access to location information.
            // showTurnOnLocationServiceAlert()
        }
        
    }
    
}
