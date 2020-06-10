//
//  Functions.swift
//  HabitTracker
//
//  Created by Anushka Singh on 07/06/20.
//  Copyright © 2020 Anushka Singh. All rights reserved.
//

import Foundation
import Firebase
import UIKit
import GMStepper

class Functions {
    //this will contain important functions that can be called from anywhere
    
    static func updateDB() {
        //update the Firestore database
        let db = Firestore.firestore()
        
        var dictionary = [String : Any]()
        dictionary["uid"] = Constants.variables.uid
        dictionary["name"] = Constants.variables.userName
        dictionary["email"] = Constants.variables.email
        
        var positive = [String : Any]()
        
        //making dictionary of positive habits
        for name in Constants.variables.habits_pos {
            for (key,value) in Constants.variables.habit_num_pos {
                for (key2,value2) in Constants.variables.habit_val {
                    //checking for the same habit name
                    if key == name && key2 == name{
                        //number represents the daily limit for positive habits
                        //value represents how many numbers the user was short off to reach its final score
                        positive[name] = ["number" : value, "value" : value2]
                    }
                }
            }
        }
        
        dictionary["positive habits"] = positive
        
        var negative = [String : Any]()
        
        //making dictionary of negative habits
        for name in Constants.variables.habits_neg {
            for (key,value) in Constants.variables.habit_num_neg {
                for (key2,value2) in Constants.variables.habit_val {
                    //checking for the same habit name
                    if key == name && key2 == name{
                        //number represents the value for negative habits that will be added to the score
                        //value represents how many times the user has commited the negative habit
                        negative[name] = ["number" : value, "value" : value2]
                    }
                }
            }
        }
        
        dictionary["negative habits"] = negative
        
        self.calcScore()
        dictionary["score"] = Constants.variables.score
        
        dictionary["lastDate"] = dateAndTime.currentDate
        
        db.collection("users").document(Constants.variables.uid).setData(dictionary)
    }
    
    //Calculating score
    static func calcScore() {
        //first lets calculate score for negative habits
        for name in Constants.variables.habits_neg {
            for (key,value) in Constants.variables.habit_num_neg {
                for (key2,value2) in Constants.variables.habit_val {
                    //checking for the same habit name
                    if key == name && key2 == name {
                        Constants.variables.score = Constants.variables.score + (value * value2)
                    }
                }
            }
        }
        
        //now lets calculate score for positive habits
        for name in Constants.variables.habits_pos {
            for (key,value) in Constants.variables.habit_num_pos {
                for (key2,value2) in Constants.variables.habit_val {
                    //checking for the same habit name
                    if key == name && key2 == name{
                        //number represents the daily limit for positive habits
                        //value represents how many numbers the user was short off to reach its final score
                        Constants.variables.score = Constants.variables.score + (value - value2)
                    }
                }
            }
        }
        
    }
    
    //Function to sign out
    static func signOut() {
        //get stepper values
        if Constants.variables.stepper_pos.isEmpty == false && Constants.variables.stepper_neg.isEmpty == false {
            for (name,stepper) in Constants.variables.stepper_neg {
                Constants.variables.habit_val[name] = stepper.value
            }
            for (name,stepper) in Constants.variables.stepper_pos {
                Constants.variables.habit_val[name] = stepper.value
            }
        }
        
        //update database
        self.updateDB()
        
        //Sign out
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
        
    }
    
    //load database into app
    static func loadDB() {
        //getting the database
        let db = Firestore.firestore()
        
        //getting the document
        let doc = db.collection("users").document(Constants.variables.uid)
        print("UID : ")
        print(Constants.variables.uid)
        
        doc.getDocument { (document, error) in
            if let document = document, document.exists {
                //let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(document)")
                
                print(type(of: document))
                let keys = document.data()?.keys
                let values = document.data()?.values
                
                let l = keys?.count
                let l2 = values?.count
                
                var positive = [String : Any]()
                var negative = [String : Any]()
                
                if l != l2 {
                    print("keys size and values size does not match.  \(String(describing: l)) and \(l2 ?? Int(0.0))")
                }
                else {
                    for case let (key,val) in document.data()!.enumerated() {
                        print("key = \(key) and val = \(val)")
                        print(type(of: val))
                        print(val.key)
                        if val.key == "name" {
                            Constants.variables.userName = val.value as! String
                        }
                        if val.key == "email" {
                            Constants.variables.email = val.value as! String
                            Constants.variables.uid = val.value as! String
                        }
                        if val.key == "score" {
                            Constants.variables.score = val.value as! Double
                        }
//                        if val.key == "lastDate" {
//                            Constants.variables.lastDAte = val.value as! Date
//                        }
                        if val.key == "positive habits" {
                            positive = val.value as! [String : Any]
                            //now divide positive to its respective categories
                            
                            for (name, dict) in positive {
                                Constants.variables.habits_pos.append(name)
                                
                                for (str,num) in dict as! Dictionary<String, Any>{
                                    if str == "number"{
                                        Constants.variables.habit_num_pos[name] = num as? Double
                                    }
                                    if str == "value" {
                                        Constants.variables.habit_val[name] = num as? Double
                                    }
                                }
                            }
                            
                        }
                        if val.key == "negative habits" {
                            negative = val.value as! [String : Any]
                            
                            for (name, dict) in negative {
                                Constants.variables.habits_neg.append(name)
                                
                                for (str,num) in dict as! Dictionary<String, Any> {
                                    if str == "number" {
                                        Constants.variables.habit_num_neg[name] = num as? Double
                                    }
                                    if str == "value" {
                                        Constants.variables.habit_val[name] = num as? Double
                                    }
                                }
                            }
                            
                        }
                        
                    }
                }
            } else {
                print("Document does not exist")
            }
        }
        print("this is the load DB function.")

    }

    
}
