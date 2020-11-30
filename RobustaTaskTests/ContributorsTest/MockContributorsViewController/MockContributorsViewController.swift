//
//  MockContributorsViewController.swift
//  RobustaTaskTests
//
//  Created by Zyad Galal on 30/11/2020.
//

import UIKit
import XCTest

class MockContributorsViewController: UIViewController {
    @objc var presenter: ContributorsPresenterImpl?
    @objc var expectation: XCTestExpectation?
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }


}
extension MockContributorsViewController: ContributorsView {
    func didFetchDataSuccessfully() {
        print("hla")
        expectation?.fulfill()
    }
    
    func didFailFetchingDataWithError(_ error: String!) {
        
    }
    
    func showIndicator() {
        
    }
    
    func hideIndicator() {
        
    }
    

}
