//
//  YCAccountManager.swift
//  qichehui
//
//  Created by SMART on 2019/12/24.
//  Copyright © 2019 SMART. All rights reserved.
//

import UIKit

class YCAccountManager: NSObject {
    
    let storePath = (NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last! as NSString).appendingPathComponent("account.plist")
    
    static let shareInstance: YCAccountManager =  YCAccountManager()
    
    func getAccount() -> YCUserInfo?{
        guard let user = NSKeyedUnarchiver.unarchiveObject(withFile: storePath) as? YCUserInfo else {
            return nil;
        }
        return user;
    }
    
    func save(account:YCUserInfo) -> Bool {
        let success = NSKeyedArchiver.archiveRootObject(account, toFile: storePath)
        guard let _ = NSKeyedUnarchiver.unarchiveObject(withFile: storePath) as? YCUserInfo else{
            logger(message: "获取存储数据失败！")
            return false;
        }
        return success;
    }
}
