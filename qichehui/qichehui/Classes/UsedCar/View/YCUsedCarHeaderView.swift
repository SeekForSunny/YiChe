//
//  YCUsedCarHeaderView.swift
//  qichehui
//
//  Created by SMART on 2019/12/7.
//  Copyright © 2019 SMART. All rights reserved.
//

import UIKit
import FSPagerView

class YCUsedCarHeaderView: UIView {
    var viewH:CGFloat = 0
    // 轮播ViewH
    private var pagerViewH:CGFloat = 90*APP_SCALE
    
    var usedCartopimageModels:[YCUsedCarHeaderCartopimageModel]?
    var tagModels:[YCUsedCarHeadertagsListModel]?
    var brandsModels:[YCUsedCarHeaderBrandsListModel]?
    var labelModes:[YCUsedCarHeaderLabelsListMoel]?
    var adInfoModels:[YCUsedCarAdInfoModel]?
    var favorModels:[YCUsedCarguessFavorVoListModel]?
    
    private lazy var tagBtnArr:[YCCustomButton] = {return [YCCustomButton]()}()
    private lazy var brandBtnArr:[YCCustomButton] = {return [YCCustomButton]()}()
    private lazy var labelArr:[UILabel] = {return [UILabel]()}()
    private lazy var adinfoArr:[UIImageView] = {return [UIImageView]()}()
    private lazy var favorArr:[YCUsedCarFavorView] = {return [YCUsedCarFavorView]()}()
    
