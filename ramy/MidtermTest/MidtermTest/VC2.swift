//
//  VC2.swift
//  MidtermTest
//
//  Created by Student on 10/4/17.
//  Copyright © 2017 Student. All rights reserved.
//

import UIKit

class VC2: UIViewController {

    @IBOutlet weak var VC2Label: UILabel!
    @IBOutlet weak var wineNumber: UILabel!
    @IBOutlet weak var wineStepper: UIStepper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        VC2Label.text = "And how many bottles of wine?"
        VC2Label.textAlignment = NSTextAlignment.center
        VC2Label.font = UIFont(name: VC2Label.font.fontName, size: 16)
        wineNumber.text = Int(wineStepper.value).description
        wineStepper.minimumValue = 3
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func wineStepper(_ sender: UIStepper) {
        wineNumber.text = Int(sender.value).description
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
