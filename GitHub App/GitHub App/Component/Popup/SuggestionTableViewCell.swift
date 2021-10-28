//
//  SuggesstionTableViewCell.swift
//  GitHub App
//
//  Created by Sureshkumar Linganathan on 27/10/21.
//  Copyright © 2020 SureshKumar. All rights reserved.
//

import UIKit

let SUGGESTION_CELL = "SuggestionTableViewCell"

class SuggestionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    func setupView(str:String){
        
        nameLabel.text = str
    }
    
}

