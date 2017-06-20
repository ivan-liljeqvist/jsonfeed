//
//  ArticleTableCell.swift
//  jsonfeed
//
//  Created by Ivan Liljeqvist on 2017-06-20.
//  Copyright © 2017 Ivan. All rights reserved.
//

import UIKit
import SDWebImage

class ArticleTableCell: UITableViewCell {
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    @IBOutlet weak var articleContents: UILabel!
    
    var article:Article?{
        didSet{
            
            // unwrap article and the url
            if let article = article{
                if let articleUrlString = article.bannerImageUrlString{
                    
                    if let articleUrl = URL(string: articleUrlString){
                        
                        backgroundImage.sd_setImage(with: articleUrl)
                        titleLabel.text = article.title
                        articleContents.text = article.contentText
                        
                    }
                    
                }
            }
            
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
