//
//  MockHomeViewController.swift
//  RobustaTaskTests
//
//  Created by Zyad Galal on 30/11/2020.
//

import UIKit
import XCTest

class MockHomeViewController: UIViewController {
    @objc var presenter: HomePresenterImpl?
    @objc var expectation: XCTestExpectation?

    override func viewDidLoad() {
        presenter?.viewDidLoad()
    }
}
extension MockHomeViewController: HomeView{
    
    func didFetchDataSuccessfully() {
        expectation?.fulfill()
    }
    
    func didFailFetchingDataWithError(_ error: String!) {
        
    }
    
    func showIndicator() {
        
    }
    
    func hideIndicator() {
        
    }
    
    
    
}
