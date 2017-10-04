//
//  ViewController.swift
//  MidtermTest
//
//  Created by Student on 10/4/17.
//  Copyright © 2017 Student. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var rootViewLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rootViewLabel.text = "Which cheese do you please?"
        rootViewLabel.textAlignment = NSTextAlignment.center
        rootViewLabel.font = UIFont(name: rootViewLabel.font.fontName, size: 16)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

