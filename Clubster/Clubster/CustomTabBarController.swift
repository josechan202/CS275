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
        (previousVC as! UINavigationController).popToRootViewController(animated: false)
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
        //let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        homeViewController = self.storyboard?.instantiateViewController(withIdentifier: "homeNav")
        searchController = self.storyboard?.instantiateViewController(withIdentifier: "allClubsNav")
        settingsController = self.storyboard?.instantiateViewController(withIdentifier: "settingsNav")
        viewControllers = [homeViewController, searchController, settingsController]
        
        buttons[selectedIndex].isSelected = true
        didPressTab(buttons[selectedIndex])
        // Do any additional setup after loading the view.
        
        let leftSwipe1 = UISwipeGestureRecognizer(target: self, action: #selector(shiftRight(swipe:)))
        leftSwipe1.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(leftSwipe1)
        
        let rightSwipe1 = UISwipeGestureRecognizer(target: self, action: #selector(shiftLeft(swipe:)))
        rightSwipe1.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(rightSwipe1)
    }
    
    func shiftRight(swipe:UISwipeGestureRecognizer){
        if selectedIndex == 0{
            didPressTab(buttons[1])
        }
        else if selectedIndex == 1 {
            didPressTab(buttons[2])
        }
    
    }
    func shiftLeft(swipe:UISwipeGestureRecognizer){
        if selectedIndex == 1 {
            didPressTab(buttons[0])
        }
        else if selectedIndex == 2 {
            didPressTab(buttons[1])
        }
        
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

