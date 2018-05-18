//
//  SecondViewController.swift
//  KCCircularTimerExample
//
//  Created by Kevin on 5/16/18.
//  Copyright © 2018 Kevin. All rights reserved.
//

import UIKit
import KCCircularTimer

class SecondViewController: UIViewController {
    @IBOutlet weak var timer31: KCCircularTimer!
    @IBOutlet weak var timer32: KCCircularTimer!
    @IBOutlet weak var timer41: KCCircularTimer!
    @IBOutlet weak var timer42: KCCircularTimer!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func viewTapped(_ sender: UITapGestureRecognizer) {
        guard let view = sender.view else { return }
        let location = sender.location(in: view)
        let subview = view.hitTest(location, with: nil)

        switch subview {
        case timer31:
            timer31.animate(from: 45, to: 0, duration: 10)
        case timer32:
            timer32.animate(from: 72, to: 100, duration: 8)
        case timer41:
            timer41.animate(from: 45, to: 0, duration: 15)
        case timer42:
            timer42.animate(from: 45, to: 0)
        default:
            return
        }
    }
}
