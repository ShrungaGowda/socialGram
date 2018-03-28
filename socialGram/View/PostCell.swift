//
//  PostCellView.swift
//  socialGram
//
//  Created by Sushruth on 3/21/18.
//  Copyright © 2018 iosDev. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var userName : UILabel!
    @IBOutlet weak var postImg:UIImageView!
    @IBOutlet weak var caption: UITextView!
    @IBOutlet weak var likesBtn : UILabel!
    
    var post: Post!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(post : Post){
        self.post = post
        self.caption.text = post.caption
        self.likesBtn.text = "\(post.likes)"
    }

}
