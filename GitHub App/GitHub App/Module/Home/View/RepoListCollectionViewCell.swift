//
//  RepoListCollectionViewCell.swift
//  GitHub App
//
//  Created by Sureshkumar Linganathan on 27/10/21.
//

import UIKit
import SDWebImage


class RepoListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var describtionLabel: UILabel!
    @IBOutlet weak var parentView: UIView!
    
    static let identifier = "RepoListCellIdentifier"
    
    
    func setupView(repo:RepoInfo){
        
        setupUI()
        
        if let name = repo.name{
            nameLabel.text = name
        }
        if let des = repo.repoDescription{
            describtionLabel.text = des
        }
        
        if let owner = repo.owner,let url = owner.avatar_url{
            
            profileImageView.sd_setImage(with:URL(string: url)) { [weak self](image,error,type,url) in
                
                guard let img = image else{
                    
                    return
                }
                
                self?.profileImageView.image = img
            }
        }
        
        
        
    }
}

extension RepoListCollectionViewCell{
    
    private func setupUI(){
        
        self.layoutIfNeeded()
        parentView.makeRoundCorner(radius:10.0)
        parentView.dropShadow(color: .lightGray, radius:3.0, offset:.zero)
        
        profileImageView.makeRoundCorner(radius:profileImageView.bounds.height/2)
    }
}
