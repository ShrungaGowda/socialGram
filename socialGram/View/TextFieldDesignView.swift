//
//  TextFieldDesignView.swift
//  socialGram
//
//  Created by Sushruth on 3/19/18.
//  Copyright © 2018 iosDev. All rights reserved.
//

import UIKit

class TextFieldDesignView: UITextField {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.borderColor = UIColor(red:SHADOW_GRAY,green:SHADOW_GRAY,blue:SHADOW_GRAY,alpha:0.2).cgColor
        layer.borderWidth = 1.0
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 5)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 5)
    }

}



