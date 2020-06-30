//
//  YCHomeShortVideoController.swift
//  qichehui
//
//  Created by SMART on 2020/1/15.
//  Copyright © 2020 SMART. All rights reserved.
//

import UIKit
import HandyJSON

class YCHomeShortVideoController: YCHomeBaseViewController {
    
    private lazy var randomHeightArr = [CGFloat]()
    private lazy var models:[Any] = [Any]()
    private lazy var tags:[YCHomeShortVideoTagsModel] = [YCHomeShortVideoTagsModel]()
    
    private let tagsViewH:CGFloat = 93*APP_SCALE
    private lazy var layout:WaterFlowLayout = {
        let layout = WaterFlowLayout()
        layout.edgeInset = UIEdgeInsets(top: MARGIN_15 + tagsViewH + MARGIN_10, left: MARGIN_15, bottom: 0, right: MARGIN_15)
        layout.minimumLineSpacing = MARGIN_10
        layout.minimumInteritemSpacing = MARGIN_10
        layout.delegate = self
        return layout
    }()
    
    private lazy var tagsView:YCHomeShortVideoTagsView = {
        let tagsView = YCHomeShortVideoTagsView()
        self.collectionView.addSubview(tagsView)
        tagsView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(MARGIN_15)
            make.left.equalToSuperview()
            make.width.equalTo(SCREEN_WIDTH)
            make.height.equalTo(tagsViewH)
        }
        tagsView.backgroundColor = UIColor.white
        return tagsView
    }()
    
    private lazy var collectionView:UICollectionView = {
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        self.view.addSubview(collectionView)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.register(YCHomeShortVideoCell.self, forCellWithReuseIdentifier: String(describing:YCHomeShortVideoCell.self))
        let collectionViewH = self.view.height - tagsViewH - MARGIN_15
        collectionView.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview()
            make.width.equalTo(SCREEN_WIDTH)
            make.height.equalTo(collectionViewH)
        }
        return collectionView
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        
        loadData()
    }
    
    func initUI(){
        self.scrollView = collectionView
    }
    
    func loadData(){
        DispatchQueue.global().async {
            
            if let list = loadJsonFromFile(sourceName: "video_applist")?["data"]["list"].arrayObject{
                var tempArr = [Any]()
                if let models = [YCHomeShortVideoListModel].deserialize(from: list) as? [YCHomeShortVideoListModel]{
                    tempArr.append(contentsOf: models)
                }
                
                if let list = loadJsonFromFile(sourceName: "video_applist")?["data"]["videoHomeStream"].arrayObject{
                    if let models = [YCHomeShortVideoStreamModel].deserialize(from: list) as? [YCHomeShortVideoStreamModel]{
                        for item in models {
                            if let index = item.position{
                                tempArr.insert(item, at: index-1)
                            }
                        }
                    }
                }
                
                self.models = tempArr
                tempArr.forEach { (model) in
                    YCHomeShortVideoCell.rowHeight(model: model)
                }
            }
            
            if let list = loadJsonFromFile(sourceName: "video_tags_type")?["data"].array?.first?["tagslist"].arrayObject{
                if let models = [YCHomeShortVideoTagsModel].deserialize(from: list) as? [YCHomeShortVideoTagsModel]{
                    self.tags = models
                }
            }
            
            DispatchQueue.main.async {
                self.bindData()
            }
        }
    }
    
    func bindData(){
        tagsView.bindData(tags:tags)
        self.collectionView.reloadData()
    }
    
}


extension YCHomeShortVideoController:WaterFlowLayoutDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing:YCHomeShortVideoCell.self), for: indexPath) as! YCHomeShortVideoCell
        let model =  models[indexPath.row]
        cell.model = model
        return cell
    }
    
    func waterFlowLayout(layout: WaterFlowLayout, widthForItem: CGFloat, indexPath: IndexPath) -> CGFloat {
        let model =  models[indexPath.row]
        if (model as AnyObject).isKind(of: YCHomeShortVideoListModel.self){
            if let model =  model as? YCHomeShortVideoListModel {
                return model.rowHeight
            }
        }else{
            if let model =  model as? YCHomeShortVideoStreamModel{
                return model.rowHeight
            }
        }
        
        return 0
        
    }
    
}
