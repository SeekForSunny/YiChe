//
//  YCHomeViewController.swift
//  qichehui
//
//  Created by SMART on 2019/12/2.
//  Copyright © 2019 SMART. All rights reserved.
//

import UIKit
import  FSPagerView

class MainScrollView: UIScrollView,UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}


class YCHomeViewController: YCBaseViewController {
    
    private var style: UIStatusBarStyle = .lightContent
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.style
    }
    
    private var canScroll:Bool = true
    private var subViewCanScroll:Bool = false
    private var startOffsetX:CGFloat = 0
    private var barItemWH: Int{
        return 30
    }
    private lazy var tabList = {return [YCHomeTabModel]()}()
    private lazy var focusList = {return [YCHomeFocusModel]()}()
    private lazy var titles:[String] = {return [String]()}()
    
    private lazy var controllers:[YCHomeBaseViewController] = { return [YCHomeBaseViewController]() }()
    
    private weak var delegate:ScrollContentDelegate?
    
    private lazy var customBarView:UIView = {
        let customBarView = UIView.init(frame: CGRect.init(x: 0, y: STATUS_BAR_HEIGHT, width: SCREEN_WIDTH, height: NAVIGATION_BAR_HEIGHT-STATUS_BAR_HEIGHT))
        self.navigationController?.navigationBar.addSubview(customBarView)
        customBarView.backgroundColor = UIColor.clear
        customBarView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        return customBarView
    }()
    
    private lazy var leftItem:UIButton = {
        let leftItem = UIButton()
        leftItem.imageView?.contentMode = .scaleAspectFit
        leftItem.addTarget(self, action: #selector(showProfile), for: UIControl.Event.touchUpInside)
        customBarView.addSubview(leftItem)
        leftItem.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.height.width.equalTo(barItemWH)
        }
        return leftItem
    }()
    
    private lazy var rightItem:UIButton = {
        let rightItem = UIButton.init()
        customBarView.addSubview(rightItem)
        rightItem.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(barItemWH)
        }
        rightItem.addTarget(self, action: #selector(showTest), for: UIControl.Event.touchUpInside)
        return rightItem
    }()
    
    private lazy var headerView:YCHomeHeaderView = {
        let headerView = YCHomeHeaderView()
        mainScrollView.addSubview(headerView)
        return headerView
    }()
    
    private lazy var titleView:CSTitleView = {
        let titleView = CSTitleView()
        titleView.backgroundColor = .white
        mainScrollView.addSubview(titleView)
        return titleView
    }()
    
    private lazy var pagerView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: String(describing:YCHomeViewController.self))
        mainScrollView.addSubview(collectionView)
        layout.itemSize = CGSize(width: SCREEN_WIDTH, height: SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT - TAB_BAR_HEIGHT - 50)
        collectionView.isPagingEnabled = true
        return collectionView
    }()
    
    private lazy var mainScrollView:MainScrollView = {
        let scrollView = MainScrollView(frame: self.view.bounds)
        view.addSubview(scrollView)
        scrollView.delegate = self
        return scrollView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        scrollViewDidScroll(mainScrollView)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        cleanMemoryCache()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        if #available(iOS 11, *){
            mainScrollView.contentInsetAdjustmentBehavior = .never
        }else{
            self.automaticallyAdjustsScrollViewInsets = false
        }
        
        self.canScroll = true
        self.subViewCanScroll = false
        
        self.style = .lightContent
        setNeedsStatusBarAppearanceUpdate()
        
        loadData()
        initUI()
    }
    
    func initUI(){
        setupNavigationBar()
    }
    
    deinit {
        print("~ deinit YCHomeViewController ~")
    }
    
    func setupNavigationBar(){
        
        if let url = YCAccountManager.shareInstance.getAccount()?.avatarPath {
           leftItem.loadImage(imageURL: url, placeholder: nil,radius:15)
        }
        
        let titleView = UIView.init()
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
        btn.setTitle("风行T5", for: UIControl.State.normal)
        btn.setTitleColor(UIColor.lightGray, for: UIControl.State.normal)
        btn.titleLabel?.font = FONT_SIZE_13
        titleView.addSubview(btn)
        btn.snp.makeConstraints { (make) in
            make.centerY.bottom.equalToSuperview()
            make.left.equalTo(searchImageView.snp_right).offset(MARGIN_15)
        }
        
        rightItem.setImage(UIImage.init(named: "Nar_ico_news_white"), for: UIControl.State.normal)
    }
    
    @objc func showProfile(){
        self.tabBarController?.selectedIndex = 4
    }
    
    @objc func showTest(){
        UIApplication.shared.keyWindow?.rootViewController =  ViewController()
    }
    
    func setupHeaderView(){
        
        headerView.bindData(focusList: focusList, tabList: tabList)
        headerView.frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: headerView.viewH)
        
        titleView.frame = CGRect(x: 0, y: self.headerView.viewH, width: SCREEN_WIDTH, height: 50)
        titleView.titles = self.titles
        self.delegate = titleView
        
        pagerView.backgroundColor = UIColor.hexadecimalColor(hexadecimal: "#F0F0F0")
        pagerView.frame = CGRect(x: 0, y: self.headerView.viewH + 50, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT - TAB_BAR_HEIGHT - 50)
        
        mainScrollView.contentSize = CGSize.init(width: 0, height: SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT + headerView.viewH)
        
        for index in 0..<self.titles.count {
            
            if index == 0{
                // 推荐
                let recomendVc = YCHomeRecommendViewController()
                recomendVc.delegate = self
                self.controllers.append(recomendVc)
            }else if index == 1 {
                // 视频
                let videoVc = YCHomeVideoViewController()
                videoVc.delegate = self
                self.controllers.append(videoVc)
            }else if index == 2 {
                // 深圳
                let areaVc = YCHomeAreaViewController()
                areaVc.delegate = self
                self.controllers.append(areaVc)
            }else if index == 3{
                //  直播
                let aliveVc = YCHomeAliveViewController()
                aliveVc.delegate = self
                self.controllers.append(aliveVc)
            }else if index == 4{
                //  小视频
                let shortVideoVc = YCHomeShortVideoController()
                shortVideoVc.delegate = self
                self.controllers.append(shortVideoVc)
            }
            
        }
        
        pagerView.reloadData()
        
    }
    
    func loadData(){
        DispatchQueue.global().async { [weak self] in
            guard let `self` = self else{return}
            guard let data = loadJsonFromFile(sourceName: "common_show")?["data"] else{return}
            if let tabList = data["tabList"].arrayObject {
                if let models = [YCHomeTabModel].deserialize(from: tabList) as? [YCHomeTabModel] {
                    self.tabList = models
                }
            }
            
            if let focusList = data["focusList"].arrayObject {
                if  let models = [YCHomeFocusModel].deserialize(from: focusList) as? [YCHomeFocusModel] {
                    self.focusList = models
                }
            }
            
            guard let tabs = loadJsonFromFile(sourceName: "get_materials")?["data"]["tabs"].arrayValue else {return}
            tabs.forEach { (tab) in
                if let title = tab["name"].string {
                    self.titles.append(title)
                }
            }
            
            OperationQueue.main.addOperation {
                self.setupHeaderView()
            }
        }
    }
}


