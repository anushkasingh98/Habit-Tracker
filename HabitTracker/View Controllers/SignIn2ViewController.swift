//
//  SignIn2ViewController.swift
//  HabitTracker
//
//  Created by Anushka Singh on 05/06/20.
//  Copyright © 2020 Anushka Singh. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class SignIn2ViewController: UIViewController {
    
    @IBOutlet weak var meditationButton: UIButton!
    
    @IBOutlet weak var smokingButton: UIButton!
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var polygon: UIImageView!
    
    @IBOutlet weak var backButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setUpElements()
    }
    
    func setUpElements() {
        
        //set up next button
        nextButton.backgroundColor = .warmPurple
        nextButton.layer.cornerRadius = 15.0
        nextButton.tintColor = UIColor.white
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    @IBAction func meditationButtonTapped(_ sender: Any) {
        //name of habit
        let name_habit = "Meditation"
        
        //Adding meditation as a habit
        Constants.variables.habits_pos.append(name_habit)
        
        //add num also
        Constants.variables.habit_num_pos[name_habit] = 15.0
        
        //add value also
        Constants.variables.habit_val[name_habit] = 0.0
        
        //change button
        meditationButton.alpha = 0.7
    }
    
    
    @IBAction func smokingButtonTapped(_ sender: Any) {
        //name of habit
        let name_habit = "Smoking"
        
        //Adding smoking as a habit
        Constants.variables.habits_neg.append(name_habit)
        
        //add num also
        Constants.variables.habit_num_neg[name_habit] = 10.0
        
        //add value
        Constants.variables.habit_val[name_habit] = 0.0
        
        //change button
        smokingButton.alpha = 0.7
    }
    
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        //Move to dahsboard
        self.transitionToDashboard()
    }
    
    
    @IBAction func backButtonTapped(_ sender: Any) {
        
        //sign out
        Functions.signOut()
        
        //transition to launch
        self.transitionToLaunch()
    }
    
    func transitionToLaunch() {
        let launchViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.launchViewController) as? ViewController
        
        view.window?.rootViewController = launchViewController
        view.window?.makeKeyAndVisible()
    }
    
    func transitionToDashboard() {
        
        let dashboardViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.dashboardViewController) as? DashboardViewController
        
        view.window?.rootViewController = dashboardViewController
        view.window?.makeKeyAndVisible()
        
    }
    
//    func savingGoogleData() {
//        //check if sign in method used was google sign in
//        if Constants.variables.googleSignInUsed == true {
//            //save data in the database
//            
//            let user: GIDGoogleUser = GIDSignIn.sharedInstance()!.currentUser
//
//            let name = user.profile.name
//            let email = user.profile.email
//            let uid = user.userID
//
//            //User was created successfully, now store the name, email and score
//            let db = Firestore.firestore()
//
//            db.collection("users").addDocument(data: ["email" : email, "name" : name as Any, "score" : 0, "uid" : uid]) { (error) in
//
//                if error != nil {
//                    //Show error message
//                    print("User Data cannot be stored")
//                }
//            }
//
//            //Save the data in variables available in the App
//            Constants.variables.uid = user.userID
//            Constants.variables.userName = user.profile.name
//
//            //Transition to the Home Screen
//            self.transitionToHome()
//        }
//    }
    
}
