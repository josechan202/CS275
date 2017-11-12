//
//  CustomTabBarController.swift
//  Clubster
//
//  Created by Adam T. Barson on 11/11/17.
//  Copyright © 2017 Adam Barson. All rights reserved.
//

import UIKit

class CustomTabBarController: UIViewController {

    var selectedIndex = 0
    
    @IBOutlet var buttons : [UIButton]!
    
    @IBOutlet weak var contentView: UIView!
    
    @IBAction func didPressTab(_ sender: UIButton) {
        let previousIndex = selectedIndex
        selectedIndex = sender.tag
        
        buttons[previousIndex].isSelected = false
        let previousVC = viewControllers[previousIndex]
        previousVC.willMove(toParentViewController: nil)
        previousVC.view.removeFromSuperview()
        previousVC.removeFromParentViewController()
        
        sender.isSelected = true
        
        let vc = viewControllers[selectedIndex]
        
        addChildViewController(vc)
        vc.view.frame = contentView.bounds
        contentView.addSubview(vc.view)
        vc.didMove(toParentViewController: self)
    }
    
    
    var homeViewController: UIViewController!
    var searchController: UIViewController!
    var settingsController: UIViewController!
    var viewControllers: [UIViewController]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        
        homeViewController = storyboard.instantiateViewController(withIdentifier: "homeNav")
        searchController = storyboard.instantiateViewController(withIdentifier: "AllClubsVC")
        settingsController = storyboard.instantiateViewController(withIdentifier: "SettingsPageController")
        viewControllers = [homeViewController, searchController, settingsController]
        
        buttons[selectedIndex].isSelected = true
        didPressTab(buttons[selectedIndex])
        // Do any additional setup after loading the view.
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

