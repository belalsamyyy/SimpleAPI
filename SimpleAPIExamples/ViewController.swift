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
        // the normal way to do it with success & failure callback
        getPost(id: "5")
        
        // with the quicker function that just return the value directly
        API<Post>.quickObject(.get("5")) { [weak self] post in
            self?.label.text = post?.title
            
        }
    }
    
    //MARK: - get post with id
    
    // the normal way to do it with success & failure callback
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

