//
//  NGOViewController.swift
//  HabitTracker
//
//  Created by Anushka Singh on 08/06/20.
//  Copyright © 2020 Anushka Singh. All rights reserved.
//

import UIKit

class NgoViewController: UIViewController {
    
    
    @IBOutlet weak var notifButton: UIButton!
    
    
    @IBOutlet weak var searchButton: UIButton!
    
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var menuButton: UIButton!
    
    @IBOutlet weak var donateButton: UIButton!
    
    
    @IBOutlet weak var navHomeButton: UIButton!
    
    @IBOutlet weak var navCommunityButton: UIButton!
    
    @IBOutlet weak var navProfileButton: UIButton!
    
    @IBOutlet weak var navSettingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    @IBAction func navSettingButtonTapped(_ sender: Any) {
        //Sign out ???
        Functions.signOut()
        
        self.transitionToLaunch()
        
        //self.transitionToError()
    }
    
    
    @IBAction func navProfileButtonTapped(_ sender: Any) {
        self.transitionToProfile()
    }
    
    @IBAction func navCommButtonTapped(_ sender: Any) {
        self.transitionToCommunity()
    }
    
    @IBAction func navHomeButtonTapped(_ sender: Any) {
        self.transitionToDashboard()
    }
    
    
    @IBAction func donateButtonTapped(_ sender: Any) {
    }
    
    @IBAction func menuButtonTapped(_ sender: Any) {
    }
    
    @IBAction func searchButtonTapped(_ sender: Any) {
    }
    
    
    @IBAction func notifButtonTapped(_ sender: Any) {
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
