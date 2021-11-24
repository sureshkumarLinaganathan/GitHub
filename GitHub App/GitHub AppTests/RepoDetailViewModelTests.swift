//
//  RepoDetailViewModelTests.swift
//  GitHub AppTests
//
//  Created by Sureshkumar Linganathan on 24/11/21.
//

import XCTest
@testable import GitHub_App

class RepoDetailViewModelTests: XCTestCase {
    
    var viewModel:RepoDetailViewModel?
    var mockAPIService: MockServices!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        mockAPIService = MockServices()
        viewModel = RepoDetailViewModel(serviceProvider: mockAPIService)
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        mockAPIService = nil
        viewModel = nil
    }
    
}


extension RepoDetailViewModelTests{
    
    func test_fetch_contributor_list() {
        
        mockAPIService.responseType = .success
        viewModel?.fetchContributorList(path:"vsouza/awesome-ios")
        XCTAssertEqual(viewModel?.contributorList.value?.count,1)
    }
    
    func  test_fetch_contributor_failure(){
        
        mockAPIService.responseType = .failure
        viewModel?.fetchContributorList(path:"vsouza/awesome-ios")
        XCTAssertEqual(viewModel?.contributorServiveFailure.value, "Something went wrong!")
    }
    
    func  test_fetch_contributor_list_empty(){
        
        mockAPIService.responseType = .successWithEmptyData
        viewModel?.fetchContributorList(path:"vsouza/awesome-ios")
        XCTAssertEqual(viewModel?.contributorList.value?.count,0)
        
    }
    
    func  test_fetch_contributor_list_failure_with_empty_msg(){
        
        mockAPIService.responseType = .failureWithOutMsg
        viewModel?.fetchContributorList(path:"vsouza/awesome-ios")
        XCTAssertEqual(viewModel?.contributorServiveFailure.value,"")
    }
    
    func  test_fetch_contributor_list_timeout(){
        
        mockAPIService.responseType = .timeOut
        viewModel?.fetchContributorList(path:"vsouza/awesome-ios")
        XCTAssertEqual(viewModel?.contributorServiveFailure.value,"Request Time out")
    }
    
    func test_check_loading_status(){
        
        mockAPIService.responseType = .loadingIndicatorStatus
        viewModel?.fetchContributorList(path:"vsouza/awesome-ios")
        XCTAssertEqual(viewModel?.apiLoadingStatus.value,false)
    }
    
    func test_reload_status(){
        
        mockAPIService.responseType = .reloadStatus
        viewModel?.fetchContributorList(path:"vsouza/awesome-ios")
        XCTAssertEqual(viewModel?.apiLoadingStatus.value,false)
    }
    
    
}

extension RepoDetailViewModelTests{
    
    func test_fetch_issue_list() {
        
        mockAPIService.responseType = .success
        viewModel?.fetchCommentList(path:"vsouza/awesome-ios")
        XCTAssertEqual(viewModel?.commentsList.value?.count,1)
    }
    
    func  test_fetch_issue_failure(){
        
        mockAPIService.responseType = .failure
        viewModel?.fetchCommentList(path:"vsouza/awesome-ios")
        XCTAssertEqual(viewModel?.commentsServiveFailure.value, "Something went wrong!")
    }
    
    func  test_fetch_issue_list_empty(){
        
        mockAPIService.responseType = .successWithEmptyData
        viewModel?.fetchCommentList(path:"vsouza/awesome-ios")
        XCTAssertEqual(viewModel?.commentsList.value?.count,0)
        
    }
    
    func  test_fetch_issue_list_failure_with_empty_msg(){
        
        mockAPIService.responseType = .failureWithOutMsg
        viewModel?.fetchCommentList(path:"vsouza/awesome-ios")
        XCTAssertEqual(viewModel?.commentsServiveFailure.value,"")
    }
    
    func  test_fetch_issue_list_timeout(){
        
        mockAPIService.responseType = .timeOut
        viewModel?.fetchCommentList(path:"vsouza/awesome-ios")
        XCTAssertEqual(viewModel?.commentsServiveFailure.value,"Request Time out")
    }
}

extension RepoDetailViewModelTests{
    
    func test_fetch_comment_list() {
        
        mockAPIService.responseType = .success
        viewModel?.fetchIssueList(path:"vsouza/awesome-ios")
        XCTAssertEqual(viewModel?.issueList.value?.count,1)
    }
    
    func  test_fetch_comment_failure(){
        
        mockAPIService.responseType = .failure
        viewModel?.fetchIssueList(path:"vsouza/awesome-ios")
        XCTAssertEqual(viewModel?.issueServiveFailure.value, "Something went wrong!")
    }
    
    func  test_fetch_comment_list_empty(){
        
        mockAPIService.responseType = .successWithEmptyData
        viewModel?.fetchIssueList(path:"vsouza/awesome-ios")
        XCTAssertEqual(viewModel?.issueList.value?.count,0)
        
    }
    
    func  test_fetch_comment_list_failure_with_empty_msg(){
        
        mockAPIService.responseType = .failureWithOutMsg
        viewModel?.fetchIssueList(path:"vsouza/awesome-ios")
        XCTAssertEqual(viewModel?.issueServiveFailure.value,"")
    }
    
    func  test_fetch_comment_list_timeout(){
        
        mockAPIService.responseType = .timeOut
        viewModel?.fetchIssueList(path:"vsouza/awesome-ios")
        XCTAssertEqual(viewModel?.issueServiveFailure.value,"Request Time out")
    }
}
