//
//  ApiManager.swift
//  TrueWeight Task
//
//  Created by Suresh Kumar Linganathan on 30/12/20.
//  Copyright © 2020 SureshKumar. All rights reserved.
//

import Foundation


class ApiManager {
    
    
    class func fetchRepo(dict:[String:String],successCallback:@escaping successCallback,failureCallback:@escaping failureCallback){
        
        let (url,headers) = WebServiceConfig.getUrlWithHeaders(forActionType:.fetchRepo, forHeaderType:.basic, queryString: dict, apiType:.firstVersion,paths:nil)
        
        _ = WebService.initiateServiceCall(headers:headers, withMethod:.get, urlStr:url, requestObj:nil, successCallBack: { (success,response) in
            
            guard let data = response as? Data else{
                DispatchQueue.main.async {
                    failureCallback("Incorrect data format.")
                }
                return
            }
            
            do{
                
                let json = try JSONSerialization.jsonObject(with:data, options:[])
                
                guard let dict = json as? [String:Any],let arr = dict["items"] as? [[String:Any]] else{
                    DispatchQueue.main.async {
                        failureCallback("Incorrect data format.")
                    }
                    return
                }
                
                let objs = Parser.decode(data:arr, type:[RepoInfo].self)
                // print(objs)
                DispatchQueue.main.async {
                    successCallback(success,objs)
                }
                
                
            }catch{
                DispatchQueue.main.async {
                    failureCallback("Incorrect data format.")
                }
            }
            
        }, failureCallback: { (msg) in
            DispatchQueue.main.async {
                failureCallback(msg)
            }
        })
    }
    
}

extension ApiManager{
    
    class func downlaodImage(url:String,successCallback:@escaping successCallback,failureCallback:@escaping failureCallback){
        
        
        _ = WebService.initiateServiceCall(headers:[:], withMethod:.get, urlStr:url, requestObj:nil, successCallBack: { (success,response) in
            
            successCallback(success,response)
            
        }, failureCallback: { (msg) in
            failureCallback(msg)
        })
        
        
    }
    
}

extension ApiManager{
    
    class func fetchContributorList(path:String,successCallback:@escaping successCallback,failureCallback:@escaping failureCallback){
        
        let (url,headers) = WebServiceConfig.getUrlWithHeaders(forActionType:.fetchContributor, forHeaderType:.basic, queryString:[:], apiType:.secondVersion, paths:[path])
        
        _ = WebService.initiateServiceCall(headers:headers, withMethod:.get, urlStr:url, requestObj:nil, successCallBack: { (success,response) in
            
            guard let data = response as? Data else{
                failureCallback("Incorrect data format.")
                return
            }
            
            do{
                
                let json = try JSONSerialization.jsonObject(with:data, options:[])
                let objs = Parser.decode(data:json, type:[ContributorInfo].self)
                successCallback(success,objs)
            }catch{
                failureCallback("Incorrect data format.")
            }
            
            
        }, failureCallback: { (msg) in
            failureCallback(msg)
        })
    }
    
    class func fetcIssueList(path:String,successCallback:@escaping successCallback,failureCallback:@escaping failureCallback){
        
        let (url,headers) = WebServiceConfig.getUrlWithHeaders(forActionType:.fetchIssues, forHeaderType:.basic, queryString:[:], apiType:.secondVersion, paths:[path])
        
        _ = WebService.initiateServiceCall(headers:headers, withMethod:.get, urlStr:url, requestObj:nil, successCallBack: { (success,response) in
            
            guard let data = response as? Data else{
                failureCallback("Incorrect data format.")
                return
            }
            
            do{
                
                let json = try JSONSerialization.jsonObject(with:data, options:[])
                let objs = Parser.decode(data:json, type:[IssueInfo].self)
                successCallback(success,objs)
            }catch{
                failureCallback("Incorrect data format.")
            }
            
            
        }, failureCallback: { (msg) in
            failureCallback(msg)
        })
    }
    
    class func fetchCommentList(path:String,successCallback:@escaping successCallback,failureCallback:@escaping failureCallback){
        
        let (url,headers) = WebServiceConfig.getUrlWithHeaders(forActionType:.fetchComments, forHeaderType:.basic, queryString:[:], apiType:.secondVersion, paths:[path])
        
        _ = WebService.initiateServiceCall(headers:headers, withMethod:.get, urlStr:url, requestObj:nil, successCallBack: { (success,response) in
            
            guard let data = response as? Data else{
                failureCallback("Incorrect data format.")
                return
            }
            
            do{
                
                let json = try JSONSerialization.jsonObject(with:data, options:[])
                let objs = Parser.decode(data:json, type:[CommentInfo].self)
                successCallback(success,objs)
            }catch{
                failureCallback("Incorrect data format.")
            }
            
            
        }, failureCallback: { (msg) in
            failureCallback(msg)
        })
    }
}
