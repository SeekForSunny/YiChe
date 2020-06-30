//
//  YCHomeType20Cell.swift
//  qichehui
//
//  Created by SMART on 2019/12/30.
//  Copyright © 2019 SMART. All rights reserved.
//

import UIKit

class YCHomeType20Cell: UITableViewCell {
    
    class func cellWith(tableView:UITableView)->YCHomeType20Cell{
        var cell = tableView.dequeueReusableCell(withIdentifier: String(describing: YCHomeType20Cell.self))
        if cell == nil {
            cell = YCHomeType20Cell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: String(describing: YCHomeType20Cell.self))
        }
        cell?.selectionStyle = .none
        return cell as! YCHomeType20Cell
    }
}
