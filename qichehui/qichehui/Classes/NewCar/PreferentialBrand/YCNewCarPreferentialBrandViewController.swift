//
//  YCNewCarPreferentialBrandViewController.swift
//  qichehui
//
//  Created by SMART on 2020/2/20.
//  Copyright © 2020 SMART. All rights reserved.
//  特惠品牌

import UIKit

class YCNewCarPreferentialBrandViewController: UIViewController {
    
    weak var delegate:ScrollViewDidScrollDelegate?
    private lazy var tangdou = [YCNewCarPreferentialBrandTangDouModel]()
    private lazy var merchandiseShow = [YCNewEnergyWorthToBuyModel]()
    private lazy var sectionModels = [[YCNewCarBrandModel]]()
    private lazy var indexs:[String] = [String]()
    private lazy var headerView:YCNewCarPreferentialBrandHeaderView = {
        let headerView = YCNewCarPreferentialBrandHeaderView()
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
            var labelMap = [String:String]()
            if let data = loadJsonFromFile(sourceName: "GetValue_tehuipinpai"){
                if let tangdou = data["tangdou"].arrayObject{
                    if let list = [YCNewCarPreferentialBrandTangDouModel].deserialize(from: tangdou) as? [YCNewCarPreferentialBrandTangDouModel]{
                        self.tangdou = list
                    }
                }
                
                var merchandiseShows = [[String:String]]()
                if let MerchandiseShow = data["MerchandiseShow"].arrayObject as? [[String:String]]{
                    merchandiseShows.append(contentsOf: MerchandiseShow)
                }
                if let MerchandiseShowtwo = data["MerchandiseShowtwo"].arrayObject as? [[String:String]]{
                    merchandiseShows.append(contentsOf: MerchandiseShowtwo)
                }
                var tempArr = [YCNewEnergyWorthToBuyModel]()
                merchandiseShows.forEach { (item) in
                    let model = YCNewEnergyWorthToBuyModel()
                    model.title = item["Maintitle"]
                    model.subTitle = item["Subtitle"]
                    model.image = item["chetu"]
                    model.label = item["label"]
                    tempArr.append(model)
                }
               self.merchandiseShow = tempArr
                
                if let brandtreelabel = data["brandtreelabel"].arrayObject{
                    if let list = [YCNewCarPreferentialBrandTreelabel].deserialize(from: brandtreelabel) as? [YCNewCarPreferentialBrandTreelabel]{
                        for item in list {
                            if let brandid = item.brandid,let label = item.label{
                                labelMap[brandid] = label
                            }
                        }
                    }
                }
            }
            
            if let data = loadJsonFromFile(sourceName: "getTeHuiPinPaiBsList_tehuipinpai")?["data"].arrayObject{
                if let list = [YCNewCarBrandModel].deserialize(from: data) as? [YCNewCarBrandModel]{
                    
                    var indexs:[String] = [String]()
                    list.forEach { (model) in
                        if let spell = model.Spell,!indexs.contains(spell){
                            indexs.append(spell)
                        }
                    }
                    indexs.sort { (value1, value2) -> Bool in
                        return value1 < value2
                    }
                    logger(message: indexs)
                    self.indexs = indexs
                    
                    indexs.forEach { (index) in
                        var tempArr = [YCNewCarBrandModel]()
                        list.forEach { (model) in
                            model.modelType = .preferentialBrand
                            if let dict = UserDefaults.standard.dictionary(forKey: "ALL_BRAND_INFO") as? [String:String] {
                                if let PB_BsName = model.PB_BsName{
                                    model.logoUrl = dict[PB_BsName]
                                }
                            }
                            if let PB_BsId = model.PB_BsId{
                                model.label = labelMap[PB_BsId]
                            }
                            
                            if let spell = model.Spell{
                                if spell.elementsEqual(index) {
                                    tempArr.append(model)
                                }
                            }
                        }
                        self.sectionModels.append(tempArr)
                    }
                }
            }
            
            DispatchQueue.main.async {
                self.headerView.bindData(tangdou:self.tangdou,merchandiseShow:self.merchandiseShow)
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

extension YCNewCarPreferentialBrandViewController:UITableViewDataSource,UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.indexs.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sectionModels[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = YCNewCarCell.cell(withTableView: tableView)
        let model = self.sectionModels[indexPath.section][indexPath.row]
        cell.model = model
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = YCCarBrandHeaderView.tableView(tableView: tableView)
        headerView.title = self.indexs[section]
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35*APP_SCALE
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.scrollView?(didScroll: scrollView)
    }
    
}
