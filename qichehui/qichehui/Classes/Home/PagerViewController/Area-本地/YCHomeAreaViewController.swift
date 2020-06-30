//
//  YCHomeAreaViewController.swift
//  qichehui
//
//  Created by SMART on 2019/12/30.
//  Copyright © 2019 SMART. All rights reserved.
//

import UIKit

class YCHomeAreaViewController: YCHomeBaseViewController {
    
    private lazy var operateList:[YCHomeAreaOperatorModel] = {return [YCHomeAreaOperatorModel]()}()
    private lazy var areaRecommendList:[YCHomeAreaRecomentModel] = {return [YCHomeAreaRecomentModel]()}()
    private lazy var models:[YCHomeModel] = {return [YCHomeModel]()}()
    
    private lazy var tableView:UITableView = {
        let tableView = UITableView()
        tableView.frame = self.view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
        //        tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: YCHomeAreaViewController.self))
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.hexadecimalColor(hexadecimal: "#F0F0F0")
        return tableView
    }()
    
    private lazy var headerView:YCHomeAreaHeaderView = {
        let headerView = YCHomeAreaHeaderView()
        return headerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        loadData()
        initUI()
    }
    
    func initUI(){
        self.scrollView = tableView
    }
    
    func loadData(){
        
        DispatchQueue.global().async {
            if let data = loadJsonFromFile(sourceName: "area_tab_show")?["data"]{
                if let list = data["operateList"].arrayObject {
                    if let models = [YCHomeAreaOperatorModel].deserialize(from: list) as? [YCHomeAreaOperatorModel]{
                        self.operateList = models
                    }
                }
                if let list = data["areaRecommendList"].arrayObject{
                    if let models = [YCHomeAreaRecomentModel].deserialize(from: list) as? [YCHomeAreaRecomentModel]{
                        self.areaRecommendList = models
                    }
                }
            }
            
            if let list = loadJsonFromFile(sourceName: "get_area_channel")?["data"]["news"].arrayObject {
                if let models = [YCHomeModel].deserialize(from: list) as? [YCHomeModel]{
                    self.models = models
                    models.forEach(){model in
                        if model.type == 21{
                            YCHomeType21Cell.cellH(model:model)
                        }else if model.type == 30{
                            YCHomeType30Cell.cellH(model:model)
                        }
                    }
                }
            }
            
            DispatchQueue.main.async {
                self.bindData()
            }
        }
    }
    
    func bindData(){
        self.tableView.reloadData()
        
        headerView.bindData(operateList: operateList, recommendList: areaRecommendList)
        headerView.frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: headerView.viewH)
        tableView.tableHeaderView = headerView
    }
}

extension YCHomeAreaViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = models[indexPath.row]
        if model.type == 21 {
            let cell = YCHomeType21Cell.cellWith(tableView:tableView)
            cell.model = model
            return cell
        }else if model.type == 30 {
            let cell = YCHomeType30Cell.cellWith(tableView:tableView)
            cell.model = model
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: YCHomeAreaViewController.self), for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = models[indexPath.row]
        return model.rowHeight
    }
}
