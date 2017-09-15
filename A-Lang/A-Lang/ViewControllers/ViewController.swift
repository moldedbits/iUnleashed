//
//  ViewController.swift
//  A-Lang
//
//  Created by Saurabh Gupta on 15/09/17.
//  Copyright © 2017 moldedbits. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        APIManager.shared.getCategories()
//        APIManager.shared.getPassages()
//        APIManager.shared.getPassageDetails()
    }
    
}

