//
//  SecondVC.swift
//  SegueSwift
//
//  Created by Christian Skalka on 10/3/17.
//  Copyright © 2017 Christian Skalka. All rights reserved.
//

import UIKit

class SecondVC: UIViewController {
    
    var stringPassed = ""
    
    @IBOutlet weak var secondLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        secondLabel.text = stringPassed
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
