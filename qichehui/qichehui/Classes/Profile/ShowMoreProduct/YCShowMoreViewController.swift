//
//  YCShowMoreViewController.swift
//  qichehui
//
//  Created by SMART on 2019/12/8.
//  Copyright © 2019 SMART. All rights reserved.
//

import UIKit
import HandyJSON
import AsyncDisplayKit

class YCShowMoreViewController: YCBaseViewController{
    private var headerH:CGFloat = 0
    
    private var subjects = [YCShowMoreSubjectModel]()
    private var categories = [YCShowMoreCategoryModel]()
    private var products = [YCSHowMoreProductModel]()
    
    private lazy var tableNode:ASTableNode = {
        let tableNode = ASTableNode.init(style: UITableView.Style.plain)
        tableNode.delegate = self
        tableNode.dataSource = self
        tableNode.view.rowHeight = 100*APP_SCALE
        tableNode.view.separatorStyle = .none
        tableNode.view.tableFooterView = UIView()
        node.addSubnode(tableNode)
        tableNode.frame = node.bounds
        tableNode.backgroundColor = UIColor.white
        return tableNode
    }()
    
    private lazy var headerNode:ASDisplayNode = {
        let headerNode = ASDisplayNode.init { () -> UIView in
            return YCSHowMoreHeaderView()
        }
        return headerNode
    }()
    
    private lazy var titleView:YCShowMoreTitleView = {
        let view = YCShowMoreTitleView()
        view.frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 50*APP_SCALE)
        return view
    }()
    
    init() {
        super.init(node: ASDisplayNode())
        initUI()
        loadData()
    }
    
    deinit {
        print("~~~ deinit YCShowMoreViewController ~~~")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        cleanMemoryCache()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func initUI(){
        navigationItem.title = "车币商城"
        view.backgroundColor = UIColor.white
    }
    
    func loadData(){
        weak var weakSelf = self
        DispatchQueue.global().async {
            
            if let subject = loadJsonFromFile(sourceName: "subject") {
                if let data = subject["data"].arrayObject {
                    if let subjects = [YCShowMoreSubjectModel].deserialize(from: data)  as? [YCShowMoreSubjectModel] {
                        weakSelf?.subjects = subjects
                    }
                }
            }
            
            if let category = loadJsonFromFile(sourceName: "category") {
                if let data = category["data"].arrayObject {
                    if let categories = [YCShowMoreCategoryModel].deserialize(from: data)  as? [YCShowMoreCategoryModel]{
                        weakSelf?.categories = categories
                    }
                }
            }
            
            if let products = loadJsonFromFile(sourceName: "more_products") {
                if let data = products["data"].arrayObject {
                    if let products = [YCSHowMoreProductModel].deserialize(from: data) as? [YCSHowMoreProductModel]{
                        weakSelf?.products = products
                    }
                }
            }
            
            OperationQueue.main.addOperation {
                if let headerView = weakSelf?.headerNode.view as? YCSHowMoreHeaderView {
                    headerView.models = self.subjects
                    
                    let headerH = headerView.viewH
                    weakSelf?.headerH = headerH
                    weakSelf?.headerNode.frame = CGRect.init(x: 0, y: -headerH, width: SCREEN_WIDTH, height: headerH)
                    weakSelf?.tableNode.view.tableHeaderView = headerView
                    weakSelf?.tableNode.reloadData()
                    weakSelf?.titleView.categories = self.categories
                }

            }
            
        }
    }
}

extension YCShowMoreViewController:ASTableDelegate,ASTableDataSource{
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        let count = Int(ceil(Float(products.count/2)))
        return count
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let cellNodeBlock = {()->ASCellNode in
            let startIndex = indexPath.row*2
            let endIndex = (indexPath.row+1) * 2
            let models: [YCSHowMoreProductModel] = Array(self.products[startIndex..<endIndex])
            let cellNode = YCShowMoreProductCell.init(modes:models)
            return cellNode
        }
        return cellNodeBlock
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return titleView
    }
    
    
}
