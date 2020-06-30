//
//  YCUsedCarViewController.swift
//  qichehui
//
//  Created by SMART on 2019/12/2.
//  Copyright © 2019 SMART. All rights reserved.
//

import UIKit
import HandyJSON

class YCUsedCarViewController: YCBaseViewController {
    
    private var usedCartopimageModels:[YCUsedCarHeaderCartopimageModel]?
    private var tagModels:[YCUsedCarHeadertagsListModel]?
    private var brandsModels:[YCUsedCarHeaderBrandsListModel]?
    private var labelModes:[YCUsedCarHeaderLabelsListMoel]?
    private var favorModels:[YCUsedCarguessFavorVoListModel]?
    private var adInfoModels:[YCUsedCarAdInfoModel]?
    
    private var brandModels = [YCUsedCarCarBrandModel]()
    private var indexTitles = [String]()
    private var sectionModelArr = [[YCUsedCarCarBrandModel]]()
    private var location:String = "定位中..."
    
    private lazy var leftItem:UIButton = {
        let btn = UIButton()
        btn.titleLabel?.textColor = UIColor.darkGray
        btn.titleLabel?.font = FONT_SIZE_13
        btn.titleLabel?.text = self.location
        btn.titleLabel?.lineBreakMode = .byTruncatingTail
        btn.titleLabel?.frame.size = CGSize.init(width: 30, height: 30)
        return btn
    }()
    
    private lazy var customBarView:UIView = {
        let customBarView = UIView.init(frame: CGRect.init(x: 0, y: STATUS_BAR_HEIGHT, width: SCREEN_WIDTH, height: NAVIGATION_BAR_HEIGHT-STATUS_BAR_HEIGHT))
        self.navigationController?.navigationBar.addSubview(customBarView)
        customBarView.backgroundColor = UIColor.clear
        customBarView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        return customBarView
    }()
    
    private lazy var headerView:YCUsedCarHeaderView = {return YCUsedCarHeaderView()}()
    
    private lazy var tableView:UITableView = {
        let tableView = UITableView.init(frame: CGRect.zero, style: UITableView.Style.plain)
        tableView.frame = view.bounds
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionIndexColor = UIColor.lightGray
        tableView.tableFooterView = UIView.init()
        tableView.separatorStyle = .none
        tableView.sectionIndexBackgroundColor = UIColor.clear
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        loadData()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    }
    
    func  initUI(){
        setupNavigationBar()
    }
    
    func setupNavigationBar(){
        
        // left item
        customBarView.addSubview(leftItem)
        LocationManager.shareInstance.loadLocation {[weak self] (address, _, _, error ) in
            guard let self = self else{return}
            self.leftItem.setTitle(address ?? "深圳", for: UIControl.State.normal)
        }
        leftItem.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(MARGIN_15)
        }
        
