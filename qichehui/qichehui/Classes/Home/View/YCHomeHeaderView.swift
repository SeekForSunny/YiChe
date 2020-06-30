//
//  YCHomeHeaderView.swift
//  qichehui
//
//  Created by SMART on 2019/12/29.
//  Copyright © 2019 SMART. All rights reserved.
//

import UIKit
import FSPagerView

class YCHomeHeaderView: UIView {
    
    var viewH:CGFloat = 0
    
    private var tabList = [YCHomeTabModel]()
    private var focusList = [YCHomeFocusModel]()
    private lazy var tabBtnArr:[YCCustomButton] = [YCCustomButton]()
    private let pagerViewH:CGFloat = 200
    
    private lazy var pagerView:FSPagerView = {
        let pagerView = FSPagerView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: self.pagerViewH))
        pagerView.dataSource = self
        pagerView.delegate = self
        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: String(describing: YCHomeHeaderView.self))
        pagerView.itemSize = CGSize.init(width: SCREEN_WIDTH, height: self.pagerViewH)
        pagerView.automaticSlidingInterval = 5
        pagerView.isInfinite = true
        addSubview(pagerView)
        return pagerView
    }()
    
    private lazy var pageControl:FSPageControl = {
        let pageControl = FSPageControl(frame: CGRect.zero)
        pageControl.contentHorizontalAlignment = .right
        pagerView.addSubview(pageControl)
        pageControl.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview().offset(-MARGIN_30)
            make.bottom.equalToSuperview()
            make.height.equalTo(30*APP_SCALE)
        }
        return pageControl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI(){ }
    
    func setupSukoduView(){
        
        if tabBtnArr.count < tabList.count{
            for _ in tabBtnArr.count ..< tabList.count {
                let btn = YCCustomButton(type: .topImageBottomTitle)
                addSubview(btn)
                tabBtnArr.append(btn)
                btn.addTarget(self, action: #selector(btnClick), for: UIControl.Event.touchUpInside)
            }
        }else{
            for index in  tabList.count ..< tabBtnArr.count {
                let btn = tabBtnArr[index]
                btn.isHidden = true
            }
        }
        
        let COL = 5
        let BTN_WH = (SCREEN_WIDTH - 2*MARGIN_20) / CGFloat(COL)
        for (index,model) in tabList.enumerated() {
            let btn = tabBtnArr[index]
            if let title = model.title {
                btn.setTitle(title, for: UIControl.State.normal)
                btn.setTitleColor(UIColor.darkGray, for: UIControl.State.normal)
                btn.titleLabel?.font = FONT_SIZE_12
            }
            if let url = model.image {
                btn.loadImage(imageURL: url, placeholder: nil)
            }
            btn.snp.makeConstraints { (make) in
                make.left.equalToSuperview().offset(MARGIN_20 + CGFloat(index%COL)*BTN_WH)
                make.top.equalToSuperview().offset(viewH + CGFloat(index/COL)*(BTN_WH+MARGIN_10))
                make.width.height.equalTo(BTN_WH)
            }
        }
        let row = ceil(CGFloat(tabList.count/COL))
        viewH +=  row * BTN_WH + (row - 1) * MARGIN_10 + MARGIN_20
    }
    
    func bindData(focusList: [YCHomeFocusModel], tabList: [YCHomeTabModel]){
        viewH = 0
        
        self.focusList = focusList
        self.tabList = tabList
        
        pageControl.numberOfPages = focusList.count
        pagerView.reloadData()
        viewH += self.pagerViewH + MARGIN_10
        
        setupSukoduView()
    }
    
    @objc func btnClick(sender:YCCustomButton){
        if let index = tabBtnArr.firstIndex(of: sender) {
            print(tabList[index].title ?? "")
        }
    }
    
}

extension YCHomeHeaderView:FSPagerViewDelegate,FSPagerViewDataSource{
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return focusList.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: String(describing: YCHomeHeaderView.self), at: index)
        let model = focusList[index]
        if let url = model.image{
            cell.imageView?.loadImage(imageURL: url, placeholder: nil)
            cell.imageView?.contentMode = .scaleAspectFill
        }
        
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, willDisplay cell: FSPagerViewCell, forItemAt index: Int) {
        pageControl.currentPage = index
    }
    
}
