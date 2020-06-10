//
//  AppDelegate.swift
//  HabitTracker
//
//  Created by Anushka Singh on 02/06/20.
//  Copyright © 2020 Anushka Singh. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        return true
    }

    // MARK: UISceneSession Lifecycle
    
    @available(iOS 9.0, *)
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
    let handled = GIDSignIn.sharedInstance().handle(url)
    return handled
    // return GIDSignIn.sharedInstance().handle(url,
    // sourceApplication:options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
    // annotation: [:])
    }

    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!){
    //Sign in functionality will be handled here
        
        if let error = error {
            print("Error coming.")
            print(error.localizedDescription)
        return
        }
        guard let auth = user.authentication else { return }
        let credentials = GoogleAuthProvider.credential(withIDToken: auth.idToken, accessToken: auth.accessToken)
        Auth.auth().signIn(with: credentials) { (authResult, error) in
        if let error = error {
            print("Error coming 1.")
            print(error.localizedDescription)
            //return false
        }
        else {
            
            //print(authResult?.description)
            self.savingGoogleData()
            //Sign In successful
            print("Signed In")
            //self.window
            
        }
    }
        return
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    func savingGoogleData() {
        //check if sign in method used was google sign in
        if Constants.variables.googleSignInUsed == true {
            //save data in the database
            
            let user: GIDGoogleUser = GIDSignIn.sharedInstance()!.currentUser

            let name = user.profile.name
            let email = user.profile.email
            //let uid = user.userID

            //User was created successfully, now store the name, email and score
            let db = Firestore.firestore()

            db.collection("users").document(user.profile.email).setData(["email" : email as Any, "name" : name as Any, "score" : 0, "uid" : user.userID ?? "nil"]) { (error) in

                if error != nil {
                    //Show error message
                    print("User Data cannot be stored")
                }
            }

            //Save the data in variables available in the App
            Constants.variables.uid = user.profile.email
            Constants.variables.userName = user.profile.name
            Constants.variables.email = user.profile.email

        }
    }
}

