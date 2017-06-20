//
//  ViewController.swift
//  jsonfeed
//
//  Created by Ivan Liljeqvist on 2017-06-20.
//  Copyright © 2017 Ivan. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var articles:[Article] = []

    @IBOutlet weak var articleTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        loadArticles()
        
        articleTableView.delegate = self
        articleTableView.dataSource = self
        articleTableView.rowHeight = UITableViewAutomaticDimension
        articleTableView.estimatedRowHeight = 150
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        
        if let font = UIFont(name: "Avenir Book", size: 20){
            
            self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white,
                                                                            NSFontAttributeName:font]
        }
        
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = articleTableView.dequeueReusableCell(withIdentifier: "articleCell") as! ArticleTableCell
        cell.article = self.articles[indexPath.row]
        return cell
        
        
    }
    
    func loadArticles(){
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate{
            
            let context = appDelegate.persistentContainer.viewContext
            
            // do network request
            NetworkHelper.fetchArticleJSON(completion: { (response) in
                
                switch(response){
                    
                case ResponseType.articleRequestSucceeded(let articlesDicts):
                    
                    // parse articles
                    for articleDict in articlesDicts{
                        self.articles.append(Article(withDictionary: articleDict, andContext: context))
                    }
                    
                    self.articleTableView.reloadData()
                    
                    
                    break
                
                // failed to fetch articles from the network
                default:
                    print("couldn't fetch articles!")
                    break
                    
                }
                
                
            })
            
            
        }
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