        // right item
        let rightItem = UIButton()
        rightItem.setImage(UIImage(named: "Nar_ico_news_black"), for: UIControl.State.normal)
        customBarView.addSubview(rightItem)
        rightItem.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-MARGIN_20)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(30)
        }
        
        let titleView = NavigationItemTitleView.init()
        titleView.backgroundColor = UIColor.white
        titleView.layer.cornerRadius = 5*APP_SCALE
        titleView.backgroundColor = UIColor.white
        titleView.layer.shadowColor = UIColor.lightGray.cgColor
        titleView.layer.shadowRadius = 5
        titleView.layer.shadowOffset = CGSize.zero
        titleView.layer.shadowOpacity = 0.8
        customBarView.addSubview(titleView)
        titleView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.left.equalTo(leftItem.snp_right).offset(MARGIN_20)
            make.right.equalTo(rightItem.snp_left).offset(-MARGIN_20)
            make.height.equalTo(30)
        }
        
        let searchImageView = UIImageView.init(image: UIImage.init(named: "bpt_native_search"))
        titleView.addSubview(searchImageView)
        searchImageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(MARGIN_15)
            make.width.height.equalTo(15)
        }
        let btn = UIButton.init()
        btn.setTitle("哈弗F7", for: UIControl.State.normal)
        btn.setTitleColor(UIColor.lightGray, for: UIControl.State.normal)
        btn.titleLabel?.font = FONT_SIZE_13
        titleView.addSubview(btn)
        btn.snp.makeConstraints { (make) in
            make.centerY.bottom.equalToSuperview()
            make.left.equalTo(searchImageView.snp_right).offset(MARGIN_15)
        }
        
    }
    
    func loadData(){
        
        let group = DispatchGroup()
        let queue = DispatchQueue.global()
        
        // header_info
        group.enter()
        queue.async {
            // 轮播
            guard let json = loadJsonFromFile(sourceName: "get_header_info")?["data"] else{return}
            
            guard let usedCartopimage = json["usedCartopimage"].arrayObject else {return}
            guard let usedCartopimageModels = [YCUsedCarHeaderCartopimageModel].deserialize(from: usedCartopimage) as? [YCUsedCarHeaderCartopimageModel] else{return}
            self.usedCartopimageModels = usedCartopimageModels
            
            // tagsList
            guard let tagsList = json["tagsList"].arrayObject else {return}
            guard let tagModels = [YCUsedCarHeadertagsListModel].deserialize(from: tagsList) as? [YCUsedCarHeadertagsListModel] else {return}
            self.tagModels = tagModels
            
            // brandsList
            guard let brandsList = json["brandsList"].arrayObject else{return}
            guard let brandsModels = [YCUsedCarHeaderBrandsListModel].deserialize(from: brandsList) as? [YCUsedCarHeaderBrandsListModel] else{return}
            self.brandsModels = brandsModels
            
            // labelsList
            guard let labelsList = json["labelsList"].arrayObject else{return}
            guard let labelModes = [YCUsedCarHeaderLabelsListMoel].deserialize(from: labelsList) as? [YCUsedCarHeaderLabelsListMoel] else{return}
            self.labelModes = labelModes
            
            // 猜你喜欢
            guard let guessFavorVoList = json["guessFavorVoList"].arrayObject else{return}
            guard let favorModels = [YCUsedCarguessFavorVoListModel].deserialize(from: guessFavorVoList) as? [YCUsedCarguessFavorVoListModel] else{return}
            self.favorModels = favorModels
            group.leave()
        }
        
        group.enter()
        queue.async {
            // 品牌二手车
            guard let json = loadJsonFromFile(sourceName: "get_ad_info") else{ return }
            guard let ad_info = json["data"]["result"].arrayObject else{return}
            guard let adInfoModels = [YCUsedCarAdInfoModel].deserialize(from: ad_info) as? [YCUsedCarAdInfoModel] else {return}
            self.adInfoModels = adInfoModels
            group.leave()
        }
        
        // brand info
        group.enter()
        queue.async {
            guard let json = loadJsonFromFile(sourceName: "Brand")else{return}
            guard let data = json["data"].arrayObject else {return}
            guard let brandModels = [YCUsedCarCarBrandModel].deserialize(from: data) as? [YCUsedCarCarBrandModel] else { return }
            
            var indexTitles = [String]()
            for (_,model) in brandModels.enumerated() {
                guard let initial = model.initial else {return}
                
                if !indexTitles.contains(initial) {
                    indexTitles.append(initial)
                }
                
            }
            self.indexTitles = indexTitles
            var sectionModelArr = [[YCUsedCarCarBrandModel]]()
            for title in indexTitles {
                var tempArr = [YCUsedCarCarBrandModel]()
                for model in brandModels {
                    guard let initial = model.initial else {return}
                    if initial == title {
                        tempArr.append(model)
                    }
                }
                sectionModelArr.append(tempArr)
            }
            self.sectionModelArr = sectionModelArr
            group.leave()
            
        }
        
        group.notify(queue: DispatchQueue.main) {
            
            self.headerView.usedCartopimageModels = self.usedCartopimageModels
            self.headerView.tagModels = self.tagModels
            self.headerView.brandsModels = self.brandsModels
            self.headerView.labelModes = self.labelModes
            self.headerView.favorModels = self.favorModels
            self.headerView.adInfoModels = self.adInfoModels
            self.headerView.bindData()
            self.headerView.frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: self.headerView.viewH)
            self.tableView.tableHeaderView = self.headerView
            self.tableView.reloadData()
            self.tableView.reloadSectionIndexTitles()
            
            
        }
        
    }
    
}

extension YCUsedCarViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionModelArr.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let tempArr = sectionModelArr[section]
        return tempArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = YCCarBrandCell.tableview(tableview: tableView)
        let tempArr = sectionModelArr[indexPath.section]
        let model = tempArr[indexPath.row]
        cell.model = model
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50*APP_SCALE
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50*APP_SCALE
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = YCCarBrandHeaderView.tableView(tableView: tableView)
        headerView.title = indexTitles[section]
        return headerView
    }
    
    // 右侧索引条
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return indexTitles
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
}
