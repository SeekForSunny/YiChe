//
//  YCNewCarCarViewController.swift
//  qichehui
//
//  Created by SMART on 2020/1/31.
//  Copyright © 2020 SMART. All rights reserved.
//

import UIKit
import HandyJSON
class YCNewCarCarViewController: UIViewController {
    
    private lazy var models:[YCNewCarBrandModel] = [YCNewCarBrandModel]()
    private lazy var initials:[String] = [String]()
    private lazy var sectionModels:[[YCNewCarBrandModel]] = [[YCNewCarBrandModel]]()
    weak var delegate:ScrollViewDidScrollDelegate?
    
    private lazy var carSerials:[hotCarSerial] = [hotCarSerial]()
    private lazy var carIcons:[carIcon] = [carIcon]()
    private lazy var carPrices:[carPrice] = [carPrice]()
    private lazy var carLevels:[carLevel] = [carLevel]()
    private lazy var carBrands:[hotCarBrand] = [hotCarBrand]()
    
    private lazy var headerView:YCNewCarHeaderView = {
        let headerView = YCNewCarHeaderView()
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
            if let data = loadJsonFromFile(sourceName: "get_car_home_icon_xinche")?["data"]{
                
                if let data = data["hotCarSerial"].arrayObject{
                    if let array = [hotCarSerial].deserialize(from: data) as? [hotCarSerial]{
                        self.carSerials = array
                    }
                }
                
                if let data = data["carIcon"].arrayObject{
                    if let array = [carIcon].deserialize(from: data) as? [carIcon]{
                        self.carIcons = array
                    }
                }
                
                if let data = data["carPrice"].arrayObject{
                    if let array = [carPrice].deserialize(from: data) as? [carPrice]{
                        self.carPrices = array
                    }
                }
                
                if let data = data["carLevel"].arrayObject{
                    if let array = [carLevel].deserialize(from: data) as? [carLevel]{
                        self.carLevels = array
                    }
                }
                
                if let data = data["hotCarBrand"].arrayObject{
                    if let array = [hotCarBrand].deserialize(from: data) as? [hotCarBrand]{
                        self.carBrands = array
                    }
                }
                
            }
            
            if let data = loadJsonFromFile(sourceName: "get_master_brands_xinche")?["data"].arrayObject{
                if let models = [YCNewCarBrandModel].deserialize(from: data) as? [YCNewCarBrandModel] {
                    self.models = models
                    
                    var carInfo = [String:String]()
                    models.forEach {[weak self] (model) in
                        carInfo[model.masterName!] = model.logoUrl
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
            
                    UserDefaults.standard.set(carInfo, forKey: "ALL_BRAND_INFO")
                }
            }
            DispatchQueue.main.async {
                self.headerView.bindData(
                    carIcons:self.carIcons,
                    carBrands:self.carBrands,
                    carPrices:self.carPrices,
                    carLevels:self.carLevels,
                    carSerials:self.carSerials
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

extension YCNewCarCarViewController:UITableViewDelegate,UITableViewDataSource{
    
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
                view.setValue(FONT_SIZE_10, forKey: "_font")
                view.bounds = CGRect(x: 0, y: 0, width: 15*APP_SCALE, height: 15*APP_SCALE)
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.scrollView?(didScroll: scrollView)
    }
    
}
