//
//  HomeViewModel.swift
//  GitHub App
//
//  Created by Sureshkumar Linganathan on 27/10/21.
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
    
    func query(for language:String,sortType:String ){
        
        
        self.apiLoadingStatus.value = true
        
        var dict = ["q":"language:"+language,"order":"desc"]
        dict.updateValue(sortType, forKey:"sort")
        self.repoList.value = []
        self.serviceProvider.fetchRepo(dict:dict) {[weak self] (success,response) in
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
