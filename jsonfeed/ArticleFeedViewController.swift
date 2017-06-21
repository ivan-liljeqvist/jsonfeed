//
//  ViewController.swift
//  jsonfeed
//
//  Created by Ivan Liljeqvist on 2017-06-20.
//  Copyright © 2017 Ivan. All rights reserved.
//

import UIKit

class ArticleFeedViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var articles:[Article] = []

    @IBOutlet weak var articleTableView: UITableView!
    
    var lastClickedArticle:Article?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        fetchArticles()
        
        
        articleTableView.delegate = self
        articleTableView.dataSource = self
        articleTableView.rowHeight = UITableViewAutomaticDimension
        articleTableView.estimatedRowHeight = 150
    }
    
    func fetchArticles(){
        
        let fetchCompletion = { (articles:[Article]) in
            
            if articles.count > 0{
                self.articles = articles
                self.articleTableView.reloadData()
            }
            
        }
        
        // fetch from disk
        Article.fetchOffline { (articles:[Article]) in
            fetchCompletion(articles)
            
            // fetch from the net
            Article.fetchOnline(completion: fetchCompletion)
            
        }
        
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
        cell.separatorInset = .zero
        
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        lastClickedArticle = self.articles[indexPath.row]
        self.performSegue(withIdentifier: "toArticleDetails", sender: self)
        
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // set the article in ArticleDetailsController
        if segue.identifier == "toArticleDetails"{
        
            if let destVC = segue.destination as? ArticleDetailsViewController{
                destVC.article = lastClickedArticle
            }
        
        }
        
    }
    

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


