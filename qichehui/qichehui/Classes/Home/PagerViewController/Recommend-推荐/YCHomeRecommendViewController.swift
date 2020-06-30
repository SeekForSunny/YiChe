//
//  ViewController.swift
//  qichehui
//
//  Created by SMART on 2019/12/30.
//  Copyright © 2019 SMART. All rights reserved.
//

import UIKit

class YCHomeRecommendViewController: YCHomeBaseViewController {
    
    // YCADSModel ? YCHomeModel
    private lazy var models:[Any] = {return [Any]() }()
    private var callScroll:Bool = true
    private lazy var tableView:UITableView = {
        let tableView = UITableView.init(frame: view.bounds)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: YCHomeRecommendViewController.self))
        self.view.addSubview(tableView)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    
        loadData()
        initUI()
    }
    func  loadData(){
        DispatchQueue.global().async {[weak self] in
            guard let `self` = self else{return}
            guard let json = loadJsonFromFile(sourceName: "tuijian")else{return}
            guard let list = json["data"]["list"].arrayObject else{return}
            guard let models = [YCHomeModel].deserialize(from: list) as? [YCHomeModel] else { return }
  
            var tempArr = [YCADSModel]()
            if let ads = loadJsonFromFile(sourceName: "ads")?["content"]["result"].arrayObject {
                if let models = [YCADSModel].deserialize(from: ads) as? [YCADSModel]  {
                    tempArr = models
                }
            }
            
            tempArr.forEach { (model) in
                if model.type == 2 {
                    YCADType2Cell.cellH(model: model)
                }
            }
            
            var i = 0
            for (index, model) in models.enumerated(){
                self.models.append(model)
                if index > 0 && model.rc_para?.dma == "cf1"{
                    if i < tempArr.count - 1 {
                        self.models.append(tempArr[i])
                        i += 1;
                    }
                }
            }
            
            models.forEach(){model in
                if model.type == 21{
                    YCHomeType21Cell.cellH(model:model)
                }else if model.type == 4{
                    YCHomeType4Cell.cellH(model:model)
                }else if model.type == 30 {
                    YCHomeType30Cell.cellH(model: model)
                }
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func initUI(){
        view.backgroundColor = UIColor.white
        tableView.rowHeight = 44
        self.scrollView = tableView
    }
    
}

extension YCHomeRecommendViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // YCADSModel ? YCHomeModel
        if let model = models[indexPath.row] as? YCHomeModel {
            if model.type == 21 {
                let cell = YCHomeType21Cell.cellWith(tableView:tableView)
                cell.model = model
                return cell
            }else if model.type == 4 {
                let cell = YCHomeType4Cell.cellWith(tableView:tableView)
                cell.model = model
                return cell
            }else if model.type == 30 {
                let cell = YCHomeType30Cell.cellWith(tableView:tableView)
                cell.model = model
                return cell
            }
        }
        
        if let model = models[indexPath.row] as? YCADSModel {
            if model.type == 2 {
                let cell = YCADType2Cell.cellWith(tableView:tableView)
                cell.model = model
                return cell
            }
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: YCHomeRecommendViewController.self), for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        if let model = models[indexPath.row] as? YCHomeModel {
            return model.rowHeight
        }
        
        if let model = models[indexPath.row] as? YCADSModel {
            return model.rowHeight
        }
        
        return 0
    }
    
}
