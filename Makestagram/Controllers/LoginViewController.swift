//
//  LoginViewController.swift
//  Makestagram
//
//  Created by Jozef Porubcin on 6/26/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseAuthUI
import FirebaseDatabase
import Foundation
import FirebaseDatabase.FIRDataSnapshot

typealias FIRUser = FirebaseAuth.User

class LoginViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	@IBOutlet weak var loginButton: UIButton!
	@IBAction func loginButtonTapped(_ sender: UIButton) {
		print("login Button Tapped")
		guard let authUI = FUIAuth.defaultAuthUI()
			else { return }
		authUI.delegate = self
		let authViewController = authUI.authViewController()
		present(authViewController, animated: true)
	}
	
}

extension LoginViewController: FUIAuthDelegate {
	
	func authUI(_ authUI: FUIAuth, didSignInWith user: FIRUser?, error: Error?) {
		if let error = error {
			assertionFailure("Error signing in: \(error.localizedDescription)")
		}
			UserService.show(forUID: (user?.uid)!) { (user) in
				if let user = user {
					// handle existing user
					User.setCurrent(user, writeToUserDefaults: true)
					
					let initialViewController = UIStoryboard.initialViewController(for: .main)
					self.view.window?.rootViewController = initialViewController
					self.view.window?.makeKeyAndVisible()
				} else {
					// handle new user
					self.performSegue(withIdentifier: Constants.Segue.toCreateUsername, sender: self)
				}
			}
		
		guard let user = user else { return }
		
		let userRef = Database.database().reference().child("users").child(user.uid)
		
		userRef.observeSingleEvent(of: .value, with: { [unowned self] (snapshot) in
			if let user = User(snapshot: snapshot) {
				User.setCurrent(user)
				
				let storyboard = UIStoryboard(name: "Main", bundle: .main)
				if let initialViewController = storyboard.instantiateInitialViewController() {
					self.view.window?.rootViewController = initialViewController
					self.view.window?.makeKeyAndVisible()
				}
			} else {
				self.performSegue(withIdentifier: "toCreateUsername", sender: self)
			}
		})
	}
}
