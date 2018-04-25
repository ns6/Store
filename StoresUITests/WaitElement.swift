//
//  WaitElement.swift
//  StoresUITests
//
//  Created by ssion on 12/7/17.
//  Copyright © 2017 Prokuda. All rights reserved.
//

import Foundation

import XCTest


class WaitElement: XCTestCase {
    func waitForElementToAppear(element: XCUIElement, whithTimeOut timeout: Double, file: String = #file, line: UInt = #line) {
        let existsPredicate = NSPredicate(format: "exists == true")
        
        expectation(for: existsPredicate, evaluatedWith: element, handler: nil)
        
        waitForExpectations(timeout: TimeInterval(timeout)) { (error) -> Void in
            if (error != nil) {
                let message = "Failed to find \(element) after 5 seconds."
                self.recordFailure(withDescription: message, inFile: file, atLine: Int(line), expected: true)
            }
        }
    }
}
