//
//  SignUpViewController.swift
//  HabitTracker
//
//  Created by Anushka Singh on 02/06/20.
//  Copyright © 2020 Anushka Singh. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import GoogleSignIn
//import FirebaseFirestoreSwift

class SignUpViewController: UIViewController {
    
    
    @IBOutlet weak var backButton: UIButton!
    
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var polygon: UIImageView!
    
    @IBOutlet weak var signUpGmail: UIButton!
    
    @IBOutlet weak var logIn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    func setUpElements() {
        //Hiding the error label
        errorLabel.alpha = 0
        //polygon.transform = polygon.transform.rotated(by: CGFloat(3 * Double.pi / 2))
        //polygon.transform.translatedBy(x: -100, y: -100)
        //Style text fields
        Utilities.styleTextField(nameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        
        //Style Buttons
        Utilities.styleFilledButton1(signUpButton)
        Utilities.styleHollowButton(signUpGmail)
        Utilities.styleSmallFilledButton(logIn)
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
        if nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
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
    
    @IBAction func signUpTapped(_ sender: Any) {
        
        //Validate the fields
        let error = self.validateFields()
        
        if error != nil {
            //There was an error with the fields. Show error message.
            self.showError(error!)
        }
        else {
            
            // Create cleaned versions of data
            let name = nameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //Create the user
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                
                //Check for errors
                if err != nil{
                    // There was an error creating the user
                    self.showError("Error in creating User.")
                }
                else {
                    //User was created successfully, now store the name, email and score
                    let db = Firestore.firestore()
                    
                    db.collection("users").document(result!.user.email ?? "nil").setData(["email" : email, "name" : name, "score" : 0, "uid" : result!.user.uid]) { (error) in
                        
                        if error != nil {
                            //Show error message
                            self.showError("User Data cannot be stored")
                        }
                    }
                    
                    //Save the data in variables available in the App
                    Constants.variables.uid = result!.user.email ?? "nil"
                    Constants.variables.userName = name
                    Constants.variables.email = email
                    
                    //Transition to the Home Screen
                    self.transitionToHome()
                    
                }
            }
        }
        
    }
    
    
    @IBAction func signUpGmailTapped(_ sender: Any) {
        
        //Sign In with google
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().signIn()
        
        Constants.variables.googleSignInUsed = true
        
        //Transiiton to next page
        self.transitionToHome()
        
    }
    
    func showError(_ message:String) {
        
        self.errorLabel.text = message
        self.errorLabel.alpha = 1
    }
    
    func transitionToHome() {
        
        let signIn2ViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.signUp2ViewController) as? SignIn2ViewController
        
        view.window?.rootViewController = signIn2ViewController
        view.window?.makeKeyAndVisible()
        
    }
    
    /*func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
    //Sign in functionality will be handled here
        
        if let error = error {
            self.showError(error.localizedDescription)
        return
        }
        guard let auth = user.authentication else { return }
        let credentials = GoogleAuthProvider.credential(withIDToken: auth.idToken, accessToken: auth.accessToken)
        Auth.auth().signIn(with: credentials) { (authResult, error) in
        if let error = error {
            self.showError(error.localizedDescription)
        }
        else {
            //Sign In successful
            print("Signed In")
            self.transitionToHome()
            //User was created successfully, now store the name, email and score
            let db = Firestore.firestore()
            
            db.collection("users").addDocument(data: ["email" : authResult?.user.email as Any , "name" : authResult?.user.displayName as Any, "score" : 0 , "uid" : authResult!.user.uid]) { (error) in
                
                if error != nil {
                    //Show error message
                    self.showError("User Data cannot be stored")
                }
                else {
                    print("This is important.")
                    print(authResult?.description as Any)
                }
            }
            
            //Save the data in variables available in the App
            Constants.variables.uid = authResult!.user.uid
            Constants.variables.userName = authResult?.user.displayName as Any as! String
            
            //transition to next page
            self.transitionToHome()
        }
    }
    }*/

}
