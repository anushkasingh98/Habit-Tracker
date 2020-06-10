//
//  ErrorViewController.swift
//  HabitTracker
//
//  Created by Anushka Singh on 09/06/20.
//  Copyright © 2020 Anushka Singh. All rights reserved.
//

import UIKit

class ErrorViewController: UIViewController {
    
    
    @IBOutlet weak var button: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        Utilities.styleFilledButton1(button)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func buttonTapped(_ sender: Any) {
        self.transitionToDashboard()
    }
    

    
    func transitionToError() {
        
        let errViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.errorViewController) as? ErrorViewController
        
        view.window?.rootViewController = errViewController
        view.window?.makeKeyAndVisible()
        
    }
    
    func transitionToProfile() {
        
        let profileViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.profileViewController) as? ProfileViewController
        
        view.window?.rootViewController = profileViewController
        view.window?.makeKeyAndVisible()
        
    }
    
    func transitionToDashboard() {
        
        let dashboardViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.dashboardViewController) as? DashboardViewController
        
        view.window?.rootViewController = dashboardViewController
        view.window?.makeKeyAndVisible()
        
    }
    
    func transitionToCommunity() {
        
        let commViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.communityViewController) as? CommunityViewController
        
        view.window?.rootViewController = commViewController
        view.window?.makeKeyAndVisible()
        
    }
    
    func transitionToLaunch() {
           
           let launchViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.launchViewController) as? ViewController
           
           view.window?.rootViewController = launchViewController
           view.window?.makeKeyAndVisible()
           
    }
    
}
