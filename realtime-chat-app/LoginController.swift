//
//  ViewController.swift
//  realtime-chat-app
//
//  Created by Tsang Ka Kui on 18/8/2016.
//  Copyright © 2016年 Tsang Ka Kui. All rights reserved.
//

import UIKit
import Firebase

class LoginController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(61, 91, 151)
        self.setupPorofileImageView()
        self.setupSegmentedControl()
        self.setupLoginForm()
        self.setupRegisterForm()
        self.setupButtons()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "chat.png")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 50
        imageView.layer.masksToBounds = true
        //imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(profileImageViewDidPressed)))
        return imageView
    }()
    
    lazy var segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["Login", "Register"])
        control.tintColor = UIColor.white
        control.selectedSegmentIndex = 0
        control.translatesAutoresizingMaskIntoConstraints = false
        control.addTarget(self, action: #selector(segmentedControlDidPressed), for: .valueChanged)
        return control
    }()
    
    lazy var loginForm: LoginForm = {
        let form = LoginForm()
        form.emailTextField.delegate = self
        form.passwordTextField.delegate = self
        form.translatesAutoresizingMaskIntoConstraints = false
        return form
    }()
    
    lazy var registerForm: RegisterForm = {
        let form = RegisterForm()
        form.nameTextField.delegate = self
        form.emailTextField.delegate = self
        form.passwordTextField.delegate = self
        form.isHidden = true
        form.translatesAutoresizingMaskIntoConstraints = false
        return form
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor(0, 138, 230)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Register", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor(0, 138, 230)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        return button
    }()
    
    func setupPorofileImageView() {
        view.addSubview(profileImageView)
        profileImageView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 30).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

    func setupSegmentedControl() {
        view.addSubview(segmentedControl)
        segmentedControl.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 30).isActive = true
        segmentedControl.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -32).isActive = true
        segmentedControl.heightAnchor.constraint(equalToConstant: 36).isActive = true
        segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func setupLoginForm() {
        view.addSubview(loginForm)
        loginForm.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 20).isActive = true
        loginForm.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -32).isActive = true
        loginForm.heightAnchor.constraint(equalToConstant: 180).isActive = true
        loginForm.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func setupRegisterForm() {
        view.addSubview(registerForm)
        registerForm.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 20).isActive = true
        registerForm.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -32).isActive = true
        registerForm.heightAnchor.constraint(equalToConstant: 180).isActive = true
        registerForm.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func setupButtons() {
        view.addSubview(loginButton)
        loginButton.topAnchor.constraint(equalTo: loginForm.bottomAnchor, constant: 20).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(registerButton)
        registerButton.topAnchor.constraint(equalTo: registerForm.bottomAnchor, constant: 20).isActive = true
        registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
     }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func segmentedControlDidPressed() {

        if segmentedControl.selectedSegmentIndex == 0 {
            loginForm.isHidden = false
            registerForm.isHidden = true
            loginButton.isHidden = false
            registerButton.isHidden = true
            profileImageView.isUserInteractionEnabled = false
        }
        
        if segmentedControl.selectedSegmentIndex == 1 {
            loginForm.isHidden = true
            registerForm.isHidden = false
            loginButton.isHidden = true
            registerButton.isHidden = false
            profileImageView.isUserInteractionEnabled = true
        }
    }
    
    func profileImageViewDidPressed() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info["UIImagePickerControllerEditedImage"] as? UIImage {
            profileImageView.image = image
        } else if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            profileImageView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func handleLogin() {
        
        guard let email = loginForm.emailTextField.text , email != "" else {
            print("Email is empty")
            return
        }
        
        guard let password = loginForm.passwordTextField.text , password != "" else {
            print("Password is empty")
            return
        }
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                print(error.debugDescription)
                return
            }
            
            let controller = NavigationController()
            
            self.present(controller, animated: true, completion: nil)
        })
    }
    
    func handleRegister() {
        
        guard let name = registerForm.nameTextField.text , name != "" else {
            print("Name is empty")
            return
        }
        
        guard let email = registerForm.emailTextField.text , email != "" else {
            print("Email is empty")
            return
        }
        
        guard let password = registerForm.passwordTextField.text , password != "" else {
            print("Password is empty")
            return
        }
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            
            if error != nil {
                print(error.debugDescription)
                return
            }
            
            self.uploadImage((user?.uid)!, name, email)
            
        })
        
    }
    
    func uploadImage(_ uid: String, _ name: String, _ email: String) {
        
        let imageName = NSUUID().uuidString
        
        let storageRef = FIRStorage.storage().reference().child("profile_images").child("\(imageName).png")
        
        if let uploadData = UIImagePNGRepresentation(profileImageView.image!) {
            
            storageRef.put(uploadData, metadata: nil, completion: { (metadata, error) in
                
                if error != nil {
                    print(error.debugDescription)
                    return
                }
                
                if let imageUrl = metadata?.downloadURL()?.absoluteString {
                    
                    self.createUserInfo(uid, name, email, imageUrl)
                    
                }
                
            })
            
        }
        
    }
    
    func createUserInfo(_ uid: String, _ name: String, _ email: String, _ imageUrl: String) {
        
        let ref = FIRDatabase.database().reference()
        
        let userRef = ref.child("users").child(uid)
        
        let value = ["name": name, "email": email, "imageUrl": imageUrl]
        
        userRef.updateChildValues(value, withCompletionBlock: { (error, ref) in
            
            if error != nil {
                print(error.debugDescription)
                return
            }
            
            let controller = NavigationController()
            
            self.present(controller, animated: true, completion: nil)
        })
    }
}

