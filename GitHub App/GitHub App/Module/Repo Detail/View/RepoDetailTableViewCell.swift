//
//  RepoDetailTableViewCell.swift
//  GitHub App
//
//  Created by Sureshkumar Linganathan on 28/10/21.
//

import UIKit

class RepoDetailTableViewCell: UITableViewCell {
    
    static let identifier = "RepoDetailTableViewCellIdentifier"
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var parentView: UIView!
    
    func setupContributorView(contributor:ContributorInfo){
        if let name = contributor.name {
            
            infoLabel.text = name
        }
    }
    
    func setupIssueView(issue:IssueInfo){
        if let title = issue.title {
            
            infoLabel.text = title
        }
    }
    
    func setupCommentView(comment:CommentInfo){
        
        if let body = comment.body {
            
            infoLabel.text = body
        }
    }
    
    
}
