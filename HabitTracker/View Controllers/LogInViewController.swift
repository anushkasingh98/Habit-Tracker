//
//  LogInViewController.swift
//  HabitTracker
//
//  Created by Anushka Singh on 02/06/20.
//  Copyright © 2020 Anushka Singh. All rights reserved.
//

import UIKit
import FirebaseAuth
import GoogleSignIn

class LogInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var logInButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var logInGmail: UIButton!
    
    @IBOutlet weak var SignUpButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setUpElements()
    }
    
    func setUpElements() {
        //Hide the error label
        errorLabel.alpha = 0
        
        //Style the text fields
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        
        //Style buttons
        Utilities.styleFilledButton1(logInButton)
        Utilities.styleHollowButton(logInGmail)
        Utilities.styleSmallFilledButton(SignUpButton)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    //Check fields and validate that inputed data is correct. If everything is correct, return nil, otherwise return error message as string.
    func validateFields() -> String? {
        
        //Check that all fields are filled in
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields. "
        }
        
        //Check if password is secure (password needs to have 8 charactters, a special character and 1 number)
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanedPassword) == false {
            //Password is not secure enough
            return "Please make sure that your password contains at least 8 characters, contains atleast 1 special character and a number. "
        }
        
        //Check if email is correct
        let cleanedEmail = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isEmailValid(cleanedEmail) == false {
            return "Email incorrect."
        }
        
        return nil
    }

    @IBAction func logInTapped(_ sender: Any) {
        
        //Validate Text Fields
        let error = self.validateFields()
        
        if error != nil {
            //There was an error with the fields. Show error message.
            self.showError(error!)
        }
        else {
            //Create cleaned versions of the text fields
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //Signing in the User
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                
                if error != nil {
                    //Couldn't Sign in
                    self.errorLabel.text = error!.localizedDescription
                    self.errorLabel.alpha = 1
                }
                else {
                    //saving data of user in the variables
                    Constants.variables.uid = result!.user.email ?? "nil"
                    
                    //getting data from the database
                    Functions.loadDB()
                    
                    //Transition to dashboard
                    self.transitionToDashboard()
                }
            }
        }
    }
    
    @IBAction func logInGmailTapped(_ sender: Any) {
        //Log In with google
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().signIn()
        
        Constants.variables.googleSignInUsed = true
        
        //load the database
        Functions.loadDB()
        
        //Transiiton to next page
        self.transitionToDashboard()
    }
    
    func showError(_ message:String) {
        
        self.errorLabel.text = message
        self.errorLabel.alpha = 1
    }
    
    func transitionToDashboard() {
        
        //DashboardViewController.
        
        let dViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.dashboardViewController ) as? DashboardViewController
        
        view.window?.rootViewController = dViewController
        view.window?.makeKeyAndVisible()
        
    }
    
    func transitionToError() {
        
        let errViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.errorViewController) as? ErrorViewController
        
        view.window?.rootViewController = errViewController
        view.window?.makeKeyAndVisible()
        
    }
    
}
