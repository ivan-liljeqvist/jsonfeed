//
//  ViewController.swift
//  jsonfeed
//
//  Created by Ivan Liljeqvist on 2017-06-20.
//  Copyright © 2017 Ivan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        NetworkHelper.fetchArticleJSON(completion: { (response) in
            
            switch(response){
                
            case ResponseType.articleRequestSucceeded(let articlesJson):
                
                print(articlesJson)
                
                break
                
            default:
                print("couldn't fetch articles!")
                break
                
            }

        
        })
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

