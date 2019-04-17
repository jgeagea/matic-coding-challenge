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
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.initData();
        
        self.getAPIRequest();
    }
    
    public func getAPIRequest() {
        
        //Get yesterday's date because the result of today from the api is 0.
        let yesterdayDate = Calendar.current.date(byAdding: .day, value: -1, to: Date());
        
        let date = self.convertDateFormater(yesterdayDate!);

        let parameters: Parameters = [
            "q": "created:>" + date,
            "sort": "stars",
            "order": "desc"
        ]
        
        Alamofire.request("https://api.github.com/search/repositories", parameters: parameters).responseJSON(completionHandler: { (response) in
            
            switch response.result {
                
            case .success(let value):
                let json = JSON(value);
                print(json);
                
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
        
        self.tableview.delegate = self;
        self.tableview.dataSource = self;
        self.tableview.register(UINib(nibName: "RepoTableViewCell", bundle: nil), forCellReuseIdentifier: "RepoTableViewCell")
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension;
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 4;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        
        let cell = tableview.dequeueReusableCell(withIdentifier: "RepoTableViewCell", for: indexPath) as! RepoTableViewCell;
        
        let myString = "Hello" + String(indexPath.row);
        cell.repoNumberOfStarsLabel.text = myString;
        
        return cell;
    }

}

