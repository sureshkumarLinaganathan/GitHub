//
//  RepoListViewModelTests.swift
//  GitHub AppTests
//
//  Created by Sureshkumar Linganathan on 24/11/21.
//

import XCTest
@testable import GitHub_App

class RepoListViewModelTests: XCTestCase {
    
    var viewModel:RepoListViewModel?
    var mockAPIService: MockServices!
    
    override func setUpWithError() throws {
        
        mockAPIService = MockServices()
        viewModel = RepoListViewModel(serviceProvider: mockAPIService)
        
    }
    
    override func tearDownWithError() throws {
        
        viewModel = nil
        mockAPIService = nil
    }
    
    func test_fetch_repo_list() {
        
        mockAPIService.responseType = .success
        viewModel?.query(for:"swift", sortType:"stars")
        XCTAssertEqual(viewModel?.repoList.value.count,1)
    }
    
    func test_fetch_repo_list_failure(){
        
        mockAPIService.responseType = .failure
        viewModel?.query(for:"swift", sortType:"stars")
        XCTAssertEqual(viewModel?.failure.value, "Something went wrong!")
    }
    
    func test_fetch_repo_list_empty(){
        
        mockAPIService.responseType = .successWithEmptyData
        viewModel?.query(for:"swift", sortType:"stars")
        XCTAssertEqual(viewModel?.repoList.value.count,0)
        
    }
    
    func test_fetch_repo_list_failure_with_empty_msg(){
        
        mockAPIService.responseType = .failureWithOutMsg
        viewModel?.query(for:"swift", sortType:"stars")
        XCTAssertEqual(viewModel?.failure.value,"")
    }
    
    func test_fetch_repo_list_timeout(){
        
        mockAPIService.responseType = .timeOut
        viewModel?.query(for:"swift", sortType:"stars")
        XCTAssertEqual(viewModel?.failure.value,"Request Time out")
    }
    
    func test_check_loading_status(){
        
        mockAPIService.responseType = .loadingIndicatorStatus
        viewModel?.query(for:"swift", sortType:"stars")
        XCTAssertEqual(viewModel?.apiLoadingStatus.value,false)
    }
    
    
    
}

