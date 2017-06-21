//
//  ArticleDetailsViewController.swift
//  jsonfeed
//
//  Created by Ivan Liljeqvist on 2017-06-20.
//  Copyright © 2017 Ivan. All rights reserved.
//

import UIKit

class ArticleDetailsViewController: UIViewController{
    
    @IBOutlet weak var webview: UIWebView!
    
    
    
    var article:Article?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //unwrap url
        if let article = article,
        let externalUrl = article.externalUrlString,
        let url = URL(string: externalUrl)
        {
            let request = URLRequest(url: url)
            webview.loadRequest(request)
            
            self.title = article.title
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func openInSafariClicked(_ sender: Any) {
        
        //unwrap url
        if let article = article,
            let externalUrl = article.externalUrlString,
            let url = URL(string: externalUrl)
        {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        
    }
    
    
    @IBAction func detailsClicked(_ sender: Any) {
        
        
        // show details about article
        if let article = article{
            
            var authorName:String = "unknown author"
            var dateString:String = "(no date provided)"
            
            // unwrap date
            if let date = article.datePublished{
                
                dateString = Utils.dateFormatter().string(from:date as Date)
                
            }
            
            // unwrap author name
            if let author = article.author,
                let name = author.name{
                
                authorName = name
            }
            
            // show alert with info
            let alertController = UIAlertController(title: nil, message: "Written by \(authorName) and published \(dateString)", preferredStyle: UIAlertControllerStyle.alert)
            
            
            let awesomeButton = UIAlertAction(title: "Sounds awesome", style: UIAlertActionStyle.default) {
                (result : UIAlertAction) -> Void in
                
            }
            
            alertController.addAction(awesomeButton)
            self.present(alertController, animated: true, completion: nil)
            
        }
    }



}
