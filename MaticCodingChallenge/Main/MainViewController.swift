//
//  ViewController.swift
//  MaticCodingChallenge
//
//  Created by John on 4/16/19.
//  Copyright © 2019 John Geagea. All rights reserved.
//

import UIKit
import Alamofire

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initData();
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