    private lazy var pagerView:FSPagerView = {
        let pagerView = FSPagerView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: self.pagerViewH))
        pagerView.dataSource = self
        pagerView.delegate = self
        pagerView.register(YCCustomPagerCell.self, forCellWithReuseIdentifier: YCCustomPagerCellResueIdentifier)
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
    
    private lazy var adInfoTitleLabel:UILabel = {
        let label = UILabel()
        label.text = "品牌二手车"
        label.font = BOLD_FONT_SIZE_15
        label.textColor = UIColor.darkGray
        addSubview(label)
        label.sizeToFit()
        let size = label.frame.size
        label.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(self.viewH)
            make.left.equalToSuperview().offset(MARGIN_20)
            make.size.equalTo(size)
        }
        viewH += size.height
        return label
    }()
    
    private lazy var guessTitleLabel:UILabel = {
        let label = UILabel()
        label.text = "猜你喜欢"
        label.font = BOLD_FONT_SIZE_15
        label.textColor = UIColor.darkGray
        addSubview(label)
        label.sizeToFit()
        let size = label.frame.size
        label.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(self.viewH)
            make.left.equalToSuperview().offset(MARGIN_20)
            make.size.equalTo(size)
        }
        viewH += size.height
        return label
    }()
    
    private var scrollViewH:CGFloat = 130*APP_SCALE
    private lazy var favorScrollView:UIScrollView = {
        let scrollView = UIScrollView()
        addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(self.viewH + MARGIN_10)
            make.height.equalTo(scrollViewH)
        }
        scrollView.showsHorizontalScrollIndicator = false
        viewH += MARGIN_10 + scrollViewH
        return scrollView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI(){ }
    
    func bindData(){
        
        viewH = 0
        
        if let _ = usedCartopimageModels {
            pageControl.numberOfPages = usedCartopimageModels?.count ?? 0
            pagerView.reloadData()
            viewH += pagerViewH + MARGIN_15
        }
        
        // 标签
        if let tagModels = tagModels {
            
            if tagBtnArr.count < tagModels.count{
                for _ in tagBtnArr.count ..< tagModels.count {
                    let btn = YCCustomButton(type: .topImageBottomTitle)
                    addSubview(btn)
                    tagBtnArr.append(btn)
                }
            }else{
                for index in tagModels.count ..< tagBtnArr.count{
                    let btn = tagBtnArr[index]
                    btn.isHidden = true
                }
            }
            
            let COL = 5
            let BTN_WH = (SCREEN_WIDTH - 2*MARGIN_20) / CGFloat(COL)
            for (index,model) in tagModels.enumerated() {
                let btn = tagBtnArr[index]
                btn.isHidden = false
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
                    make.top.equalToSuperview().offset(viewH + CGFloat(index/COL)*BTN_WH)
                    make.width.height.equalTo(BTN_WH)
                }
            }
            viewH +=  CGFloat(ceil(Float(tagModels.count/COL))) * BTN_WH + MARGIN_20
            
        }
        
        // 品牌
        if let brandsModels = brandsModels {
            
            if brandBtnArr.count < brandsModels.count{
                for _ in brandBtnArr.count ..< brandsModels.count {
                    let btn = YCCustomButton(type: .topImageBottomTitle)
                    addSubview(btn)
                    brandBtnArr.append(btn)
                }
            }else{
                for index in  brandsModels.count ..< brandBtnArr.count {
                    let btn = brandBtnArr[index]
                    btn.isHidden = true
                }
            }
            
            let COL = 5
            let BTN_WH = (SCREEN_WIDTH - 2*MARGIN_20) / CGFloat(COL)
            for (index,model) in brandsModels.enumerated() {
                let btn = brandBtnArr[index]
                if let title = model.brandName {
                    btn.setTitle(title, for: UIControl.State.normal)
                    btn.setTitleColor(UIColor.darkGray, for: UIControl.State.normal)
                    btn.titleLabel?.font = FONT_SIZE_12
                }
                if let url = model.logoUrl {
                    btn.loadImage(imageURL: url, placeholder: nil)
                }
                btn.snp.makeConstraints { (make) in
                    make.left.equalToSuperview().offset(MARGIN_20 + CGFloat(index%COL)*BTN_WH)
                    make.top.equalToSuperview().offset(viewH + CGFloat(index/COL)*BTN_WH)
                    make.width.height.equalTo(BTN_WH)
                }
            }
            viewH +=  CGFloat(ceil(Float(brandsModels.count/COL))) * BTN_WH + MARGIN_20
            
        }
        
        // 标签
        if let labelModes = labelModes {
            let COL = 5
            let BTN_H = 35*APP_SCALE
            let BTN_W = (SCREEN_WIDTH - MARGIN_20 - MARGIN_15 - CGFloat(COL-1) * MARGIN_10 ) / CGFloat(COL)
            if labelArr.count < labelModes.count{
                for _ in labelArr.count ..< labelModes.count {
                    let label = UILabel()
                    label.layer.cornerRadius = BTN_H * 0.5
                    label.clipsToBounds = true
                    label.font = FONT_SIZE_12
                    label.textColor = UIColor.darkGray
                    label.textAlignment = .center
                    label.backgroundColor = UIColor.hexadecimalColor(hexadecimal: "#EDF2FF")
                    addSubview(label)
                    labelArr.append(label)
                }
            }else{
                for index in  labelModes.count ..< labelArr.count {
                    let label = labelArr[index]
                    label.isHidden = true
                }
            }
            
            for (index,model) in labelModes.enumerated() {
                let label = labelArr[index]
                label.isHidden = false
                if let title = model.name {
                    label.text = title
                }
                label.snp.makeConstraints { (make) in
                    make.left.equalToSuperview().offset(MARGIN_20 + CGFloat(index%COL)*(BTN_W+MARGIN_10))
                    make.top.equalToSuperview().offset(viewH + CGFloat(index/COL)*(BTN_H+MARGIN_10))
                    make.width.equalTo(BTN_W)
                    make.height.equalTo(BTN_H)
                }
            }
            viewH +=  CGFloat(ceil(Float(labelModes.count/COL))) * BTN_H + CGFloat(ceil(Float(labelModes.count/COL) - 1))*MARGIN_10 + MARGIN_20
            
        }
        
        // 品牌二手车
        if var adInfoModels = adInfoModels {
            
            adInfoTitleLabel.backgroundColor = UIColor.white
            
            var tempArr = [YCUsedCarAdInfoModel]()
            for item in adInfoModels {
                if item.result != nil {
                    tempArr.append(item)
                }
            }
            adInfoModels = tempArr
            
            let COL = 4
            let IMAGE_H = 50*APP_SCALE
            let IMAGE_W = (SCREEN_WIDTH - 2*MARGIN_15 - CGFloat(COL-1) * MARGIN_10 ) / CGFloat(COL)
            if adinfoArr.count < adInfoModels.count{
                for _ in adinfoArr.count ..< adInfoModels.count {
                    let imageView = UIImageView()
                    imageView.contentMode = .scaleAspectFit
                    addSubview(imageView)
                    adinfoArr.append(imageView)
                }
            }else{
                for index in  adInfoModels.count ..< adinfoArr.count {
                    let label = adinfoArr[index]
                    label.isHidden = true
                }
            }
            
            for (index,model) in adInfoModels.enumerated() {
                let imageView = adinfoArr[index]
                imageView.isHidden = false
                if let url = model.result?.picUrl {
                    imageView.loadImage(imageURL: url, placeholder: nil)
                }
                imageView.snp.makeConstraints { (make) in
                    make.left.equalToSuperview().offset(MARGIN_20 + CGFloat(index%COL)*(IMAGE_W+MARGIN_10))
                    make.top.equalToSuperview().offset(viewH + CGFloat(index/COL)*(IMAGE_H+MARGIN_10))
                    make.width.equalTo(IMAGE_W)
                    make.height.equalTo(IMAGE_H)
                }
            }
            viewH +=  CGFloat(ceil(Float(adInfoModels.count/COL))) * IMAGE_H + MARGIN_20
            
        }
        
        
        // 猜你喜欢
        if let models = favorModels {
            guessTitleLabel.backgroundColor = UIColor.white
            
            let COL = 3
            let IMAGE_H = 100*APP_SCALE
            let IMAGE_W = (SCREEN_WIDTH - 2*MARGIN_15 - CGFloat(COL-1) * MARGIN_10 ) / CGFloat(COL)
            if favorArr.count < models.count{
                for _ in favorArr.count ..< models.count {
                    let view = YCUsedCarFavorView()
                    favorScrollView.addSubview(view)
                    favorArr.append(view)
                }
            }else{
                for index in  models.count ..< favorArr.count {
                    let view = adinfoArr[index]
                    view.isHidden = true
                }
            }
            
            for (index,model) in models.enumerated() {
                let view = favorArr[index]
                view.model = model
                view.isHidden = false
                view.snp.makeConstraints { (make) in
                    make.left.equalToSuperview().offset(MARGIN_15 + CGFloat(index)*(IMAGE_W+MARGIN_10))
                    make.top.equalToSuperview()
                    make.width.equalTo(IMAGE_W)
                    make.height.equalTo(IMAGE_H)
                }
            }
            
            favorScrollView.contentSize = CGSize.init(width: CGFloat(models.count) * IMAGE_W + CGFloat(models.count-1) * MARGIN_10 + 2 *  MARGIN_15, height: 0)
            
        }
        
    }
    
}

extension YCUsedCarHeaderView:FSPagerViewDelegate,FSPagerViewDataSource{
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return usedCartopimageModels?.count ?? 0
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: YCCustomPagerCellResueIdentifier, at: index) as! YCCustomPagerCell
        if let model = usedCartopimageModels?[index]{
            cell.model = model
        }
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, willDisplay cell: FSPagerViewCell, forItemAt index: Int) {
        pageControl.currentPage = index
    }
    
}
