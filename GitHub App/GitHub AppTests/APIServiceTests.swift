//
//  APIServiceTests.swift
//  GitHub AppTests
//
//  Created by Sureshkumar Linganathan on 24/11/21.
//

import XCTest
@testable import GitHub_App

class APIServiceTests: XCTestCase {
    
    var serviceProvider:ServiceProvider?
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        serviceProvider = ServiceProvider()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        serviceProvider = nil
    }
    func test_fetch_repo_list(){
        
        let serviceProvider = self.serviceProvider
        let expect = XCTestExpectation(description: "callback")
        serviceProvider?.fetchRepo(successCallback: { (success,response) in
            
            expect.fulfill()
            XCTAssertNotNil(response)
            
        }, failureCallback: { (msg) in
            XCTAssertNotNil(msg)
            expect.fulfill()
        })
        
        wait(for: [expect], timeout:30.0)
    }
    
    func test_fetch_contributor_list(){
        
        let serviceProvider = self.serviceProvider
        let expect = XCTestExpectation(description: "callback")
        serviceProvider?.fetchContributorList(path:"vsouza/awesome-ios", successCallback: { (success,response) in
            
            expect.fulfill()
            XCTAssertNotNil(response)
            
        }, failureCallback: { (msg) in
            XCTAssertNotNil(msg)
            expect.fulfill()
        })
        
        wait(for: [expect], timeout:20.0)
    }
    
    func test_fetch_issue_list(){
        
        let serviceProvider = self.serviceProvider
        let expect = XCTestExpectation(description: "callback")
        serviceProvider?.fetcIssueList(path:"vsouza/awesome-ios", successCallback: { (success,response) in
            
            expect.fulfill()
            XCTAssertNotNil(response)
            
        }, failureCallback: { (msg) in
            XCTAssertNotNil(msg)
            expect.fulfill()
        })
        
        wait(for: [expect], timeout:20.0)
    }
    
    
    func test_fetch_comment_list(){
        
        let serviceProvider = self.serviceProvider
        let expect = XCTestExpectation(description: "callback")
        serviceProvider?.fetcIssueList(path:"vsouza/awesome-ios", successCallback: { (success,response) in
            
            expect.fulfill()
            XCTAssertNotNil(response)
            
        }, failureCallback: { (msg) in
            XCTAssertNotNil(msg)
            expect.fulfill()
        })
        
        wait(for: [expect], timeout:20.0)
    }
}
