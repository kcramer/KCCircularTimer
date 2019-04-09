//
//  Tests.swift
//  Tests
//
//  Created by Kevin on 5/24/18.
//  Copyright © 2018 Kevin. All rights reserved.
//

import XCTest
import SnapshotTesting
import KCCircularTimer

class Tests: XCTestCase {
        
    override func setUp() {
        super.setUp()
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
        // Uncomment the record parameter to update the reference image.
        assertSnapshot(matching: view, as: .image /*, record: true */)
    }
}
