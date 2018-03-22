//
//  circleView.swift
//  socialGram
//
//  Created by Sushruth on 3/20/18.
//  Copyright © 2018 iosDev. All rights reserved.
//

import UIKit

class circleView: UIImageView {

  
    override func layoutSubviews() {
        layer.cornerRadius = self.frame.width/2
    }
    
        
    

}
