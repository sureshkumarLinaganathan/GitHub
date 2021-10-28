//
//  SuggesstionTableViewCell.swift
//  St Jude Kiosk App
//
//  Created by suresh on 20/05/20.
//  Copyright © 2020 QCompile. All rights reserved.
//

import UIKit

let SUGGESTION_CELL = "SuggestionTableViewCell"

class SuggestionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    func setupView(str:String){
        
        nameLabel.text = str
    }
    
}

