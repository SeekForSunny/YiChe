//
//  YCProfileViewController.swift
//  qichehui
//
//  Created by SMART on 2019/12/2.
//  Copyright © 2019 SMART. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import SwiftyJSON
import ObjectMapper
import HandyJSON

// 顶部间隙
let EDGE_INSET_TOP:CGFloat = 15*APP_SCALE

class YCProfileViewController: YCBaseViewController {
    
    private var style: UIStatusBarStyle = .lightContent
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.style
    }
    
    
    // 导航栏Item显示样式
    enum ButtonItemShowModel {
        case dark
        case light
    }
    
    var userInfo:YCUserInfo?
    var modules:[YCProfileModule]?
    var memberStatusInfo:YCProfileMemberStatusInfo?
    var tagModules:[YCProfileTagModel]?
    var orderModules:[YCProfileOrderModel]?
    var carServiceModels:[YCProfileCarServiceModel]?
    var carCoinModels:[YCProfileCarCoinModel]?
    var commonMaterialModels = [YCProfileCommonMaterialModel]()
    
    var headerH:CGFloat = 0
    
    // 背景图
    var backgroundImageView:ASImageNode = {
        let imageView = ASImageNode()
        imageView.image = UIImage(named: "bg_geren")
        imageView.frame = UIScreen.main.bounds
        return imageView
    }()
    
    // HeaderViewNode
    private lazy var headerView:YCProfileHeaderView = {
        return YCProfileHeaderView()
    }()
    
    // 活动专区
    private lazy var tableNode:ASTableNode = {
        let tableNode = ASTableNode.init(style: UITableView.Style.plain)
        return tableNode
    }()
    
    init() {
        super.init(node: ASDisplayNode())
        
        // 加载数据
        DispatchQueue.global().async {[weak self]()->Void in
            self?.loadData()
        }
        
        // 初始化界面
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        scrollViewDidScroll(tableNode.view)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if #available(iOS 11.0, *){
            tableNode.view.contentInsetAdjustmentBehavior = .never
        }else{
            automaticallyAdjustsScrollViewInsets = false
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(showMore), name: NSNotification.Name.init(rawValue: "showMore"), object: nil)
        
    }
    
    deinit {
        print("~~~ deinit YCProfileViewController ~~~")
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc
    func showMore(){
        let showMoreVc = YCShowMoreViewController()
        rt_navigationController?.pushViewController(showMoreVc, animated: true)
    }
    
    //MARK: - 数据加载
    func loadData(){
        
        OperationQueue.main.addOperation {
            self.headerView.viewH = 0
        }
        
        let group = DispatchGroup()
        let queue = DispatchQueue.global()
        
        //MARK: 用户相关
        func indexviewdata(){
            guard let json = loadJsonFromFile(sourceName: "indexviewdata")else{return}
            guard let userInfo = json["data"]["userInfo"].dictionaryObject else{return}
            let user = Mapper<YCUserInfo>().map(JSONObject: userInfo)
            self.userInfo = user
            if let u = user {
                YCAccountManager.shareInstance.save(account: u)
            }
            
            guard let modules = json["data"]["modules"].arrayObject else{return}
            let moduleArr = Mapper<YCProfileModule>().mapArray(JSONObject: modules)
            self.modules = moduleArr
        }
        
        group.enter()
        queue.async(group: group) {
            indexviewdata()
            group.leave()
        }
        
        //MARK:  立即查看
        func get_member_status_info(){
            guard let json = loadJsonFromFile(sourceName: "get_member_status_info")else{return}
            guard let data = json["data"].dictionaryObject else{return}
            let memberStatusInfo = Mapper<YCProfileMemberStatusInfo>().map(JSON: data)
            self.memberStatusInfo = memberStatusInfo
        }
        group.enter()
        queue.async(group: group) {
            get_member_status_info()
            group.leave()
        }
        
        //MARK:  收藏/足迹/发布/卡券/草稿
        func GetUseCarByTagsType1(){
            guard let json = loadJsonFromFile(sourceName: "GetUseCarByTagsType1")else{return}
            guard let data = json["data"].array else { return }
            guard let tagslist = data[0]["tagslist"].arrayObject else {return}
            let tagModules = Mapper<YCProfileTagModel>().mapArray(JSONObject:tagslist)
            self.tagModules = tagModules
            
        }
        group.enter()
        queue.async(group: group) {
            GetUseCarByTagsType1()
            group.leave()
        }
        
        //MARK:  商城订单/购车红包/违章代缴/易车惠/订单
        func get_order_stat(){
            guard let json = loadJsonFromFile(sourceName: "get_order_stat")else{return}
            guard let data = json["data"]["incompleteOrderSort"].arrayObject else { return }
            let modules = Mapper<YCProfileOrderModel>().mapArray(JSONObject:data)
            self.orderModules = modules
        }
        group.enter()
        queue.async(group: group) {
            get_order_stat()
            group.leave()
        }
        
        //MARK:  行车服务
        func GetUseCarByTagsType2(){
            guard let json = loadJsonFromFile(sourceName: "GetUseCarByTagsType2")else{return}
            guard let data = json["data"].array else { return }
            guard let tags = data[0]["tagslist"].arrayObject  else { return  }
            guard let carServiceModels = [YCProfileCarServiceModel].deserialize(from: tags) as? [YCProfileCarServiceModel] else {return}
            self.carServiceModels = carServiceModels
        }
        group.enter()
        queue.async(group: group) {
            GetUseCarByTagsType2()
            group.leave()
        }
        
        //MARK:  车币商城
        func products(){
            guard let json = loadJsonFromFile(sourceName: "products")else{return}
            guard let data = json["data"].arrayObject else { return }
            guard let carCoinModels = [YCProfileCarCoinModel].deserialize(from: data) as? [YCProfileCarCoinModel] else { return }
            self.carCoinModels = carCoinModels
        }
        
        group.enter()
        queue.async(group: group) {
            products()
            group.leave()
        }
        
        //MARK:  活动专区
        func common_material(){
            guard let json = loadJsonFromFile(sourceName: "common_material")else{return}
            guard let data = json["data"].arrayObject else { return }
            guard let models = [YCProfileCommonMaterialModel].deserialize(from: data) as? [YCProfileCommonMaterialModel] else { return }
            self.commonMaterialModels = models
            // print("活动专区",data)
        }
        group.enter()
        queue.async(group: group) {
            common_material()
            group.leave()
        }
        
        group.notify(queue: DispatchQueue.main) {[weak self] ()->() in
            guard let `self` = self else{return}
            
            self.headerView.userInfo = self.userInfo
            self.headerView.modules = self.modules
            self.headerView.memberStatusInfo = self.memberStatusInfo
            self.headerView.tagModules = self.tagModules
            self.headerView.orderModules = self.orderModules
            self.headerView.carServiceModels = self.carServiceModels
            self.headerView.carCoinModels = self.carCoinModels
            self.headerView.bindData()
            
            self.tableNode.reloadData()
            let headerH = self.headerView.viewH
            self.headerH = headerH
            self.headerView.frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: headerH)
            self.headerView.isHidden = false
            self.tableNode.view.tableHeaderView = self.headerView
            
        }
        
    }
    
    // MARK:- 初始化UI
    func initUI(){
        setupBackgoundView()
        setupChildNode()
    }
    
    func setupBackgoundView(){
        view.addSubnode(backgroundImageView)
    }
    
    func setupChildNode(){
        
        node.addSubnode(tableNode)
        tableNode.delegate = self
        tableNode.dataSource = self
        tableNode.frame = CGRect.init(x: 0, y: NAVIGATION_BAR_HEIGHT, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT)
        tableNode.contentInset = UIEdgeInsets.init(top: EDGE_INSET_TOP, left: 0, bottom: TAB_BAR_HEIGHT + MARGIN_20, right: 0)
        
    }
    
}

