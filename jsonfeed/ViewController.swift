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
    
    var lastClickedArticle:Article?
    
    
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
        cell.separatorInset = .zero
        
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        lastClickedArticle = self.articles[indexPath.row]
        self.performSegue(withIdentifier: "toArticleDetails", sender: self)
        
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
                    
                    self.sortArticles()
                    
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
    
    
    func sortArticles(){
        
        let calendar = Calendar.current
        
        self.articles.sort {
            
            // try to unwrap dates
            if let dateA = $0.datePublished as Date?,
                let dateB = $1.datePublished as
                    Date?{
                
                let elapsed0 = dateA.timeIntervalSince(calendar.startOfDay(for: dateA))
                let elapsed1 = dateB.timeIntervalSince(calendar.startOfDay(for: dateB))
                return elapsed0 < elapsed1
                
            }
            // if can't unrap date
            else{
                return true
            }
            
            
        }

        
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


