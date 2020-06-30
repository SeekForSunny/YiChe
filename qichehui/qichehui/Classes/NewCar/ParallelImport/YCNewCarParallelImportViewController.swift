//
//  YCNewCarParallelImportViewController.swift
//  qichehui
//
//  Created by SMART on 2020/2/20.
//  Copyright © 2020 SMART. All rights reserved.
//  平行进口

import UIKit

class YCNewCarParallelImportViewController: UIViewController {
    
    weak var delegate:ScrollViewDidScrollDelegate?
    
    private lazy var hotMasterBrands = [YCNewCarParallelImportHotMasterBrandsModel]()
    private lazy var hotModels = [YCNewCarParallelImportHotModelsModel]()
    private lazy var models = [YCNewCarParallelImportCarBrandModel]()
    
    private lazy var headerView:YCNewCarParallelImportHeaderView = {
        let headerView = YCNewCarParallelImportHeaderView()
        return headerView
    }()
    
    private lazy var tableView:UITableView = {
        let tableView = UITableView(frame: self.view.bounds, style: UITableView.Style.plain)
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset.bottom = STATUS_BAR_HEIGHT + TAB_BAR_HEIGHT + 50
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        loadData()
        initUI()
    }
    func loadData(){
        DispatchQueue.global().async {
            if let data = loadJsonFromFile(sourceName: "get_header_info_pingxingjinkou")?["data"]{
                if let hotMasterBrands = data["hotMasterBrands"].arrayObject{
                    if let list = [YCNewCarParallelImportHotMasterBrandsModel].deserialize(from: hotMasterBrands) as? [YCNewCarParallelImportHotMasterBrandsModel]{
                        self.hotMasterBrands = list
                    }
                }
                if let hotModels = data["hotModels"].arrayObject{
                    if let list = [YCNewCarParallelImportHotModelsModel].deserialize(from: hotModels) as?  [YCNewCarParallelImportHotModelsModel]{
                        self.hotModels = list
                    }
                }
            }
            
            if let data = loadJsonFromFile(sourceName: "get_master_brands_pingxingjinkou")?["data"].arrayObject{
                if let list = [YCNewCarParallelImportCarBrandModel].deserialize(from: data) as? [YCNewCarParallelImportCarBrandModel]{
                    self.models = list
                }
            }
            
            DispatchQueue.main.async {
                self.headerView.bindData(hotMasterBrand: self.hotMasterBrands, hotModels: self.hotModels)
                self.headerView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: self.headerView.viewH)
                self.tableView.tableHeaderView = self.headerView
                
                self.tableView.reloadData()
            }
        }
    }
    
    func initUI(){
        tableView.rowHeight = 55*APP_SCALE
    }
    
}

extension YCNewCarParallelImportViewController:UITableViewDataSource,UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let model = self.models[section]
        return model.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = YCNewCarCell.cell(withTableView: tableView)
        let model = self.models[indexPath.section]
        if let item = model.items?[indexPath.row] {
            item.modelType = .parallelImport
            cell.model = item
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = YCCarBrandHeaderView.tableView(tableView: tableView)
        headerView.title = self.models[section].group ?? ""
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35*APP_SCALE
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.scrollView?(didScroll: scrollView)
    }
    
}

