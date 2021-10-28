//
//  RepoDetailViewModel.swift
//  GitHub App
//
//  Created by Sureshkumar Linganathan on 28/10/21.
//

import Foundation

class RepoDetailViewModel{
    
    var contributorList : Box<[ContributorInfo]?> = Box(nil)
    var contributorServiveFailure:Box<String?> = Box(nil)
    var commentsList : Box<[CommentInfo]?> = Box(nil)
    var commentsServiveFailure:Box<String?> = Box(nil)
    var issueList: Box<[IssueInfo]?> = Box(nil)
    var issueServiveFailure:Box<String?> = Box(nil)
    var apiLoadingStatus:Box<Bool> = Box(false)
    var reloadStatus:Box<Bool> = Box(false)
    
    let group = DispatchGroup()
    
    let serviceProvider:RepoDetailServiceProviderProtocol
    
    init(serviceProvider:RepoDetailServiceProviderProtocol = ServiceProvider()) {
        self.serviceProvider = serviceProvider
    }
    
    func makeApiRequest(for path:String){
        
        self.apiLoadingStatus.value = false
        
        self.fetchContributorList(path:path)
        self.fetchIssueList(path:path)
        self.fetchCommentList(path:path)
        self.group.notify(queue: .main){
            
            self.apiLoadingStatus.value = true
            
            self.reloadStatus.value = true
            
        }
    }
    
    func fetchContributorList(path:String){
        
        group.enter()
        
        self.serviceProvider.fetchContributorList(path:path) { [weak self](success,response) in
            self?.group.leave()
            guard let contributorArr = response as? [ContributorInfo] else{
                
                self?.contributorList.value = []
                return
            }
            if contributorArr.count > 3{
                self?.contributorList.value = Array(contributorArr.prefix(3))
            }else{
                self?.contributorList.value = contributorArr
            }
            
            
            
        } failureCallback: { [weak self](msg) in
            self?.group.leave()
            self?.contributorServiveFailure.value = msg
        }
        
    }
    
    func fetchIssueList(path:String){
        group.enter()
        self.serviceProvider.fetcIssueList(path:path) { [weak self](success,response) in
            self?.group.leave()
            guard let issues = response as? [IssueInfo] else{
                self?.issueList.value = []
                return
            }
            if issues.count > 3{
                self?.issueList.value = Array(issues.prefix(3))
            }else{
                self?.issueList.value = issues
            }
            
        } failureCallback: {[weak self] (msg) in
            self?.group.leave()
            self?.issueServiveFailure.value = msg
        }
        
        
    }
    func fetchCommentList(path:String){
        group.enter()
        self.serviceProvider.fetchCommentList(path:path) {[weak self] (success,response) in
            self?.group.leave()
            guard let comments = response as? [CommentInfo] else{
                self?.commentsList.value = []
                return
            }
            if comments.count > 3{
                self?.commentsList.value = Array(comments.prefix(3))
            }else{
                self?.commentsList.value = comments
            }
            
        } failureCallback: {[weak self] (msg) in
            self?.group.leave()
            self?.commentsServiveFailure.value = msg
        }
        
        
    }
}
