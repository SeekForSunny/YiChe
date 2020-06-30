//
//  WaterFlowLayout.swift
//  XiaoHongshu_Swift
//
//  Created by SMART on 2017/7/8.
//  Copyright © 2017年 com.smart.swift. All rights reserved.
//

import UIKit

protocol WaterFlowLayoutDelegate{
    
    func waterFlowLayout(layout:WaterFlowLayout,widthForItem:CGFloat,indexPath:IndexPath)->CGFloat;
}

class WaterFlowLayout: UICollectionViewFlowLayout {
    
    //默认间距
    static let margin:CGFloat = 10*APP_SCALE;
    //列数
    var columnsCount:Int = 2
    //行间距
    var rowMargin = margin
    //列间距
    var columnMargin = margin
    //边距
    var edgeInset = UIEdgeInsets.init(top: margin, left: margin, bottom: margin, right: margin)
    
    //属性数组
    lazy var attrArr:[UICollectionViewLayoutAttributes] = {return []}()
    //高度数组
    lazy var heightArr:[CGFloat] = {
        var tempArr:[CGFloat] = [];
        for _ in 0..<self.columnsCount{
            tempArr.append(self.edgeInset.top);
        }
        return tempArr
    }()
    
    //代理
    var delegate:WaterFlowLayoutDelegate?
    
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func prepare() {
        super.prepare()
        
        heightArr.removeAll(keepingCapacity: true)
        
        for _ in 0..<self.columnsCount{
            heightArr.append(edgeInset.top);
        }
        
        attrArr.removeAll();
        
        if let count = collectionView?.numberOfItems(inSection: 0){
            
            for i in 0 ..< count{
                if let attr = layoutAttributesForItem(at: IndexPath(item: i, section: 0)){
                    attrArr.append(attr)
                }
            }
            
        }
        
    }
    
    
    //计算滚动范围
    override var collectionViewContentSize: CGSize{
        
        //计算数组中最大值一列
        var maxColun =  0
        for (index,value) in heightArr.enumerated(){
            
            if heightArr[maxColun] < value {
                maxColun = index;
            }
            
        }
        return CGSize(width: 0, height: heightArr[maxColun] + edgeInset.bottom)
    }
    
    
    //设置Item宽度高度,更新高度数组
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        //查找数组中的最小高度所在列
        var minColumn:Int = 0;
        for (index,value) in heightArr.enumerated() {
            if heightArr[minColumn] > value {
                minColumn = index
            }
        }
        
        let width = (SCREEN_WIDTH - edgeInset.left - edgeInset.right - CGFloat(columnsCount-1)*columnMargin)/CGFloat(columnsCount)
        let height = delegate?.waterFlowLayout(layout: self, widthForItem: width, indexPath: indexPath)
        
        let x = edgeInset.left + CGFloat(minColumn)*(width + columnMargin)
        let y = heightArr[minColumn]
        
        
        //更新最短列
        heightArr[minColumn] += height! + rowMargin;
        
        let attr = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        attr.frame = CGRect(x: x, y: y, width: width, height: height!)
        
        return attr
        
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attrArr
    }
    
}
