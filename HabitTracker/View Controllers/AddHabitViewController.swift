//
//  AddHabitViewController.swift
//  HabitTracker
//
//  Created by Anushka Singh on 08/06/20.
//  Copyright © 2020 Anushka Singh. All rights reserved.
//

import UIKit

class AddHabitViewController: UIViewController {
    
    
    @IBOutlet weak var navHomeButton: UIButton!
    
    @IBOutlet weak var navCommunityButton: UIButton!
    
    @IBOutlet weak var navProfileButton: UIButton!
    
    @IBOutlet weak var navSettingButton: UIButton!
    
    
    @IBOutlet weak var background: UIImageView!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var addHabitStack: UIStackView!
    
    
    @IBOutlet weak var habitNameTextField: UITextField!
    
    @IBOutlet weak var positiveButton: UIButton!
    
    @IBOutlet weak var negativeButton: UIButton!
    
    
    @IBOutlet weak var valueTextField: UITextField!
    
    
    @IBOutlet weak var dailyWeeklyMonthlyYearly: UISegmentedControl!
    
    @IBOutlet weak var mondayButton: UIButton!
    
    @IBOutlet weak var TuesdayButton: UIButton!
    
    @IBOutlet weak var wednesdayButton: UIButton!
    
    @IBOutlet weak var thursdayButton: UIButton!
    
    @IBOutlet weak var fridayButton: UIButton!
    
    @IBOutlet weak var saturdayButton: UIButton!
    
    @IBOutlet weak var sundayButton: UIButton!
    
    @IBOutlet weak var whyTextField: UITextField!
    
    @IBOutlet weak var addHabitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.stylePage()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func navHomeButtonTapped(_ sender: Any) {
        self.transitionToDashboard()
    }
    
    
    @IBAction func navCommunityButtonTapped(_ sender: Any) {
        self.transitionToCommunity()
    }
    
    
    @IBAction func navProfileButtonTapped(_ sender: Any) {
        self.transitionToProfile()
    }
    
    
    @IBAction func navSettingButtonTapped(_ sender: Any) {
        //Sign out ???
        Functions.signOut()
        
        self.transitionToLaunch()
        
        //self.transitionToError()
    }
    
    
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.transitionToDashboard()
    }
    
    @IBAction func addHabitButtonTapped(_ sender: Any) {
        //create habit
        Constants.tempVariables.habitVal = Double(valueTextField.text!) ?? 5.0
        Constants.tempVariables.habitName = habitNameTextField.text!
        Constants.tempVariables.newHabitAdded = true
        
        self.transitionToDashboard()
    }
    
    @IBAction func mondayButtonTapped(_ sender: Any) {
        mondayButton.layer.borderColor = UIColor.black.cgColor
        mondayButton.layer.borderWidth = 1.0
        Constants.variables.notifDays.append("Monday")
    }
    
    @IBAction func tuesdayButtonTapped(_ sender: Any) {
        TuesdayButton.layer.borderColor = UIColor.black.cgColor
        TuesdayButton.layer.borderWidth = 1.0
        Constants.variables.notifDays.append("Tuesday")
    }
    
    @IBAction func wednesdayButtonTapped(_ sender: Any) {
        wednesdayButton.layer.borderWidth = 1.0
        wednesdayButton.layer.borderColor = UIColor.black.cgColor
        Constants.variables.notifDays.append("Wednesday")
    }
    
    @IBAction func thursdayButtonTapped(_ sender: Any) {
        thursdayButton.layer.borderColor = UIColor.black.cgColor
        thursdayButton.layer.borderWidth = 1.0
        Constants.variables.notifDays.append("Thursday")
    }
    
    @IBAction func fridayButtonTapped(_ sender: Any) {
        fridayButton.layer.borderWidth = 1.0
        fridayButton.layer.borderColor = UIColor.black.cgColor
        Constants.variables.notifDays.append("Friday")
    }
    
    @IBAction func saturdayButtonTapped(_ sender: Any) {
        saturdayButton.layer.borderColor = UIColor.black.cgColor
        saturdayButton.layer.borderWidth = 1.0
        Constants.variables.notifDays.append("Saturday")
    }
    
    @IBAction func sundayButtonTapped(_ sender: Any) {
        sundayButton.layer.borderWidth = 1.0
        sundayButton.layer.borderColor = UIColor.black.cgColor
        Constants.variables.notifDays.append("Sunday")
    }
    
    
    
    @IBAction func positiveButtonTapped(_ sender: Any) {
        Constants.tempVariables.type = "positive"
        positiveButton.alpha = 0.7
        negativeButton.alpha = 1
    }
    
    @IBAction func negativeButtonTapped(_ sender: Any) {
        Constants.tempVariables.type = "negative"
        negativeButton.alpha = 0.7
        positiveButton.alpha = 1
    }
    
    
    
    func stylePage() {
        Utilities.styleTextField(habitNameTextField)
        
        Utilities.styleTextField(whyTextField)
        
        Utilities.styleFilledButton1(addHabitButton)
        
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
