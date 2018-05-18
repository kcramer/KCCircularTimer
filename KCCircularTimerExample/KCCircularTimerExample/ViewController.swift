//
//  ViewController.swift
//  KCCircularTimerExample
//
//  Created by Kevin on 4/15/18.
//  Copyright © 2018 Kevin. All rights reserved.
//

import UIKit
import KCCircularTimer

class ViewController: UIViewController {
    @IBOutlet weak var timer11: KCCircularTimer!
    @IBOutlet weak var timer12: KCCircularTimer!
    @IBOutlet weak var timer13: KCCircularTimer!
    @IBOutlet weak var timer21: KCCircularTimer!
    @IBOutlet weak var timer22: KCCircularTimer!

    override func viewDidLoad() {
        super.viewDidLoad()
        timer11.lineCap = .butt
        timer12.lineCap = .square
        timer21.lineCap = .butt
        timer12.font = UIFont.systemFont(ofSize: 12.0, weight: .light)
    }

    @IBAction func viewTapped(_ sender: UITapGestureRecognizer) {
        guard let view = sender.view else { return }
        let location = sender.location(in: view)
        let subview = view.hitTest(location, with: nil)

        switch subview {
        case timer11:
            timer11.animate(from: 15, to: 0)
        case timer12:
            timer12.animate(from: 31, to: 0)
        case timer13:
            timer13.animate(from: 42, to: 0)
        case timer21:
            timer21.animate(from: 95, to: 358, duration: 15)
        case timer22:
            timer22.animate(from: 1, to: 0, duration: 10)
        default:
            return
        }
    }
}

