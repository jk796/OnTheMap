//
//  ViewController.swift
//  OnTheMap
//
//  Created by Jimin Kim on 1/6/21.
//  Copyright © 2021 Jimin Kim. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        emailTextField.text = ""
        passwordTextField.text = ""
        loginButton.layer.cornerRadius = 5
    }

    
    @IBAction func loginTapped(_ sender: Any) {
        API.login(username: emailTextField.text ?? "", password: passwordTextField.text ?? "", completion: handleLoginResponse(success:error:))
    }
    
    func handleLoginResponse(success: Bool, error: Error?) {
        if success {
            self.performSegue(withIdentifier: "completeLogin", sender: nil)
        } else {
            showLoginFailure(message: error?.localizedDescription ?? "")
        }
    }
    
    @IBAction func signupTapped(_ sender: Any) {
        UIApplication.shared.open(URL(string: "https://auth.udacity.com/sign-up")!, options: [:], completionHandler: nil)
        
    }
    
    
    func showLoginFailure(message: String) {
        let alertVC = UIAlertController(title: "Login Failed", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        show(alertVC, sender: nil)
    }

}
