//
//  HomeViewModel.swift
//  GitHub App
//
//  Created by Sureshkumar Linganathan on 24/11/21.
//

import Foundation

class RepoListViewModel{
    
    var repoList : Box<[RepoInfo]> = Box([])
    var failure:Box<String?> = Box(nil)
    var apiLoadingStatus:Box<Bool> = Box(false)
    
    let serviceProvider:RepoListServiceProviderProtocol
    
    init(serviceProvider:RepoListServiceProviderProtocol = ServiceProvider()) {
        self.serviceProvider = serviceProvider
    }
    
    func fetchRepoList(){
        
        
        self.apiLoadingStatus.value = true

        self.serviceProvider.fetchRepo{[weak self] (success,response) in
            self?.apiLoadingStatus.value = false
            guard let repos = response as? [RepoInfo] else{
                self?.repoList.value = []
                return
            }
            
            self?.repoList.value = repos
        } failureCallback: {[weak self] (message) in
            self?.apiLoadingStatus.value = false
            self?.failure.value =  message
        }
        
    }
}