extension YCHomeViewController:UIScrollViewDelegate{
    
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        if scrollView == mainScrollView {
            let scaleH = headerView.viewH - NAVIGATION_BAR_HEIGHT
            var alpha = offsetY / scaleH
            if alpha > 0.99 { alpha = 0.99 }
            navigationController?.navigationBar.setBackgroundImage(UIImage.image(color: UIColor.init(white: 1, alpha: alpha)), for: UIBarMetrics.default)
            
            if scaleH < 0 {return}
            if !self.canScroll{
                scrollView.contentOffset = CGPoint.init(x: 0, y: scaleH)
            }
            if offsetY >= scaleH {
                self.canScroll = false
                self.subViewCanScroll = true
            }
            
            if offsetY > 0, self.canScroll == false {
                rightItem.setImage(UIImage.init(named: "Nar_ico_news_black"), for: UIControl.State.normal)
                self.style = .default
                setNeedsStatusBarAppearanceUpdate()
            }else{
                rightItem.setImage(UIImage.init(named: "Nar_ico_news_white"), for: UIControl.State.normal)
                self.style = .lightContent
                setNeedsStatusBarAppearanceUpdate()
            }
        }
        
        if scrollView == pagerView{
            delegate?.scrollView?(scrollView: scrollView, scrolling: startOffsetX)
        }
        
    }
    
    
}

extension YCHomeViewController:YCHomeSubScrollViewScrollDelegate{
    func subScrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        if !self.subViewCanScroll {
            scrollView.contentOffset = CGPoint.zero
        }
        
        if offsetY <= 0 {
            self.subViewCanScroll = false
            self.canScroll = true
        }
    }
}

extension YCHomeViewController:UICollectionViewDataSource,UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.controllers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing:YCHomeViewController.self), for: indexPath)
        cell.subviews.forEach { (view) in
            view.removeFromSuperview()
        }
        let vc = self.controllers[indexPath.row]
        cell.addSubview(vc.view)
        return cell
    }
    
}
