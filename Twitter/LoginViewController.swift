//
//  LoginViewController.swift
//  Twitter
//
//  Created by Athena Enosara on 2/16/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: "UserLoggedIn") == true {
            self.performSegue(withIdentifier: "loginToHome", sender: self)
        }
    }
    
    //START OF LOG IN CODE
    @IBAction func on_loginButton(_ sender: Any) {
//        print("Hello World.")
        let myUrl = "https://api.twitter.com/oauth/request_token"
        
        TwitterAPICaller.client?.login(url: myUrl, success: {
            print("Login successful!")
            self.performSegue(withIdentifier: "loginToHome", sender: self)
            UserDefaults.standard.set(true, forKey: "UserLoggedIn")
        }, failure: { (Error) in
            print("Could not login.")
        })
    }//END OF LOGIN CODE
    
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

}
