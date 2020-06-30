//
//  TitleView.swift
//  iplay
//
//  Created by SMART on 2017/11/28.
//  Copyright © 2017年 SMART. All rights reserved.
//

import UIKit

protocol CSTitleViewDelegate:class {
    func titleView(titleView:CSTitleView, didClick atIndex:Int)
}

struct CSTitleStyle {
    
    var normalColor:UIColor = UIColor.lightGray
    var selectedColor:UIColor = UIColor.black
    var normalSize:CGFloat = 15*APP_SCALE
    var selectedSize:CGFloat = 18*APP_SCALE
    var indicatorWith:CGFloat = 20*APP_SCALE
    var indicatorHeight:CGFloat = 5*APP_SCALE
    var indicatorColor:UIColor = UIColor.red
    
}

class CSTitleView: UIView {
    
    var titles:[String]?{didSet {setTitles()}}
    var titleStyle:CSTitleStyle = CSTitleStyle()
    lazy var titleBtnArr = [UIButton]()
    var seletedButton:UIButton?
    
    lazy var titleScrollView:UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.frame = self.bounds
        scrollView.showsHorizontalScrollIndicator = false
        addSubview(scrollView)
        return scrollView
    }()

    fileprivate lazy var indicator:UIView = {
        let indicatorView = UIView()
        indicatorView.layer.cornerRadius = self.titleStyle.indicatorHeight * 0.5
        return indicatorView
    }()
    weak var delegate:CSTitleViewDelegate?

    func setTitles()  {
        guard let titles = titles else { return }
        
        let y:CGFloat = 0
        var width:CGFloat = 0
        let height = self.titleScrollView.bounds.height
        var offX:CGFloat = 0
        
        if titleBtnArr.count < titles.count {
            for _ in titleBtnArr.count..<titles.count {
                let button = UIButton()
                titleBtnArr.append(button)
                button.addTarget(self, action:#selector(self.buttonClicked(_:)), for: UIControl.Event.touchUpInside)
            }
        }else{
            for index in titles.count..<titleBtnArr.count {
                let btn = titleBtnArr[index]
                btn.isHidden = true
            }
        }
        
        for (index,title) in titles.enumerated(){
            let button = titleBtnArr[index]
            button.isHidden = false
            button.setTitle(title, for: UIControl.State.normal)
            button.setTitleColor(self.titleStyle.normalColor, for: UIControl.State.normal)
            button.setTitleColor(self.titleStyle.selectedColor, for: UIControl.State.selected)
            button.titleLabel?.font = UIFont.systemFont(ofSize: self.titleStyle.normalSize)
            button.sizeToFit()
            let btnSize = button.frame.size
            width = btnSize.width + 20*APP_SCALE
            button.frame = CGRect(x: offX, y: y, width: width, height: height)
            titleScrollView.addSubview(button)
            offX += width
        }
        self.titleScrollView.contentSize = CGSize.init(width: offX, height: 0)
        
        //设置指示器
        self.setupIndicator()
        
    }
    
    func setupIndicator(){
        
        guard let firstButton = self.titleBtnArr.first else {return}
        
        firstButton.titleLabel?.sizeToFit()
        let iX = firstButton.frame.maxX  - firstButton.bounds.width * 0.5 - self.titleStyle.indicatorWith*0.5
        let iY = firstButton.bounds.height - self.titleStyle.indicatorHeight - MARGIN_5
        self.indicator.backgroundColor = self.titleStyle.indicatorColor
        self.indicator.frame = CGRect(x: iX, y: iY, width: self.titleStyle.indicatorWith, height: self.titleStyle.indicatorHeight)
        self.titleScrollView.addSubview(self.indicator)
        
        self.buttonClicked(firstButton)
        
    }
    
    @objc func buttonClicked(_ sender:UIButton){
        
        self.seletedButton?.titleLabel?.font = UIFont.systemFont(ofSize: self.titleStyle.normalSize)
        self.seletedButton?.isSelected = false
        sender.isSelected = true
        self.seletedButton = sender
        sender.titleLabel?.font = UIFont.boldSystemFont(ofSize: self.titleStyle.selectedSize)
        
        guard let index = titleBtnArr.firstIndex(of: sender) else { return }
        delegate?.titleView(titleView: self, didClick: index)
        
    }
    
}

extension CSTitleView:ScrollContentDelegate{
    
    func scrollView(scrollView:UIScrollView,scrolling withStartOffsetX:CGFloat){
        let contentOffsetX = scrollView.contentOffset.x
        
        let scrollIndex:CGFloat = contentOffsetX / SCREEN_WIDTH
        
        // 边界处理
        if scrollIndex < 0 {return}
        if scrollIndex > CGFloat(((titles?.count ?? 0) - 1)) {return}
        
        var fromIndex:Int = 0;
        var toIndex:Int = 0;
        var progress:CGFloat = 1
        
        if  contentOffsetX > withStartOffsetX { // 左滑动
            fromIndex = Int(floor(scrollIndex))
            toIndex = Int(ceil(scrollIndex))
            if scrollIndex - CGFloat(fromIndex) != 0{
                progress = (scrollIndex - CGFloat(fromIndex))
            }
        }else{
            fromIndex = Int(ceil(scrollIndex))
            toIndex = Int(floor(scrollIndex))
            if scrollIndex - CGFloat(toIndex) != 0{
                progress = 1 - (scrollIndex - CGFloat(toIndex))
            }
        }
        
        if progress == 1.0{
            let btn = titleBtnArr[toIndex]
            seletedButton?.isSelected = false
            btn.isSelected = true
            seletedButton = btn
        }
        
        let fromdBtn = titleBtnArr[fromIndex]
        let toBtn = titleBtnArr[toIndex]
        
        let kSize = (titleStyle.selectedSize - titleStyle.normalSize)*progress
        fromdBtn.titleLabel?.font = systemFont(ofSize: titleStyle.selectedSize - kSize)
        toBtn.titleLabel?.font = boldSystemFont(ofSize: titleStyle.normalSize + kSize)
        
        let kCenterX = (toBtn.centerX - fromdBtn.centerX) * progress
        indicator.centerX = fromdBtn.centerX +  kCenterX
        
        if progress < 0.5{
            indicator.width = titleStyle.indicatorWith + progress * abs((toBtn.centerX - fromdBtn.centerX))
        }else{
            indicator.width = titleStyle.indicatorWith + (1-progress) * abs((toBtn.centerX - fromdBtn.centerX))
        }
        
        // 调整titleScrollView偏移
        var offsetX = toBtn.center.x - titleScrollView.bounds.width * 0.5
        if offsetX < 0 { offsetX = 0 }
        var space = titleScrollView.contentSize.width - titleScrollView.bounds.width
        if space < 0 {space = titleScrollView.bounds.width + space}
        if offsetX > space { offsetX = space }
        titleScrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
        
    }
    
}

