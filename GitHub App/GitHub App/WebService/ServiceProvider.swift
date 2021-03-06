//
//  ServiceProvider.swift
//  GitHub App
//
//  Created by Sureshkumar Linganathan on 24/11/21.
//

protocol RepoListServiceProviderProtocol {
    
    func fetchRepo(successCallback:@escaping successCallback,failureCallback:@escaping failureCallback)
}

protocol RepoDetailServiceProviderProtocol{
    
    func fetchContributorList(path:String,successCallback:@escaping successCallback,failureCallback:@escaping failureCallback)
    func fetcIssueList(path:String,successCallback:@escaping successCallback,failureCallback:@escaping failureCallback)
    func fetchCommentList(path:String,successCallback:@escaping successCallback,failureCallback:@escaping failureCallback)
    
}

class  ServiceProvider:RepoListServiceProviderProtocol,RepoDetailServiceProviderProtocol{
    
    
    func fetchRepo(successCallback:@escaping successCallback,failureCallback:@escaping failureCallback){
        
        ApiManager.fetchRepo{ (success,response) in
            successCallback(success,response)
        } failureCallback: { (msg) in
            failureCallback(msg)
        }
        
    }
    
    
    func fetchContributorList(path:String,successCallback:@escaping successCallback,failureCallback:@escaping failureCallback){
        
        ApiManager.fetchContributorList(path:path) { (success,response) in
            successCallback(success,response)
        } failureCallback: { (msg) in
            failureCallback(msg)
        }
        
    }
    
    func fetcIssueList(path:String,successCallback:@escaping successCallback,failureCallback:@escaping failureCallback){
        
        ApiManager.fetcIssueList(path: path) { (success,response) in
            successCallback(success,response)
        } failureCallback: { (msg) in
            failureCallback(msg
            )
        }
        
    }
    
    func fetchCommentList(path:String,successCallback:@escaping successCallback,failureCallback:@escaping failureCallback){
        
        ApiManager.fetchCommentList(path:path) { (success,response) in
            successCallback(success,response)
        } failureCallback: { (msg) in
            failureCallback(msg)
        }
        
    }
}


