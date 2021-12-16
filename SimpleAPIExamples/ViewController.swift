//
//  ViewController.swift
//  SimpleAPIExamples
//
//  Created by Belal Samy on 10/09/2021.
//

import UIKit
import SimpleAPI

class ViewController: UIViewController {
    @IBOutlet var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getPost(id: "5")
    }
    
    //MARK: - get post with id
    func getPost(id: String) {
        API<Post>.object(.get(id)) { [weak self] result in
            switch result {
            case .success(let post):
                self?.label.text = post?.title
                
            case .failure(let error):
                print(error)
            }
        }
    }


}

