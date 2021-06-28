//
//  SignupViewController.swift
//  LoginProject
//
//  Created by Gadgetzone on 27/06/21.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth
import AVKit

class SignupViewController: UIViewController {
    
    @IBOutlet weak var firstnameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    var video: AVPlayer?
    var videoLayer: AVPlayerLayer?
    
    let homeViewController = "Home"
    
    override func viewWillAppear(_ animated: Bool) {
        setupVideo()
    }
    
    func setupVideo() {
        
        let path = Bundle.main.path(forResource: "loginBackgroundVideo", ofType: "mp4")
        guard path != nil else { return }
        
        let url = URL(fileURLWithPath: path!)
        
        let item = AVPlayerItem(url: url)
        
        video = AVPlayer(playerItem: item)
        
        videoLayer = AVPlayerLayer(player: video!)
        
        videoLayer?.frame = CGRect(x: -self.view.frame.size.width*1.5, y: 0, width: self.view.frame.size.width*4, height: self.view.frame.size.height)
        
        view.layer.insertSublayer(videoLayer!, at: 0)
        
        video?.playImmediately(atRate: 0.5)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideError()
    }
    
    func hideError() {
        
        errorLabel.alpha = 0
    }
    
    func validateFields() -> String? {
        
        if firstnameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastnameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            usernameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)  == "" {
            return "Please fill in the Fields"
        }
        
        let validPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if Checker.isPasswordValid(validPassword) == false {
            return "Your Password is not secure enough!!"
        }
        
        return nil
    }
    
    func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func navigateToHome() {
        let homeviewcontroller = storyboard?.instantiateViewController(identifier: homeViewController)
        view.window?.rootViewController = homeviewcontroller
        view.window?.makeKeyAndVisible()
    }
    
    @IBAction func signupButtonTapped(_ sender: Any) {
        
        let error = validateFields()
            
        if error !=  nil {
            
            showError(error!)
        } else {
            
            let firstname = firstnameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastname = lastnameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let username = usernameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().createUser(withEmail: username , password: password) { (result, problem) in
                if problem != nil {
                    
                    self.showError("Error Creating User")
                } else {
                    
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: ["firstname":firstname, "lastname":lastname, "uid":result!.user.uid]) { (error) in
                        if error != nil {
                            self.showError("Error Adding Data To Firsbase!")
                        }
                    }
                    
                    self.navigateToHome()
                }
            }
        }
    }
}
