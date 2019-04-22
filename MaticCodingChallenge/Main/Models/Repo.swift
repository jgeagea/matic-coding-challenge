//
//  Repo.swift
//  MaticCodingChallenge
//
//  Created by John on 4/17/19.
//  Copyright © 2019 John Geagea. All rights reserved.
//

import UIKit
import SwiftyJSON

class Repo: NSObject {
    
    var repoName : String!;
    
    var repoDescription : String!;
    
    var repoNumberOfStars : Int!;
    
    var owner : Owner!;
    
    static func arrayFromJSONArray(json:JSON) -> Array<Repo> {
        
        var temp = [Repo]()
        
        if(json.array == nil) {
            return temp;
        }
        
        for repo in json.array! {
            
            let myRepo:Repo = Repo.init();
            temp.append(myRepo.initWithJsonObject(json: repo))
            
        }
        
        return temp;
    }
    
    public func initWithJsonObject(json:JSON) -> Repo {
        
        
        let repo : Repo! = Repo.init();
        repo.repoName = json["name"].string;
        repo.repoDescription = json["description"].string;
        repo.repoNumberOfStars = json["stargazers_count"].int;
        
        repo.owner = Owner.initWithJsonObject(json: json["owner"]);
        
        return repo;
        
    }

}
