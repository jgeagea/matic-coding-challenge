//
//  ViewController.swift
//  MaticCodingChallenge
//
//  Created by John on 4/16/19.
//  Copyright © 2019 John Geagea. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    
    @IBOutlet weak var tableview: UITableView!
    
    var reposArray : Array<Repo> = []
    
    var currentPage:Int! = 1;
    
    //1000 results are returned according to api and each page returns 30 repos so max page is 34
    var maxPage:Int = 34;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.initData();
        
    }
    
    public func getAPIRequest() {
        
        //Get yesterday's date because the result of today from the api is 0.
        let yesterdayDate = Calendar.current.date(byAdding: .day, value: -1, to: Date());
        
        let date = self.convertDateFormater(yesterdayDate!);

        let parameters: Parameters = [
            "q": "created:>" + date,
            "sort": "stars",
            "order": "desc",
            "page": String(self.currentPage)
        ]
        
        Alamofire.request("https://api.github.com/search/repositories", parameters: parameters).responseJSON(completionHandler: { (response) in
            
            switch response.result {
                
            case .success(let value):
                let json = JSON(value);
                
                let repos = Repo.arrayFromJSONArray(json: json["items"])
                for repo:Repo in repos {
                    
                    self.reposArray.append(repo)
                    
                }
                
                self.tableview.reloadData();
                
                
                
            case .failure(let error):
                print(error.localizedDescription);
                
            }
            
        })
    }
    
    private func convertDateFormater(_ date: Date) -> String {
        
        let dateFormatter = DateFormatter();
        dateFormatter.dateFormat = "yyyy-MM-dd";
        return  dateFormatter.string(from: date);
        
    }
    
    public func initData() {
        
        self.getAPIRequest();
        
        self.tableview.delegate = self;
        self.tableview.dataSource = self;
        self.tableview.register(UINib(nibName: "RepoTableViewCell", bundle: nil), forCellReuseIdentifier: "RepoTableViewCell")
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension;
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.reposArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let repo:Repo = self.reposArray[indexPath.row];
        
        let cell = tableview.dequeueReusableCell(withIdentifier: "RepoTableViewCell", for: indexPath) as! RepoTableViewCell;
        
        cell.initWithRepo(repo: repo)
        return cell;
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if(indexPath.row == self.reposArray.count - 1) {
            
            if(self.currentPage == self.maxPage) {
                return;
            }
            
            self.currentPage = self.currentPage + 1;
            self.getAPIRequest();
        }
    }

}

