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
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!

    @IBOutlet weak var switchLabel: UILabel!
    
    @IBOutlet weak var switch1: UISwitch!
    
    let pickerData = ["Mozzarella","Gorgonzola","Provolone","Brie","Maytag Blue","Sharp Cheddar","Monterrey Jack","Stilton","Gouda","Goat Cheese", "Asiago"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myPicker.dataSource = self
        myPicker.delegate = self
        myLabel.text = "Pick yer cheeze!"
        button1.setTitle("", for: .normal)
        button2.setTitle("", for: .normal)
        switchLabel.text = "Show buttons below"
        switch1.isOn = false
        switch1.setOn(false, animated: false)
        if(switch1.isOn)
        {
            switchLabel.text = "Switch is on"
        }
        else
        {
            switchLabel.text = "Switch is off"
        }
    }
    
    @IBAction func switch2(_ sender: UISwitch) {
        if(switch1.isOn)
        {
            switchLabel.text = "Switch is on"
        }
        else
        {
            switchLabel.text = "Switch is off"
        }
    }    
    
    @IBAction func button1(_ sender: Any) {
        button1.setTitle("apple sucks", for: .normal)
        button2.setTitle("Click to reset", for: .normal)
    }
    @IBAction func button2(_ sender: Any) {
        button1.setTitle("Click for a secret", for: .normal)
        button2.setTitle("", for: .normal)
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

