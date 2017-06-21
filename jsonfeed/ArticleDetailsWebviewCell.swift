//
//  ArticleDetailsWebviewCell.swift
//  jsonfeed
//
//  Created by Ivan Liljeqvist on 2017-06-21.
//  Copyright © 2017 Ivan. All rights reserved.
//

import UIKit

class ArticleDetailsWebviewCell: UITableViewCell {
    
    @IBOutlet weak var webview: UIWebView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
