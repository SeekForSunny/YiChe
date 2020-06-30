//
//  YCHomeAliveHeaderView.swift
//  qichehui
//
//  Created by SMART on 2020/1/11.
//  Copyright © 2020 SMART. All rights reserved.
//

import UIKit
import FSPagerView

class YCHomeAliveHeaderView: UIView {
    
    var viewH:CGFloat = 0
    private let pagerViewH:CGFloat = 150*APP_SCALE
    private let recViewH:CGFloat = 90*APP_SCALE
    private let optionCardViewH:CGFloat = 35*APP_SCALE
    private let offsetX = -90*APP_SCALE
    private var selectedIndex = 0
    private var focusList:[YCHomeLiveFocusModel]?
    private var recUserList:[YCHomeLiveRecommentUserModel]?
    private lazy var optionBtnArr = {return [UIButton]()}()
    private var catogeries:[String] {
        return ["全部","新车解读","试驾现场","说车","到店探索"]
    }
    
    private lazy var pagerView:FSPagerView = {
        let pagerView = FSPagerView(frame: CGRect.init(x: offsetX, y: MARGIN_10, width: SCREEN_WIDTH - offsetX, height: self.pagerViewH))
        self.addSubview(pagerView)
        pagerView.delegate = self
        pagerView.dataSource = self
        pagerView.itemSize = CGSize.init(width: SCREEN_WIDTH*0.7, height: self.pagerViewH)
        pagerView.automaticSlidingInterval = 5
        pagerView.isInfinite = true
        pagerView.interitemSpacing = 15*APP_SCALE
        pagerView.register(YCHomeAliveHeaderPagerCell.self, forCellWithReuseIdentifier: String(describing: YCHomeAliveHeaderPagerCell.self))
        return pagerView
    }()
    
    private lazy var recUserView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 15*APP_SCALE
        layout.itemSize = CGSize(width: (SCREEN_WIDTH-5*MARGIN_15)/5, height: self.recViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: MARGIN_15, bottom: 0, right: MARGIN_15)
        let collectionView = UICollectionView(frame: CGRect.init(x: 0, y: self.viewH, width: SCREEN_WIDTH, height: self.recViewH),collectionViewLayout:layout)
        collectionView.dataSource = self
        collectionView.register(YCHomeAliveHeaderRecUserCell.self, forCellWithReuseIdentifier: String(describing:YCHomeAliveHeaderRecUserCell.self))
        collectionView.backgroundColor = UIColor.white
        self.addSubview(collectionView)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView;
    }()
    
    private lazy var optionCardView:UIView = {
        let view = UIView()
        self.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.viewH)
            make.height.equalTo(optionCardViewH)
        }
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI(){
        backgroundColor = UIColor.white
        clipsToBounds = true
    }
    
    func bindData(focusList:[YCHomeLiveFocusModel], recUserList:[YCHomeLiveRecommentUserModel]){
        viewH = 0
        self.focusList = focusList
        self.recUserList = recUserList
        pagerView.reloadData()
        viewH += MARGIN_10 + pagerViewH + MARGIN_10
        
        recUserView.reloadData()
        viewH += recViewH + MARGIN_10
        
        self.setupOptionCardView()
        
    }
    
    func setupOptionCardView(){
        optionCardView.backgroundColor = UIColor.white
        guard let userList = recUserList else {return}
        
        if optionBtnArr.count < userList.count {
            for _ in optionBtnArr.count..<userList.count {
                let btn = UIButton()
                btn.layer.cornerRadius = (FONT_SIZE_10.lineHeight + MARGIN_5)*0.5
                btn.clipsToBounds = true
                btn.titleLabel?.font = FONT_SIZE_10
                btn.setTitleColor(UIColor.darkGray, for: UIControl.State.normal)
                btn.setTitleColor(UIColor.white, for: UIControl.State.selected)
                btn.setBackgroundImage(UIImage.image(color: UIColor.red), for: UIControl.State.selected)
                btn.setBackgroundImage(UIImage.image(color: UIColor.clear), for: UIControl.State.normal)
                optionBtnArr.append(btn)
                optionCardView.addSubview(btn)
            }
        }else{
            if userList.count < optionBtnArr.count {
                for index in userList.count..<optionBtnArr.count {
                    let btn = optionBtnArr[index]
                    btn.isHidden = true
                }
            }
        }
        
        var offsetX = MARGIN_15
        for (index,title) in catogeries.enumerated(){
            let btn = optionBtnArr[index]
            btn.isHidden = false
            btn.setTitle(title, for: UIControl.State.normal)
            btn.titleLabel!.sizeToFit()
            let btnSize = btn.titleLabel!.bounds.size
            btn.snp.makeConstraints { (make) in
                make.left.equalToSuperview().offset(offsetX)
                make.centerY.equalToSuperview()
                make.size.equalTo(CGSize.init(width: btnSize.width + MARGIN_10, height: btnSize.height+MARGIN_5))
            }
            offsetX += (btnSize.width+MARGIN_10) + MARGIN_5
        }
        
        let selectedBtn = optionBtnArr[selectedIndex]
        selectedBtn.isSelected = true
        viewH += self.optionCardViewH
    }
    
}

extension YCHomeAliveHeaderView:FSPagerViewDelegate,FSPagerViewDataSource{
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.focusList?.count ?? 0
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: String(describing: YCHomeAliveHeaderPagerCell.self), at: index) as! YCHomeAliveHeaderPagerCell
        if let model = self.focusList?[index]{
            cell.model = model
        }
        return cell
    }
    
}

extension YCHomeAliveHeaderView:UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recUserList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing:YCHomeAliveHeaderRecUserCell.self), for: indexPath) as! YCHomeAliveHeaderRecUserCell
        if  let model = recUserList?[indexPath.row]{
            cell.model = model
        }
        return cell
    }
    
}

