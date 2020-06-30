//
//  YCHomeVideoViewController.swift
//  qichehui
//
//  Created by SMART on 2019/12/30.
//  Copyright © 2019 SMART. All rights reserved.
//

import UIKit

class YCHomeVideoViewController: YCHomeBaseViewController {
    
    private var models:[YCHomeVideoModel] = {return [YCHomeVideoModel]()}()
    private lazy var tableView:UITableView = {
        let tableView = UITableView(frame: self.view.bounds)
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(YCHomeVideoCell.self, forCellReuseIdentifier: String(describing: YCHomeVideoCell.self))
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.scrollView = tableView
        tableView.tableFooterView = UIView()
        loadData()
    }
    
    func loadData(){
        DispatchQueue.global().async {
            if let data = loadJsonFromFile(sourceName: "shipin")?["data"] {
                if let list = data["list"].arrayObject {
                    if let models = [YCHomeVideoModel].deserialize(from: list) as? [YCHomeVideoModel]{
                        models.forEach { (model) in
                            YCHomeVideoCell.cellH(model: model)
                        }
                        self.models = models
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
            }
        }
    }
    
}

extension YCHomeVideoViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: YCHomeVideoCell.self), for: indexPath) as! YCHomeVideoCell
        let model = models[indexPath.row]
        cell.model = model
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = models[indexPath.row]
        return model.rowHeight
    }
    
}
