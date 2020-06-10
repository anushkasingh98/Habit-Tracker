//
//  Constants.swift
//  HabitTracker
//
//  Created by Anushka Singh on 04/06/20.
//  Copyright © 2020 Anushka Singh. All rights reserved.
//

import Foundation
import GMStepper

struct Constants {
    
    struct Storyboard {
        
        //static let dashboardViewController = "DashboardVC"
        static let dashboardViewController = "try1"
        
        static let signUp2ViewController = "SignIn2VC"
        
        static let launchViewController = "LaunchVC"
        
        static let addHabitViewController = "NewHabitVC"
        
        static let catExpViewController = "CategoryExpansionVC"
        
        static let communityViewController = "CommunityVC"
        
        static let profileViewController = "ProfileVC"
        
        static let ngoViewController = "ngoVC"
        
        static let errorViewController = "ErrorVC"
        
    }
    
    struct variables {
        
        static var uid : String = ""
        
        static var userName : String = ""
        
        static var email : String = ""
        
        static var lastDAte : Date = Date()
        
        static var habits_pos = [String]()
        
        static var habits_neg = [String]()
        
        static var habit_num_neg = [String : Double]()
        
        static var habit_num_pos = [String : Double]()
        
        static var habit_val = [String : Double]()
        
        static var categories = [String : Any]()
        
        static var score : Double = 0.0
        
        static var googleSignInUsed : Bool = false
        
        static var notifDays = [String]()
        
        static var stepper_neg = [String : GMStepper]()
        
        static var stepper_pos = [String : GMStepper]()
        
    }
    
    struct tempVariables {
        
        static var type = String()
        
        static var habitName = String()
        
        static var habitVal = Double()
        
        static var newHabitAdded : Bool = false
        
        static var first : Int = 1
    }
}
