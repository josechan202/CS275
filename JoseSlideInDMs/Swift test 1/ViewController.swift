//
//  ViewController.swift
//  Swift test 1
//
//  Created by Christian Skalka on 7/21/15.
//  Copyright (c) 2015 Christian Skalka. All rights reserved.
//

import UIKit

class ViewController:
    UIViewController,
    UIPickerViewDataSource,
    UIPickerViewDelegate {

    @IBOutlet weak var myPicker: UIPickerView!

    @IBOutlet weak var myLabel: UILabel!
    
    let pickerData = ["Mozzarella","Gorgonzola","Provolone","Brie","Maytag Blue","Sharp Cheddar","Monterrey Jack","Stilton","Gouda","Goat Cheese", "Asiago"]
    
    @IBOutlet weak var slideLbl: UILabel!
    
    @IBAction func mySlider(_ sender: UISlider) {
        slideLbl.text = String(Int(sender.value))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myPicker.dataSource = self
        myPicker.delegate = self
        myLabel.text = "Pick yer cheeze!"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        myLabel.text = pickerData[row]
    }
}

