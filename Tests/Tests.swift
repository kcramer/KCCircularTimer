//
//  Tests.swift
//  Tests
//
//  Created by Kevin on 5/24/18.
//  Copyright © 2018 Kevin. All rights reserved.
//

import XCTest
import FBSnapshotTestCase
import KCCircularTimer

class Tests: FBSnapshotTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Continue even if a failure occurs.
        continueAfterFailure = true
        // UI tests must launch the application that they test.
        XCUIApplication().launch()
        // Set to true to update the reference images.
        recordMode = false
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testBasicRendering() {
        let frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        let view = KCCircularTimer(frame: frame)
        view.maximumValue = 60
        view.currentValue = 45
        view.tintColor = .blue
        FBSnapshotVerifyView(view)
    }
}
