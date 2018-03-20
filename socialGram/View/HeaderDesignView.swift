//
//  HeaderDesignView.swift
//  socialGram
//
//  Created by Sushruth on 3/19/18.
//  Copyright © 2018 iosDev. All rights reserved.
//

import UIKit

class HeaderDesignView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowColor = UIColor(red:SHADOW_GRAY,green:SHADOW_GRAY,blue:SHADOW_GRAY,alpha:0.6).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width:1.0,height:1.0)
        
        
        
    }

}
