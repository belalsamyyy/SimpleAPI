//
//  ViewController.swift
//  SimpleAPIExamples
//
//  Created by Belal Samy on 10/09/2021.
//

import UIKit
import SimpleAPI

class ViewController: UIViewController {
    
    // outlets
    @IBOutlet var label: UILabel!
    
    // viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // ======================================================
        API<Post>.object(.get("1")) { post in
            self.label.text = post?.title
        }
        // ======================================================
    }
}

