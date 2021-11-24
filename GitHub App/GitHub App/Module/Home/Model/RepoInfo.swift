//
//  RepoInfo.swift
//  GitHub App
//
//  Created by Sureshkumar Linganathan on 24/11/21.
//

import Foundation

struct RepoInfo:Codable {
    
    var name:String?
    var repoDescription:String?
    var owner:Owner?
    var path:String?
    
    
    private enum CodingKeys:String,CodingKey{
        case name
        case repoDescription = "description"
        case owner
        case path = "full_name"
    }
}

struct Owner:Codable {
    
    var avatar_url:String?
}