//MARK:- 导航栏滚动透明
extension YCProfileViewController: UIScrollViewDelegate{
    
    func setupNavigationBar(model:ButtonItemShowModel){
        if model == .dark{
            let scanItem = UIBarButtonItem.init(image: UIImage(named: "Nar_ico_sao_black"), style: UIBarButtonItem.Style.plain, target: self, action: nil)
            let settingItem = UIBarButtonItem.init(image: UIImage(named: "Nar_ico_set_black"), style: UIBarButtonItem.Style.plain, target: self, action: nil)
            let messageItem = UIBarButtonItem.init(image: UIImage(named: "Nar_ico_news_black"), style: UIBarButtonItem.Style.plain, target: self, action: nil)
            navigationItem.rightBarButtonItems = [messageItem,settingItem,scanItem];
            self.style = .default
        }else{
            let scanItem = UIBarButtonItem.init(image: UIImage(named: "Nar_ico_sao_white"), style: UIBarButtonItem.Style.plain, target: self, action: nil)
            let settingItem = UIBarButtonItem.init(image: UIImage(named: "Nar_ico_set_white"), style: UIBarButtonItem.Style.plain, target: self, action: nil)
            let messageItem = UIBarButtonItem.init(image: UIImage(named: "Nar_ico_news_white"), style: UIBarButtonItem.Style.plain, target: self, action: nil)
            navigationItem.rightBarButtonItems = [messageItem,settingItem,scanItem];
            self.style = .lightContent
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        if offsetY > EDGE_INSET_TOP {
            var alpha = offsetY / NAVIGATION_BAR_HEIGHT
            if alpha > 0.99 { alpha = 0.99 }
            navigationController?.navigationBar.setBackgroundImage(UIImage.image(color: UIColor.init(white: 1, alpha: alpha)), for: UIBarMetrics.default)
            setupNavigationBar(model: .dark)
        }else{
            navigationController?.navigationBar.setBackgroundImage(UIImage.image(color: UIColor.clear), for: UIBarMetrics.default)
            setupNavigationBar(model: .light)
            tableNode.backgroundColor = UIColor.clear
        }
        
        if offsetY > 0 {
            tableNode.contentInset.top = 0
            tableNode.backgroundColor = BACK_GROUND_COLOR
        }else{
            tableNode.contentInset.top = EDGE_INSET_TOP
            tableNode.backgroundColor = UIColor.clear
        }
    }
    
}

extension YCProfileViewController:ASTableDelegate,ASTableDataSource{
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return commonMaterialModels.count
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let cellBlock = {[weak self] ()-> ASCellNode in
            guard let `self` = self else { return ASCellNode() }
            let model = self.commonMaterialModels[indexPath.row]
            let cell = YCProfileCell.init(model: model)
            return cell
        }
        return cellBlock
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 20, y: 0, width: SCREEN_WIDTH, height: 50*APP_SCALE))
        headerView.backgroundColor = UIColor.white
        let label = UILabel()
        headerView.addSubview(label)
        label.text = "活动专区"
        label.font = BOLD_FONT_SIZE_18
        label.textColor = UIColor.darkGray
        label.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(MARGIN_20)
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
}
