//
//  YCNewCarLuxuryBrandViewController.swift
//  qichehui
//
//  Created by SMART on 2020/2/12.
//  Copyright © 2020 SMART. All rights reserved.
//  豪华品牌

import UIKit

class YCNewCarLuxuryBrandViewController: UIViewController {
    
    private lazy var hotMaster:[YCNewEnergyHotMasterModel] = [YCNewEnergyHotMasterModel]()
    private lazy var worthToBuy:[YCNewEnergyWorthToBuyModel] = [YCNewEnergyWorthToBuyModel]()
    private lazy var priceReduceList:[YCNewEnergyPriceReduceList] = [YCNewEnergyPriceReduceList]()
    private lazy var models:[YCNewCarLuxuryBrandListModel] = [YCNewCarLuxuryBrandListModel]()
    
    private lazy var headerView:YCNewCarLuxuryBrandHeaderView = {
        let headerView = YCNewCarLuxuryBrandHeaderView()
        return headerView
    }()
    private lazy var tableView:UITableView = {
        let tableView = UITableView(frame: self.view.bounds, style: UITableView.Style.plain)
        self.view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.contentInset.bottom = STATUS_BAR_HEIGHT + TAB_BAR_HEIGHT + 50
        return tableView
    }()
    weak var delegate:ScrollViewDidScrollDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        loadData()
        initContent()
    }
    
    func initContent(){ }
    
    func loadData(){
        DispatchQueue.global().async {
            if let data = loadJsonFromFile(sourceName: "grandBrandHeadNoPR_haohuapinpai")?["data"] {
                if let hotMaster = data["hotMaster"].arrayObject{
                    if let list = [YCNewEnergyHotMasterModel].deserialize(from: hotMaster) as? [YCNewEnergyHotMasterModel]{
                        self.hotMaster = list
                    }
                }
                if let worthToBuy = data["worthToBuy"].arrayObject{
                    if let list = [YCNewEnergyWorthToBuyModel].deserialize(from: worthToBuy) as? [YCNewEnergyWorthToBuyModel]{
                        self.worthToBuy = list
                    }
                }
            }
            
            if let data = loadJsonFromFile(sourceName: "getGBPriceReduceList_haohuapinpai")?["data"]{
                if let priceReduceList = data["priceReduceList"].arrayObject{
                    if let list = [YCNewEnergyPriceReduceList].deserialize(from: priceReduceList) as? [YCNewEnergyPriceReduceList]{
                        self.priceReduceList = list
                    }
                }
            }
            
            if let data = loadJsonFromFile(sourceName: "selectcarforappv2_haohuapinpai")?["data"]{
                if let resList = data["resList"].arrayObject{
                    if let list = [YCNewCarLuxuryBrandListModel].deserialize(from: resList) as? [YCNewCarLuxuryBrandListModel]{
                        self.models = list
                        list.forEach { (model) in
                            YCNewCarLuxuryBrandCell.cellH(model: model)
                        }
                    }
                }
            }
            
            DispatchQueue.main.async {
                self.headerView.bindData(hotMaster: self.hotMaster,priceReduceList:self.priceReduceList, worthToBuy: self.worthToBuy)
                self.headerView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: self.headerView.viewH)
                self.tableView.tableHeaderView = self.headerView
                self.tableView.reloadData()
            }
        }
    }
    
}

extension YCNewCarLuxuryBrandViewController:UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = YCNewCarLuxuryBrandCell.cellWithTableView(tableView)
        let model = self.models[indexPath.row]
        cell.model = model
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.scrollView?(didScroll: scrollView)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = self.models[indexPath.row]
        return model.rowHeight
    }
}
