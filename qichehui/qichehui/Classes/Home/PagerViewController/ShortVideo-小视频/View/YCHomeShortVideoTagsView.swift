//
//  YCHomeShortVideoTagsView.swift
//  qichehui
//
//  Created by SMART on 2020/1/15.
//  Copyright © 2020 SMART. All rights reserved.
//

import UIKit

class YCHomeShortVideoTagsView: UIScrollView {
    
    private let itemWidth = 100*APP_SCALE
    private lazy var tags = [YCHomeShortVideoTagsModel]()
    private lazy var cardViewArr:[YCHomeShortVideoTagView] = [YCHomeShortVideoTagView]()
    private var tagsBackgoundImageArr:[String] {
        return ["xspsy_ico_ht_01","xspsy_ico_ht_02","xspsy_ico_ht_03","xspsy_ico_ht_04","xspsy_ico_ht_05","xspsy_ico_ht_qb"]
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI(){
        self.showsHorizontalScrollIndicator = false
    }
    
    func bindData(tags:[YCHomeShortVideoTagsModel]){
        self.tags = Array(tags[0..<5])
        let more = YCHomeShortVideoTagsModel()
        self.tags.append(more)
        if cardViewArr.count < self.tags.count{
            for index in cardViewArr.count ..< self.tags.count{
                let cardView = YCHomeShortVideoTagView()
                cardViewArr.append(cardView)
                self.addSubview(cardView)
                cardView.snp.makeConstraints { (make) in
                    make.left.equalToSuperview().offset(MARGIN_15 + CGFloat(index)*(itemWidth + MARGIN_10))
                    make.top.equalToSuperview()
                    make.height.equalToSuperview()
                    make.width.equalTo(itemWidth)
                }
            }
        }else{
            if cardViewArr.count > self.tags.count{
                for index in self.tags.count..<cardViewArr.count{
                    let cardView = cardViewArr[index]
                    cardView.isHidden = true
                }
            }
        }
        
        for (index,model) in self.tags.enumerated() {
            let cardView = cardViewArr[index]
            cardView.isHidden = false
            cardView.bindData(model:model,backgoundImageName:self.tagsBackgoundImageArr[index])
        }
        
        self.contentSize = CGSize(width: 2*MARGIN_15 + CGFloat(self.tags.count)*itemWidth + CGFloat(self.tags.count-1) * MARGIN_10, height: 0)
        
    }
    
}
