//
//  PostCellTableViewCell.swift
//  ios101-project5-tumblr
///Users/mikegomez82/Desktop/ios101-project5-tumblr-starter/ios101-project5-tumblr/ViewController.swift
//  Created by Mike Gomez on 3/20/24.
//

import UIKit
import Nuke
class PostCellTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var blogText: UITextView!
    
    @IBOutlet weak var blogImage: UIImageView!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configure(text:String,bImage:URL?) {
        blogText.text = text
        if let url = bImage{
            Nuke.loadImage(with: url, into: blogImage)
        }
    }
}
