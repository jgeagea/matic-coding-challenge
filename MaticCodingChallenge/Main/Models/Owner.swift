//
//  Owner.swift
//  MaticCodingChallenge
//
//  Created by John on 4/17/19.
//  Copyright © 2019 John Geagea. All rights reserved.
//

import UIKit
import SwiftyJSON

class Owner: NSObject {
    
    var repoOwnerName : String!;
    
    var repoOwnerAvatarImageURL : String!;
    
    
    static func arrayFromJSONArray(json:JSON) -> Array<Owner> {
        
        var temp = [Owner]()
        
        for owner in json.array!{
            
            temp.append(Owner.initWithJsonObject(json: owner["owner"]))
            
        }
        
        return temp;
    }
    
    public static func initWithJsonObject(json:JSON) -> Owner {
        
        
        let owner : Owner! = Owner.init();
        owner.repoOwnerName = json["login"].string
        owner.repoOwnerAvatarImageURL = json["avatar_url"].string
        
        return owner;
        
    }

}
