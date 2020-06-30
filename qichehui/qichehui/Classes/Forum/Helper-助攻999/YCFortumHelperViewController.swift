//
//  YCFortumHelperViewController.swift
//  qichehui
//
//  Created by SMART on 2019/12/17.
//  Copyright © 2019 SMART. All rights reserved.
//

import UIKit

class YCFortumHelperViewController: YCFortumPagerViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        loadData()
    }
    
    func loadData(){
        DispatchQueue.global().async {[weak self] in
            guard let `self` = self else{return}
            guard let json = loadJsonFromFile(sourceName: "getlist_zhugong999")else{return}
            guard let list = json["data"]["list"].arrayObject else{return}
            guard let models = [YCFortumModel].deserialize(from: list) as? [YCFortumModel] else { return }
            self.models = models
        }
    }

}
