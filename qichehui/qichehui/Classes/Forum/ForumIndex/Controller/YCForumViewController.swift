//
//  YCForumViewController.swift
//  qichehui
//
//  Created by SMART on 2019/12/2.
//  Copyright © 2019 SMART. All rights reserved.
//

import UIKit

fileprivate let kTitleViewH:CGFloat = 50*APP_SCALE
fileprivate let kHeaderViewH:CGFloat = 170*APP_SCALE

class YCForumMainScrollView: UIScrollView,UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}

class YCForumViewController: YCBaseViewController {

    private var canScroll:Bool = true
    private var subViewCanScroll:Bool = false
    private var startOffsetX:CGFloat = 0
    private lazy var controllers:[YCFortumPagerViewController] = {return [YCFortumPagerViewController]()}()
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
    
    private lazy var mainScrollView:YCForumMainScrollView = {
        let mainScrollView = YCForumMainScrollView()
        mainScrollView.delegate = self
        mainScrollView.frame = self.view.bounds
        self.view.addSubview(mainScrollView)
        return mainScrollView
    }()
    
    private lazy var headerView:YCForumHeaderView = {
        let  headerView = YCForumHeaderView()
        self.mainScrollView.addSubview(headerView)
        return headerView
    }()
    
    private lazy var titleView:CSTitleView = {
        let titleView = CSTitleView()
        titleView.backgroundColor = .white
        self.mainScrollView.addSubview(titleView)
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
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: String(describing:YCForumViewController.self))
        mainScrollView.addSubview(collectionView)
        layout.itemSize = CGSize(width: SCREEN_WIDTH, height: SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT - TAB_BAR_HEIGHT - 50)
        collectionView.isPagingEnabled = true
        return collectionView
    }()
    
    
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
        
        loadData()
        initUI()
    }
    
    
    func initUI() {
        setupNavigationBar()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        cleanMemoryCache()
    }
    
    func setupNavigationBar(){
        
        // right item
        let rightItem = UIButton()
        rightItem.setImage(UIImage.init(named: "Nar_ico_news_black"), for: UIControl.State.normal)
        customBarView.addSubview(rightItem)
        rightItem.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-MARGIN_20)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(30)
        }
        
        let titleView = UIView.init()
        customBarView.addSubview(titleView)
        titleView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.height.equalTo(30)
            make.left.equalToSuperview().offset(MARGIN_20)
            make.right.equalTo(rightItem.snp_left).offset(-MARGIN_20)
        }
        titleView.backgroundColor = UIColor.white
        titleView.layer.cornerRadius = 5*APP_SCALE
        titleView.backgroundColor = UIColor.white
        titleView.layer.shadowColor = UIColor.lightGray.cgColor
        titleView.layer.shadowRadius = 5
        titleView.layer.shadowOffset = CGSize.zero
        titleView.layer.shadowOpacity = 0.8
        
        let searchImageView = UIImageView.init(image: UIImage.init(named: "bpt_native_search"))
        titleView.addSubview(searchImageView)
        searchImageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(MARGIN_10)
            make.width.height.equalTo(15)
        }
        let btn = UIButton.init()
        btn.setTitle("哈弗F7", for: UIControl.State.normal)
        btn.setTitleColor(UIColor.lightGray, for: UIControl.State.normal)
        btn.titleLabel?.font = FONT_SIZE_13
        titleView.addSubview(btn)
        btn.snp.makeConstraints { (make) in
            make.centerY.bottom.equalToSuperview()
            make.left.equalTo(searchImageView.snp_right).offset(MARGIN_10)
        }
        
        let cameraBtn = UIButton()
        titleView.addSubview(cameraBtn)
        cameraBtn.setImage(UIImage.init(named: "search_ico_camera"), for: UIControl.State.normal)
        cameraBtn.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-MARGIN_10)
            make.size.equalTo(CGSize.init(width: 15, height: 15))
        }
    }
    
    func loadData(){
        DispatchQueue.global().async {[weak self] in
            guard let `self` = self else{return}
            guard let json = loadJsonFromFile(sourceName: "getsubclasses") else{return}
            guard let data = json["data"].arrayObject  else {return}
            var titles = [String]()
            for item in data {
                if let dict = item as?[String:Any]{
                    if let title = dict["name"] as? String{
                        titles.append(title)
                    }
                }
            }
            OperationQueue.main.addOperation {
                self.bindData(titles)
            }
        }
    }
    
    func bindData(_ titles:[String]){
        
        var controllers = [YCFortumPagerViewController]()
        for index in 0..<titles.count {
            if index == 0{
                let controller = YCChoicenessViewController()
                controllers.append(controller)
            }else if index == 1 {
                let controller = YCFortumHelperViewController()
                controllers.append(controller)
            }else if index == 2 {
                let controller = YCFortumTravelViewController()
                controllers.append(controller)
            }else if index == 3 {
                let controller = YCFortumDriverViewController()
                controllers.append(controller)
            }else if index == 4 {
                let controller = YCFortumPartyViewController()
                controllers.append(controller)
            }else if index == 5 {
                let controller = YCFortumLifeViewController()
                controllers.append(controller)
            }else if index == 6 {
                let controller = YCFortumCarUseViewController()
                controllers.append(controller)
            }else if index == 7 {
                let controller = YCFortumBuyCarViewController()
                controllers.append(controller)
            }else if index == 8 {
                let controller = YCFortumWomanViewController()
                controllers.append(controller)
            }else if index == 9 {
                let controller = YCFortumPhotoViewController()
                controllers.append(controller)
            }else if index == 10 {
                let controller = YCFortumChangeViewController()
                controllers.append(controller)
            }else if index == 11 {
                let controller = YCFortumYardViewController()
                controllers.append(controller)
            }else if index == 12 {
                let controller = YCFortumBayViewController()
                controllers.append(controller)
            }
            self.controllers = controllers
            for controller in controllers{
                controller.delegate = self
            }
            
            headerView.frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: kHeaderViewH)
            
            titleView.frame = CGRect(x: 0, y: kHeaderViewH, width: SCREEN_WIDTH, height: 50)
            titleView.titles = titles
            self.delegate = titleView
            
            pagerView.backgroundColor = UIColor.hexadecimalColor(hexadecimal: "#F0F0F0")
            pagerView.frame = CGRect(x: 0, y: kHeaderViewH + 50, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT - TAB_BAR_HEIGHT - 50)
            
            mainScrollView.contentSize = CGSize.init(width: 0, height: SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT + TAB_BAR_HEIGHT + kHeaderViewH)
        }
        
    }
    
}

extension YCForumViewController:UIScrollViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startOffsetX = scrollView.contentOffset.x
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        if scrollView == mainScrollView{
            if kHeaderViewH < 0 {return}
            
            if !self.canScroll{
                scrollView.contentOffset = CGPoint.init(x: 0, y: kHeaderViewH)
            }
            
            if offsetY >= kHeaderViewH {
                self.canScroll = false
                self.subViewCanScroll = true
            }
        }
        
        if scrollView == pagerView {
            delegate?.scrollView!(scrollView: scrollView, scrolling: startOffsetX)
        }
        
    }
    
}

extension YCForumViewController:YCFortumSubViewCrollDelegate{
    
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

extension YCForumViewController:UICollectionViewDataSource,UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.controllers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing:YCForumViewController.self), for: indexPath)
        cell.subviews.forEach { (view) in
            view.removeFromSuperview()
        }
        let vc = self.controllers[indexPath.row]
        cell.addSubview(vc.view)
        return cell
    }
    
    
}

