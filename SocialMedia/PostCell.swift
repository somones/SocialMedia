//
//  PostCell.swift
//  SocialMedia
//
//  Created by Samir Belkahla on 03/11/2017.
//  Copyright © 2017 Samir Belkahla. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var caption: UITextView!
    @IBOutlet weak var likeLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
