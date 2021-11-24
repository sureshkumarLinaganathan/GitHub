//
//  IssueInfo.swift
//  GitHub App
//
//  Created by Sureshkumar Linganathan on 24/11/21.
//

import Foundation

struct IssueInfo:Codable{
    
    var title:String?
    var owner:Owner
    
    private enum CodingKeys:String,CodingKey{
        
        case title
        case owner = "user"
    }
}
