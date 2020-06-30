//
//  YCProfileCell.swift
//  qichehui
//
//  Created by SMART on 2019/12/5.
//  Copyright © 2019 SMART. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class YCProfileCell: ASCellNode {
    
    private lazy var titleTextNode:ASTextNode = {return ASTextNode()}()
    private lazy var imageNode:ASNetworkImageNode = {return ASNetworkImageNode()}()
    private lazy var tagNode:ASTextNode = {return ASTextNode()}()
    private let model:YCProfileCommonMaterialModel
    init(model:YCProfileCommonMaterialModel) {
        self.model = model
        super.init()
        setupUI()
    }
    
    func setupUI(){

        self.selectionStyle = .none
        
        backgroundColor = UIColor.white
        
        self.automaticallyManagesSubnodes = true
        
        if let text = model.title {
            titleTextNode.attributedText = NSAttributedString.init(string: text, attributes: [NSAttributedString.Key.foregroundColor:UIColor.darkGray,NSAttributedString.Key.font : FONT_SIZE_13])
        }
        
        if let url = model.image {
            imageNode.url = URL(string: url)
            imageNode.style.preferredSize = CGSize.init(width: 25*APP_SCALE, height: 25*APP_SCALE)
            imageNode.contentMode = .scaleAspectFill
        }
        
        tagNode.attributedText = NSAttributedString.init(string: "NEW", attributes: [NSAttributedString.Key.font : FONT_SIZE_6,NSAttributedString.Key.foregroundColor:UIColor.white])
        tagNode.backgroundColor = THEME_COLOR
        tagNode.textContainerInset = UIEdgeInsets.init(top: APP_SCALE, left: MARGIN_3, bottom: APP_SCALE, right: MARGIN_3)
        tagNode.cornerRadius = 3*APP_SCALE
        tagNode.clipsToBounds = true
        
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let spec = ASStackLayoutSpec.init(direction: ASStackLayoutDirection.horizontal, spacing: MARGIN_5, justifyContent: ASStackLayoutJustifyContent.start, alignItems: ASStackLayoutAlignItems.center, children: [
            self.imageNode,
            self.titleTextNode,
            self.tagNode
        ])
        
        let insetSpec = ASInsetLayoutSpec.init(insets: UIEdgeInsets.init(top: MARGIN_10, left: MARGIN_20, bottom: MARGIN_10, right: MARGIN_20), child: spec)
        
        return insetSpec
    }
    
}
