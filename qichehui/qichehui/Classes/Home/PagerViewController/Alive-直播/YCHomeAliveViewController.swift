//
//  YCHomeAliveViewController.swift
//  qichehui
//
//  Created by SMART on 2019/12/30.
//  Copyright © 2019 SMART. All rights reserved.
//

import UIKit


class YCHomeAliveViewController: YCHomeBaseViewController {
    
    private lazy var aliveList:[YCHomeAliveListModel] = {return [YCHomeAliveListModel]()}()
    private lazy var  recUserList:[YCHomeLiveRecommentUserModel] = {return [YCHomeLiveRecommentUserModel]()}()
    private lazy var focusList:[YCHomeLiveFocusModel] = {return [YCHomeLiveFocusModel]()}()
    
    private lazy var headerView:YCHomeAliveHeaderView = {
        let headerView = YCHomeAliveHeaderView()
        return headerView;
    }()
    private lazy var tableView:UITableView = {
        let tableView = UITableView(frame: CGRect.zero)
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        self.scrollView = tableView
        tableView.register(YCHomeAliveCell.self, forCellReuseIdentifier: String(describing: YCHomeAliveCell.self))
        tableView.snp.makeConstraints { (make) in
            make.top.left.height.equalToSuperview()
            make.width.equalTo(SCREEN_WIDTH)
        }
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
    }
    
    func  loadData(){
        
        weak var weakSelf = self
        DispatchQueue.global().async {
            if let data = loadJsonFromFile(sourceName: "get_liveList_zhibo")?["data"].arrayObject {
                if let list = [YCHomeAliveListModel].deserialize(from: data) as?  [YCHomeAliveListModel]{
                    weakSelf?.aliveList = list
                }
            }
            
            if let data = loadJsonFromFile(sourceName: "get_lives_zhibo")?["data"] {
                
                if let recommendUserList = data["recommendUserList"].arrayObject {
                    if let list = [YCHomeLiveRecommentUserModel].deserialize(from: recommendUserList) as?  [YCHomeLiveRecommentUserModel]{
                        weakSelf?.recUserList = list
                    }
                }
                
                if let focusList = data["focusList"].arrayObject{
                    if let list = [YCHomeLiveFocusModel].deserialize(from: focusList) as?  [YCHomeLiveFocusModel]{
                        weakSelf?.focusList = list
                    }
                }
            }
            DispatchQueue.main.async {
                weakSelf?.bindData()
            }
        }
        
    }
    
    func bindData(){
        headerView.bindData(focusList: self.focusList, recUserList: self.recUserList)
        headerView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: headerView.viewH)
        tableView.reloadData();
        tableView.tableHeaderView = headerView
    }
    
}

extension YCHomeAliveViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aliveList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: YCHomeAliveCell.self), for: indexPath) as! YCHomeAliveCell
        let model = aliveList[indexPath.row]
        cell.model = model
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 280*APP_SCALE
    }
    
}
