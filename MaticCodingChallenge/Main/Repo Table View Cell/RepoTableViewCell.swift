//
//  RepoTableViewCell.swift
//  MaticCodingChallenge
//
//  Created by John on 4/17/19.
//  Copyright © 2019 John Geagea. All rights reserved.
//

import UIKit

class RepoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var repoNameLabel: UILabel!
    
    @IBOutlet weak var repoDescriptionLabel: UILabel!
    
    
    @IBOutlet weak var userAvatarImageView: UIImageView!
    
    @IBOutlet weak var repoOwnerNameLabel: UILabel!
    
    @IBOutlet weak var repoNumberOfStarsLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    

    public func initWithRepo(repo : Repo) {
        
        self.repoNameLabel.text = repo.repoName;
        self.repoDescriptionLabel.text = repo.repoDescription;
        self.repoNumberOfStarsLabel.text = String(repo.repoNumberOfStars);
        
        self.repoOwnerNameLabel.text = repo.owner.repoOwnerName;
        
    }
    
}
