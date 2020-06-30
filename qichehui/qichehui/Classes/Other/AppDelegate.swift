//
//  AppDelegate.swift
//  qichehui
//
//  Created by SMART on 2019/12/2.
//  Copyright © 2019 SMART. All rights reserved.
//

import UIKit
import Kingfisher

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var displayLink:CADisplayLink?
    var counter:Double = 0
    var lastTime:Double = 0
    
    private lazy var fpsLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = BOLD_FONT_SIZE_11
        label.textColor = .green
        self.window?.addSubview(label)
        self.window?.insertSubview(label, aboveSubview: (self.window?.rootViewController!.view)!)
        if IS_IPHONEX {
            label.snp.makeConstraints { (make) in
                make.top.equalToSuperview()
                make.right.equalToSuperview().offset(-40*APP_SCALE)
                make.width.equalTo(50*APP_SCALE)
            }
        }else{
            label.snp.makeConstraints { (make) in
                make.top.equalToSuperview()
                make.right.equalToSuperview().offset(-50*APP_SCALE)
                make.width.equalTo(50*APP_SCALE)
                make.height.equalTo(STATUS_BAR_HEIGHT)
            }
        }
        return label
    }()
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

    
        let imageName = getLaunchImage()
        let image = UIImage.init(named: imageName)
        let imageView = UIImageView.init(image: image)
        let launchVc =  UIStoryboard.init(name: "LaunchScreen", bundle: nil).instantiateInitialViewController()
        let lauchView = launchVc?.view
        imageView.frame = lauchView!.bounds
        lauchView?.addSubview(imageView)
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.rootViewController = launchVc
        window?.makeKeyAndVisible()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            self.window?.rootViewController = YCTabBarController()
            self.startFPSMonitoring(self)
        }
        
        configCacheInfo()
        
        return true
    }
    
    func configCacheInfo(){
        let cache = ImageCache.default
        cache.maxMemoryCost = 30*1024*1024
    }
    
    func applicationDidReceiveMemoryWarning(_ application: UIApplication) {
        let cache = ImageCache.default
        cache.clearMemoryCache()
        cache.cleanExpiredDiskCache()
        cache.clearDiskCache()
    }
    
    func startFPSMonitoring(_ delegate:AppDelegate) {
        displayLink = CADisplayLink.init(target: delegate, selector: #selector(displayFps))
        displayLink?.add(to: RunLoop.current, forMode: RunLoop.Mode.common)
    }
    
    @objc
    func displayFps(){
        counter += 1;
        let delta = CFAbsoluteTimeGetCurrent() - lastTime
        if delta > 1.0 {
            let fps = Int(round(counter / delta))
            lastTime = CFAbsoluteTimeGetCurrent()
            counter = 0
            fpsLabel.text = String(describing: "FPS:\(fps)")
        }
        
    }
    
}

