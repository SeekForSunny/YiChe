//
//  YCNewCarViewController.swift
//  qichehui
//
//  Created by SMART on 2019/12/2.
//  Copyright © 2019 SMART. All rights reserved.
//

import UIKit

class YCNewCarViewController: YCBaseViewController {
    
    weak var delegate:ScrollContentDelegate?
    
    private var startOffsetX:CGFloat = 0
    
//    @objc dynamic private var offsetY:CGFloat = 0
//    var observation: NSKeyValueObservation?
    
    
    private lazy var leftItem:UIButton = {
        let btn = UIButton()
        btn.titleLabel?.textColor = UIColor.darkGray
        btn.titleLabel?.font = FONT_SIZE_13
        btn.titleLabel?.text = self.location
        btn.titleLabel?.lineBreakMode = .byTruncatingTail
        btn.titleLabel?.frame.size = CGSize.init(width: 30, height: 30)
        return btn
    }()
    
    private var location:String = "定位中..."
    
    private lazy var customBarView:UIView = {
        let customBarView = UIView.init(frame: CGRect.init(x: 0, y: STATUS_BAR_HEIGHT, width: SCREEN_WIDTH, height: NAVIGATION_BAR_HEIGHT-STATUS_BAR_HEIGHT))
        self.navigationController?.navigationBar.addSubview(customBarView)
        customBarView.backgroundColor = UIColor.clear
        customBarView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        return customBarView
    }()
    
    private lazy var titles:[String] = ["新车","新能源","豪华品牌","特惠品牌","平行进口"]
    private lazy var controllers:[UIViewController] = [UIViewController]()
    
    private lazy var titleView:CSTitleView = {
        let titleView = CSTitleView()
        titleView.frame = CGRect(x: 0, y: 0, width: SCREEN_HEIGHT, height: 50)
        self.view.addSubview(titleView)
        self.delegate = titleView
        return titleView
    }()
    
    private lazy var pagerView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 50 - TAB_BAR_HEIGHT)
        let frame = CGRect(x: 0, y: 50, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 50 - TAB_BAR_HEIGHT)
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: String(describing:YCNewCarViewController.self))
        collectionView.backgroundColor = UIColor.white
        self.view.addSubview(collectionView)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initUI()
        
        if #available(iOS 11.0, *) {
            self.titleView.titleScrollView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
    }
    
    deinit {
        logger(message: "~~ deinit YCNewCarViewController ~~")
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        observation = self.observe(\.offsetY,options: [.new,.old]) {[weak self] (_, change) in
//            guard let `self` = self else{return}
//            if self.offsetY <= 0{return}
//
//            guard let newValue = change.newValue,let oldValue = change.oldValue else {return}
//            if  newValue > oldValue  {
//                self.navigationController?.setNavigationBarHidden(true, animated: true)
//                UIView.animate(withDuration: 0.25) {
//                    self.titleView.frame.origin.y = STATUS_BAR_HEIGHT
//                    self.pagerView.frame.origin.y = STATUS_BAR_HEIGHT + 50
//                }
//            }else{
//                self.navigationController?.setNavigationBarHidden(false, animated: true)
//                UIView.animate(withDuration: 0.25) {
//                    self.titleView.frame.origin.y = 0
//                    self.pagerView.frame.origin.y = 50
//                }
//            }
//        }
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        observation = nil
//    }
    
    
    func  initUI(){
        setupNavigationBar()
        setupContent()
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
        btn.setTitle("风行T5", for: UIControl.State.normal)
        btn.setTitleColor(UIColor.lightGray, for: UIControl.State.normal)
        btn.titleLabel?.font = FONT_SIZE_13
        titleView.addSubview(btn)
        btn.snp.makeConstraints { (make) in
            make.centerY.bottom.equalToSuperview()
            make.left.equalTo(searchImageView.snp_right).offset(MARGIN_15)
        }
        
    }
    
    func setupContent(){
        
        titleView.titles = titles
        for index in 0..<titles.count {
            if index == 0{ //新车
                let controller = YCNewCarCarViewController()
                self.controllers.append(controller)
                controller.delegate = self
            }else if index == 1 {//新能源
                let controller = YCNewCarNewEnergyViewController()
                self.controllers.append(controller)
                controller.delegate = self
            }else if index == 2{// 豪华品牌
                let controller = YCNewCarLuxuryBrandViewController()
                self.controllers.append(controller)
                controller.delegate = self
            }else if index == 3{// 特惠品牌
                let controller = YCNewCarPreferentialBrandViewController()
                self.controllers.append(controller)
                controller.delegate = self
            } else if index == 4{// 平行进口
                let controller = YCNewCarParallelImportViewController()
                self.controllers.append(controller)
                controller.delegate = self
            }else{
                let controller = UIViewController()
                self.controllers.append(controller)
            }
        }
        
        pagerView.reloadData()
    }
    
}

extension YCNewCarViewController:UICollectionViewDataSource,UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing:YCNewCarViewController.self), for: indexPath)
        cell.backgroundColor = UIColor.randomColor()
        cell.subviews.forEach { (view) in
            view.removeFromSuperview()
        }
        let controller = controllers[indexPath.row]
        let view = controller.view
        cell.addSubview(view!)
        return cell
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startOffsetX = scrollView.contentOffset.x
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == pagerView{
            delegate?.scrollView?(scrollView: pagerView, scrolling: startOffsetX)
        }
    }
    
}

extension YCNewCarViewController:ScrollViewDidScrollDelegate {
    func scrollView(didScroll scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
//        self.offsetY = offsetY
        
        if offsetY > 0 {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
            UIView.animate(withDuration: 0.25) {
                self.titleView.frame.origin.y = STATUS_BAR_HEIGHT
                self.pagerView.frame.origin.y = STATUS_BAR_HEIGHT + 50
            }
        }else{
            self.navigationController?.setNavigationBarHidden(false, animated: true)
            UIView.animate(withDuration: 0.25) {
                self.titleView.frame.origin.y = 0
                self.pagerView.frame.origin.y = 50
            }
        }
    }
}
