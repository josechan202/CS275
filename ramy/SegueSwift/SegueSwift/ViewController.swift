//
//  ViewController.swift
//  SegueSwift
//
//  Created by Christian Skalka on 10/3/17.
//  Copyright © 2017 Christian Skalka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myLabel: UILabel!
    
    var ctr1 = 0
    var ctr2 = 0
    
    @IBAction func goButton(_ sender: Any) {
        let myVC = storyboard?.instantiateViewController(withIdentifier: "SecondVC") as! SecondVC
        
        ctr2 = ctr2 + 1
        myVC.stringPassed = myLabel.text! + " press \(ctr2), load \(ctr1)"
        navigationController?.pushViewController(myVC, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        ctr1 = ctr1 + 1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

