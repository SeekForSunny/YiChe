//
//  YCShowMoreCellNode.swift
//  qichehui
//
//  Created by SMART on 2019/12/9.
//  Copyright © 2019 SMART. All rights reserved.
//

import UIKit
import AsyncDisplayKit
class YCShowMoreProductCell: ASCellNode {
    
    private let itemW = (SCREEN_WIDTH-2*MARGIN_20-MARGIN_15)/2
    private let itemH = 200*APP_SCALE
    private lazy var leftNode:ASDisplayNode = {
        let node = ASDisplayNode.init {[weak self]  () -> UIView in
            let view = YCShowMorePerProductView()
            view.model = self?.models[0]
            return view
        }
        node.style.preferredSize = CGSize.init(width: itemW, height: itemH)
        return node
    }()
    
    private lazy var rightNode:ASDisplayNode = {
        let node = ASDisplayNode.init {[weak self] () -> UIView in
            let view = YCShowMorePerProductView()
            view.model = self?.models[1]
            return view
        }
        node.style.preferredSize = CGSize.init(width: itemW, height: itemH)
        return node
    }()
    
    private var models:[YCSHowMoreProductModel]
    init(modes:[YCSHowMoreProductModel]) {
        self.models = modes
        super.init()
        initUI()
    }
    
    func initUI(){
        self.automaticallyManagesSubnodes = true
        self.selectionStyle = .none
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let spec = ASStackLayoutSpec.init(direction: ASStackLayoutDirection.horizontal, spacing: MARGIN_15, justifyContent: ASStackLayoutJustifyContent.start, alignItems: ASStackLayoutAlignItems.center, children: [leftNode,rightNode])
        
        let insetSpec = ASInsetLayoutSpec.init(insets: UIEdgeInsets.init(top: 0, left: MARGIN_20, bottom: MARGIN_20, right: MARGIN_20), child: spec)
        return insetSpec
    }
    
}
