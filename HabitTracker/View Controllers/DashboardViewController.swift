//
//  DashboardViewController.swift
//  HabitTracker
//
//  Created by Anushka Singh on 02/06/20.
//  Copyright © 2020 Anushka Singh. All rights reserved.
//

import UIKit
import GMStepper

class DashboardViewController: UIViewController {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var addHabitButton: UIButton!
    
    @IBOutlet weak var menuButton: UIButton!
    
    @IBOutlet weak var searchButton: UIButton!
    
    @IBOutlet weak var notifButton: UIButton!
    
    @IBOutlet weak var sortByButton: UIButton!
    
    @IBOutlet weak var dailyMonthlyWeekly: UISegmentedControl!
    
    
    @IBOutlet weak var habitsStackView: UIStackView!
    
    @IBOutlet weak var navHomeButton: UIButton!
    
    @IBOutlet weak var navCommunityButton: UIButton!
    
    @IBOutlet weak var navProfileButton: UIButton!
    
    @IBOutlet weak var navSettingButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //self.restorationIdentifier = Constants.Storyboard.dashboardViewController
        
        if Constants.tempVariables.first == 1 {
            if Constants.variables.habits_neg.isEmpty == false {
                for name in Constants.variables.habits_neg {
                    for (key,value) in Constants.variables.habit_num_neg {
                        //checking for the same habit name
                        if key == name {
                            //number represents the value for negative habits that will be added to the score
                            //value represents how many times the user has commited the negative habit
                            Constants.variables.stepper_neg[name] = self.createHabitButton(name, type: "negative", num: value)
                        }
                    }
                }
            }
            else if Constants.variables.habits_pos.isEmpty == false {
                for name in Constants.variables.habits_pos {
                    for (key,value) in Constants.variables.habit_num_pos {
                        //checking for the same habit name
                        if key == name {
                            //number represents the daily limit for positive habits
                            //value represents how many numbers the user was short off to reach its final score
                            Constants.variables.stepper_pos[name] = self.createHabitButton(name, type: "positive", num: value)
                        }
                    }
                }
            }
            Constants.tempVariables.first = 0
        }
        
        
        if Constants.tempVariables.newHabitAdded == true {
            if Constants.tempVariables.type == "positive" {
                Constants.variables.stepper_pos[Constants.tempVariables.habitName] = self.createHabitButton(Constants.tempVariables.habitName, type: Constants.tempVariables.type, num: Constants.tempVariables.habitVal)
            Constants.tempVariables.newHabitAdded = false
            }
            if Constants.tempVariables.type == "negative" {
                Constants.variables.stepper_neg[Constants.tempVariables.habitName] = self.createHabitButton(Constants.tempVariables.habitName, type: Constants.tempVariables.type, num: Constants.tempVariables.habitVal)
            Constants.tempVariables.newHabitAdded = false
            }
        }
        else {
            if Constants.variables.habits_neg.isEmpty == false {
                for name in Constants.variables.habits_neg {
                    for (key,value) in Constants.variables.habit_num_neg {
                        //checking for the same habit name
                        if key == name {
                            //number represents the value for negative habits that will be added to the score
                            //value represents how many times the user has commited the negative habit
                            Constants.variables.stepper_neg[name] = self.createHabitButton(name, type: "negative", num: value)
                        }
                    }
                }
            }
            else if Constants.variables.habits_pos.isEmpty == false {
                for name in Constants.variables.habits_pos {
                    for (key,value) in Constants.variables.habit_num_pos {
                        //checking for the same habit name
                        if key == name {
                            //number represents the daily limit for positive habits
                            //value represents how many numbers the user was short off to reach its final score
                            Constants.variables.stepper_pos[name] = self.createHabitButton(name, type: "positive", num: value)
                        }
                    }
                }
            }
        }
        
    }
    
    
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
    
    @IBAction func dailyMonthlyWeeklyTapped(_ sender: Any) {
    }
    
    @IBAction func sortByButtonTapped(_ sender: Any) {
    }
    
    @IBAction func notifButtonTapped(_ sender: Any) {
    }
    
    @IBAction func searchButtonTapped(_ sender: Any) {
    }
    
    @IBAction func menuButtonTapped(_ sender: Any) {
        self.transitionToError()
    }
    
    @IBAction func addCategoryButtonTapped(_ sender: Any) {
    }
    
    @IBAction func addHabitButtonTapped(_ sender: Any) {
    }
    
    func styleButton(_ button : UIButton, name : String) -> UIButton{
        button.setTitle(name, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "OpenSans-SemiBold", size: 18)
        button.heightAnchor.constraint(equalToConstant: 25).isActive = true
        button.widthAnchor.constraint(equalToConstant: 70).isActive = true
        Utilities.styleFilledButton1(button)
        return button
    }
    
    func styleView(_ view : UIStackView, type : String) -> UIStackView{
        //setting size
        view.heightAnchor.constraint(equalToConstant: 75.0).isActive = true
        
        //setting shadow
        view.layer.shadowColor = UIColor.powderPinkTwo.cgColor
        view.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        view.layer.shadowOpacity = 0.4
        
        //styling button
        if type == "positive" {
            view.backgroundColor = .warmPurple
        }
        else if type == "negative" {
            view.backgroundColor = .darkPlum
        }
        view.layer.cornerRadius = 25.0
        //button.tintColor = UIColor.white
        
        
        return view
    }
    
    func createHabitButton(_ name : String, type : String, num : Double) -> GMStepper{
        
        var stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fill
        stack = self.styleView(stack, type: type)
        
        var button = UIButton()
        button = self.styleButton(button,name: name)
        stack.addArrangedSubview(button)
        
        //var label = UILabel()
        let stepper = GMStepper()
        stepper.leftButtonText = "-"
        stepper.rightButtonText = "+"
        stepper.minimumValue = 0
        if type == "positive" {
            stepper.maximumValue = num
            stepper.stepValue = 1
        }
        else if type == "negative" {
            stepper.stepValue = num
        }
        stepper.buttonsTextColor = .brownishOrange
        stepper.buttonsBackgroundColor = .paleMauveThree
        stepper.heightAnchor.constraint(equalToConstant: 40).isActive = true
        stepper.labelCornerRadius = 20
        stepper.cornerRadius = 20
        stepper.labelTextColor = .black
        stepper.backgroundColor = .paleMauve
        stepper.buttonsBackgroundColor = .paleMauve
        stepper.heightAnchor.constraint(equalToConstant: 40).isActive = true
        stepper.widthAnchor.constraint(equalToConstant: 70).isActive = true
        stack.addArrangedSubview(stepper)
        
        stack.spacing = 10.0
        stack.heightAnchor.constraint(equalToConstant: 40).isActive = true
        stack = self.styleView(stack, type: type)
        
        habitsStackView.spacing = 20.0
        habitsStackView.alignment = .fill
        
        habitsStackView.addArrangedSubview(stack)
        
        
        return stepper
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
