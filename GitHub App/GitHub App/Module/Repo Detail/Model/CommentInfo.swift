//
//  CommentInfo.swift
//  GitHub App
//
//  Created by Sureshkumar Linganathan on 28/10/21.
//

import Foundation

struct CommentInfo:Codable{
    
    var body:String?
    var owner:Owner?
    
    private enum CodingKeys:String,CodingKey{
        
        case body
        case owner = "user"
    }
    
}
