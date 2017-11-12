//
//  HomeVC.swift
//  Clubster
//
//  Created by Adam Barson on 10/10/17.
//  Copyright © 2017 Adam Barson. All rights reserved.
//

import UIKit

class HomeVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var subscriptionStrings = [String]()
    
    @IBOutlet weak var homeLabel: UILabel!
    
    @IBOutlet weak var subList: UITableView!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    
    @IBAction func doLogout(_ sender: Any) {
        let appDelegate =
            UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let username = UserSingleton.sharedInstance.user!.username!
        do {
            managedContext.delete(UserSingleton.sharedInstance.user!)
            try managedContext.save()
            
            print("Successfully logged out \(username)")
            
            /*let nextVC =
                storyboard?.instantiateViewController(withIdentifier:
                    "LoginViewController") as! ViewController
            //nextVC.stringPassed = myLabel.text! + " press \(ctr2), load \(ctr1)";
            navigationController?.pushViewController(nextVC, animated: true)*/
            
            let appDelegate = UIApplication.shared.delegate! as! AppDelegate
            
           // let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController")
            //let nav = UINavigationController(rootViewController: vc!)
            
            let nextVC =
                self.storyboard?.instantiateViewController(withIdentifier:
                    "loginNavigationController")
            
            appDelegate.window?.rootViewController = nextVC
            appDelegate.window?.makeKeyAndVisible()
            
        } catch let error as NSError  {
            print("Could not logout \(error), \(error.userInfo)")
        }
    }
    
    
    @IBAction func toAllClubs(_ sender: Any) {
        let nextVC =
            storyboard?.instantiateViewController(withIdentifier:
                "AllClubsVC") as! AllClubsVC
        //nextVC.stringPassed = myLabel.text! + " press \(ctr2), load \(ctr1)";
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func toClubPage(_ sender: Any) {
        // ! vs ? in the context:
        // ! will immediately assume the cast is valid, and will attempt
        // to downcast, throwing an exception if the cast is invalid
        // ? will try to cast, but will simply evaluate the variable to nil if the cast is invalid
        let nextVC =
            storyboard?.instantiateViewController(withIdentifier:
                "ClubPageVC") as! ClubPageVC
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationController?.setNavigationBarHidden(true, animated: false)
        //self.navigationItem.setHidesBackButton(true, animated: false)
        //self.tableView.delegate = self
        
        let text = UserSingleton.sharedInstance.user!.getUsername()
        welcomeLabel.text = "Welcome, \(text)"
        
        subList.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        subList.dataSource = self
        
        for club in UserSingleton.sharedInstance.user!.subscriptions!{
            let club_name = (club as! Club).name!
            subscriptionStrings.append(club_name)
        }
        // Do any additional setup after loading the view.
        subscriptionStrings.append("Hey")

    }
    
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the navigation bar for current view controller
        self.navigationController?.isNavigationBarHidden = true;
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.isNavigationBarHidden = false;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return subscriptionStrings.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt
        indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        cell!.textLabel!.text = subscriptionStrings[indexPath.row]
        
        return cell!
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        print("row selected: " + subscriptionStrings[indexPath.row])
        let nextVC =
            self.storyboard?.instantiateViewController(withIdentifier:
                "ClubPageVC") as! ClubPageVC
        nextVC.clubName = subscriptionStrings[indexPath.row]
        self.navigationController?.pushViewController(nextVC, animated: true)
        
        
        
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
