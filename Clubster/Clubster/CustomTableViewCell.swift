//
//  CustomTableViewCell.swift
//  Clubster
//
//  Created by Jack Hurley on 11/28/17.
//  Copyright © 2017 Adam Barson. All rights reserved.
//

import UIKit


class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    
    @IBOutlet weak var secondHeightConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var clubCellLabel: UILabel!
    @IBOutlet weak var subButton: UIButton!
    
//    @IBAction func gesture(press: UILongPressGestureRecognizer){
//        if press.state == .began{
//             let location = press.location(in: <#T##UIView?#>)
//        }
//    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    var showDetails = false {
        didSet {
            secondHeightConstraint.priority = showDetails ? 250 : 999
        }
    }
    
}
