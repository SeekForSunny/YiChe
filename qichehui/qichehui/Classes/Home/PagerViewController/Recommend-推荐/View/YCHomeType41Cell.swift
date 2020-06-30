//
//  YCHomeType41Cell.swift
//  qichehui
//
//  Created by SMART on 2019/12/30.
//  Copyright © 2019 SMART. All rights reserved.
//

import UIKit

class YCHomeType41Cell: UITableViewCell {
    
    class func cellWith(tableView:UITableView)->YCHomeType41Cell{
        var cell = tableView.dequeueReusableCell(withIdentifier: String(describing: YCHomeType41Cell.self))
        if cell == nil {
            cell = YCHomeType41Cell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: String(describing: YCHomeType41Cell.self))
        }
        cell?.selectionStyle = .none
        return cell as! YCHomeType41Cell
    }
}
