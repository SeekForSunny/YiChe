//
//  YCFortumPagerViewController.swift
//  qichehui
//
//  Created by SMART on 2019/12/17.
//  Copyright © 2019 SMART. All rights reserved.
//


import UIKit

protocol YCFortumSubViewCrollDelegate:class {
    func subScrollViewDidScroll(_ scrollView: UIScrollView);
}

class YCFortumPagerViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    weak var delegate:YCFortumSubViewCrollDelegate?
    var models:[YCFortumModel]?{didSet{setModels()}}
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.frame = view.bounds
        tableView.register(YCFortumCell.self, forCellReuseIdentifier: String(describing: YCFortumCell.self))
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.contentInset.bottom = TAB_BAR_HEIGHT + NAVIGATION_BAR_HEIGHT + 50
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
    }
    
    func setModels(){
        if let _ = models {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.models?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: YCFortumCell.self), for: indexPath) as? YCFortumCell
        if let model = models?[indexPath.row]{
            cell?.model = model
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100*APP_SCALE
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.subScrollViewDidScroll(scrollView)
    }
}
