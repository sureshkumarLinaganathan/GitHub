//
//  Contributor.swift
//  GitHub App
//
//  Created by Sureshkumar Linganathan on 24/11/21.
//

import Foundation

struct ContributorInfo:Codable {
    
    var name:String?
    var avatar_url:String?
    
    private enum CodingKeys:String,CodingKey{
        case name = "login"
        case avatar_url
    }
}
