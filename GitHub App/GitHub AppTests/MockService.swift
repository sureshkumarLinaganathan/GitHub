//
//  MockService.swift
//  GitHub AppTests
//
//  Created by Sureshkumar Linganathan on 29/10/21.
//

import Foundation
@testable import GitHub_App

class MockServices: RepoListServiceProviderProtocol {
    
    var responseType:MockApiResponseType = .success
    
    func fetchRepo(dict: [String : String], successCallback: @escaping successCallback, failureCallback: @escaping failureCallback) {
        
        switch responseType {
        case .success:
            
            let repo = RepoInfo(name:"awesome-ios", repoDescription:"A curated list of awesome iOS ecosystem, including Objective-C and Swift Projects ", owner:Owner(avatar_url:"https://avatars.githubusercontent.com/u/484656?v=4"), path:"vsouza/awesome-ios")
            successCallback(true,[repo] as AnyObject)
            
        case .failure:
            
            failureCallback("Something went wrong!")
            
        case .successWithEmptyData:
            
            successCallback(true,[] as AnyObject)
            
        case .failureWithOutMsg:
            failureCallback("")
        case .loadingIndicatorStatus:
            successCallback(true,[] as AnyObject)
        default:
            failureCallback("Request Time out")
        }
    }
}

extension MockServices: RepoDetailServiceProviderProtocol {
    
    func fetchContributorList(path: String, successCallback: @escaping successCallback, failureCallback: @escaping failureCallback) {
        
        switch responseType {
        case .success:
            
            let contributor = ContributorInfo(name:"lfarah", avatar_url:"https://avatars.githubusercontent.com/u/6511079?v=4")
            successCallback(true,[contributor] as AnyObject)
            
        case .failure:
            
            failureCallback("Something went wrong!")
            
        case .successWithEmptyData:
            
            successCallback(true,[] as AnyObject)
            
        case .failureWithOutMsg:
            failureCallback("")
        case .loadingIndicatorStatus:
            successCallback(true,[] as AnyObject)
        case .reloadStatus:
            successCallback(true,[] as AnyObject)
        default:
            failureCallback("Request Time out")
        }
        
    }
    
    func fetcIssueList(path: String, successCallback: @escaping successCallback, failureCallback: @escaping failureCallback) {
        
        switch responseType {
        case .success:
            
            let issue = IssueInfo(title:"Add 🏈 `Rugby` to `Tools` category", owner:Owner(avatar_url:"https://avatars.githubusercontent.com/u/64660122?v=4"))
            successCallback(true,[issue] as AnyObject)
            
        case .failure:
            
            failureCallback("Something went wrong!")
            
        case .successWithEmptyData:
            
            successCallback(true,[] as AnyObject)
            
        case .failureWithOutMsg:
            failureCallback("")
        case .loadingIndicatorStatus:
            successCallback(true,[] as AnyObject)
        default:
            failureCallback("Request Time out")
        }
        
    }
    
    func fetchCommentList(path: String, successCallback: @escaping successCallback, failureCallback: @escaping failureCallback) {
        
        
        switch responseType {
        case .success:
            
            let issue = CommentInfo(body:"thx\n", owner:Owner(avatar_url:"https://avatars.githubusercontent.com/u/4723115?v=4"))
            successCallback(true,[issue] as AnyObject)
            
        case .failure:
            
            failureCallback("Something went wrong!")
            
        case .successWithEmptyData:
            
            successCallback(true,[] as AnyObject)
            
        case .failureWithOutMsg:
            failureCallback("")
        case .loadingIndicatorStatus:
            successCallback(true,[] as AnyObject)
        default:
            failureCallback("Request Time out")
        }
    }
    
    
    
}


enum MockApiResponseType {
    
    case success
    case failure
    case successWithEmptyData
    case failureWithOutMsg
    case loadingIndicatorStatus
    case reloadStatus
    case timeOut
}


