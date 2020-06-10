//
//  ViewController.swift
//  HabitTracker
//
//  Created by Anushka Singh on 02/06/20.
//  Copyright © 2020 Anushka Singh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var logInButton: UIButton!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var habitude: UILabel!
    
    @IBOutlet weak var habitudeDesc: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setUpElements()
    }
    
    func setUpElements() {
        
        //set up both buttons
        Utilities.styleFilledButton1(logInButton)
        Utilities.styleFilledButton1(signUpButton)
        
    }

}

