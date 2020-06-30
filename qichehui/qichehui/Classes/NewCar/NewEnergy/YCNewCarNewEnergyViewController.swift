//
//  YCNewCarNewEnergyViewController.swift
//  qichehui
//
//  Created by SMART on 2020/1/31.
//  Copyright © 2020 SMART. All rights reserved.
//

import UIKit
import HandyJSON

class YCNewCarNewEnergyViewController: UIViewController {
    
    private lazy var models:[YCNewCarBrandModel] = [YCNewCarBrandModel]()
    private lazy var initials:[String] = [String]()
    private lazy var sectionModels:[[YCNewCarBrandModel]] = [[YCNewCarBrandModel]]()
    weak var delegate:ScrollViewDidScrollDelegate?
    
    private lazy var hotMasters:[YCNewEnergyHotMasterModel] =  [YCNewEnergyHotMasterModel]()
    private lazy var worthToBuy:[YCNewEnergyWorthToBuyModel] =  [YCNewEnergyWorthToBuyModel]()
    private lazy var oppositions:[YCNewEnergyOppositionsModel] = [YCNewEnergyOppositionsModel]()
    private lazy var selectConditions:[YCNewEnergySelectConditionsModel] = [YCNewEnergySelectConditionsModel]()
    private lazy var priceReduceList:[YCNewEnergyPriceReduceList] = [YCNewEnergyPriceReduceList]()
    
    private lazy var headerView:YCNewCarNewEnergyHeaderView = {
        let headerView = YCNewCarNewEnergyHeaderView()
        return headerView
    }()
    
    private lazy var tableView:UITableView = {
        let tableView = UITableView.init(frame: CGRect.zero, style: UITableView.Style.plain)
        tableView.frame = view.bounds
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionIndexColor = UIColor.lightGray
        tableView.tableFooterView = UIView.init()
        tableView.separatorStyle = .none
        tableView.contentInset.bottom = STATUS_BAR_HEIGHT + TAB_BAR_HEIGHT + 50
        tableView.sectionIndexBackgroundColor = UIColor.clear
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        
        initUI()
    }
    
    func loadData(){
        DispatchQueue.global().async {
            
            if let data = loadJsonFromFile(sourceName: "newEnergyHeadNoPR_xinnengyuan")?["data"]{
                
                if let hotMaster = data["hotMaster"].arrayObject{
                    if let list = [YCNewEnergyHotMasterModel].deserialize(from: hotMaster) as? [YCNewEnergyHotMasterModel]{
                        self.hotMasters = list
                    }
                }
                
                if let worthToBuy = data["worthToBuy"].arrayObject{
                    if let list = [YCNewEnergyWorthToBuyModel].deserialize(from: worthToBuy) as? [YCNewEnergyWorthToBuyModel]{
                        self.worthToBuy = list
                    }
                }
                
                if let oppositions = data["oppositions"].arrayObject{
                    if let list = [YCNewEnergyOppositionsModel].deserialize(from: oppositions) as? [YCNewEnergyOppositionsModel]{
                        self.oppositions = list
                    }
                }
                
                if let selectConditions = data["selectConditions"].arrayObject{
                    if let list = [YCNewEnergySelectConditionsModel].deserialize(from: selectConditions) as? [YCNewEnergySelectConditionsModel]{
                        self.selectConditions = list
                    }
                }
                
            }
            
            if let priceReduceList = loadJsonFromFile(sourceName: "getENPriceReduceList_xinnengyuan")?["data"]["priceReduceList"].arrayObject{
                if let list = [YCNewEnergyPriceReduceList].deserialize(from: priceReduceList) as? [YCNewEnergyPriceReduceList]{
                    self.priceReduceList = list
                }
            }
            
            if let data = loadJsonFromFile(sourceName: "get_master_brands_xinnengyuan")?["data"].arrayObject{
                if let models = [YCNewCarBrandModel].deserialize(from: data) as? [YCNewCarBrandModel] {
                    self.models = models
                    models.forEach {[weak self] (model) in
                        guard let `self` = self else{return}
                        
                        if let initial = model.initial,!self.initials.contains(initial) {
                            self.initials.append(initial)
                        }
                    }
                    
                    self.initials.forEach { (initail) in
                        var tempArr = [YCNewCarBrandModel]()
                        models.forEach {(model) in
                            if model.initial == initail {
                                tempArr.append(model)
                            }
                        }
                        self.sectionModels.append(tempArr)
                    }
                }
            }
            DispatchQueue.main.async {
                self.headerView.bindData(
                    hotMasters:self.hotMasters,
                    worthToBuy:self.worthToBuy,
                    oppositions:self.oppositions,
                    selectConditions:self.selectConditions,
                    priceReduceList:self.priceReduceList
                )
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

extension YCNewCarNewEnergyViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return initials.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionModels = self.sectionModels[section]
        return sectionModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionModels = self.sectionModels[indexPath.section]
        let model = sectionModels[indexPath.row]
        let cell = YCNewCarCell.cell(withTableView: tableView)
        cell.model = model
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35*APP_SCALE
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = YCCarBrandHeaderView.tableView(tableView: tableView)
        headerView.title = initials[section]
        return headerView
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return initials
    }
    
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return index
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        for view in tableView.subviews {
            if view.isKind(of: NSClassFromString("UITableViewIndex")!){
                view.setValue(FONT_SIZE_13, forKey: "_font")
                view.bounds = CGRect(x: 0, y: 0, width: 15*APP_SCALE, height: 30*APP_SCALE)
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.scrollView?(didScroll: scrollView)
    }
    
}
