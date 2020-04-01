//
//  ViewController.swift
//  swapIt
//
//  Created by Valter Andre Machado on 1/23/20.
//  Copyright © 2020 Valter Andre Machado. All rights reserved.
//

import UIKit
import LBTATools
import Firebase

class LoginVC: UIViewController {
    
    let langsArray = ["en", "ar"]
    fileprivate var defaults = UserDefaults.standard
    
    let imageBackground = UIImage(named: "balance.jpg")
    let logo = UIImage(named: "guidetech-06.png")

    lazy var logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
//        iv.backgroundColor = .blue
        iv.image = logo
        iv.contentMode = .scaleAspectFit
        
        return iv
    }()
  
    lazy var separatorOne: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .rgb(red: 101, green: 183, blue: 180)
        return view
    }()
    
    lazy var separatorTwo: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .rgb(red: 101, green: 183, blue: 180)

        return view
    }()
    
    lazy var emailTxtFld: UITextField = {
        var txtFld = UITextField()
        txtFld.translatesAutoresizingMaskIntoConstraints = false
//        txtFld.backgroundColor = .blue
        
        if preferredLanguage == "ar" {
            let placeholder = NSAttributedString(string: "Email".localized("ar"), attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
            txtFld.attributedPlaceholder = placeholder
            txtFld.textAlignment = .right
        } else {
             let placeholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
            txtFld.attributedPlaceholder = placeholder
        }
        
//        txtFld.placeholder = "Email"
//        txtFld.borderStyle = .roundedRect
//        txtFld.textAlignment = .center
        txtFld.textColor = .black
        txtFld.autocorrectionType = .no
        txtFld.autocapitalizationType = .none
        
        return txtFld
    }()
    
    lazy var passwordTxtFld: UITextField = {
        var txtFld = UITextField()
        txtFld.translatesAutoresizingMaskIntoConstraints = false
//        txtFld.backgroundColor = .red
//        txtFld.borderStyle = .roundedRect
        if preferredLanguage == "ar" {
            let placeholder = NSAttributedString(string: "Password".localized("ar"), attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
            txtFld.attributedPlaceholder = placeholder
        } else {
            let placeholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
            txtFld.attributedPlaceholder = placeholder
        }
        
//        txtFld.textAlignment = .center
        txtFld.textColor = .black
        txtFld.isSecureTextEntry = true
        txtFld.autocorrectionType = .no
        txtFld.autocapitalizationType = .none
        
        return txtFld
    }()
    
    lazy var loginBtn: UIButton = {
        var btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .rgb(red: 101, green: 183, blue: 180)
        
        if preferredLanguage == "ar" {
            btn.setTitle("Log In".localized("ar"), for: .normal)
        } else {
            btn.setTitle("Log In", for: .normal)
        }

        btn.titleLabel?.font = .boldSystemFont(ofSize: 20)
        btn.layer.cornerRadius = 10
        btn.tintColor = .systemGray4
        btn.addTarget(self, action: #selector(loginBtnPressed), for: .touchUpInside)
        return btn
    }()
    
    lazy var forgotPwBtn: UIButton = {
        var btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
//        btn.backgroundColor = .yellow
        
        if preferredLanguage == "ar" {
            btn.setTitle("Forgot?".localized("ar"), for: .normal)
        } else {
            btn.setTitle("Forgot?", for: .normal)
        }

        btn.titleLabel?.font = .boldSystemFont(ofSize: 16)
//        btn.layer.cornerRadius = 10
        btn.titleLabel?.textAlignment = .right
        btn.tintColor = .rgb(red: 101, green: 183, blue: 180)
        btn.addTarget(self, action: #selector(forgotPWBtnPressed), for: .touchUpInside)
        return btn
    }()
    
    lazy var noAccLbl: UILabel = {
        var lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        if preferredLanguage == "ar" {
            lbl.text = "Don't have an account?".localized("ar")
        } else {
            lbl.text = "Don't have an account?"
        }
        //          lb.font = .boldSystemFont(ofSize: 50)
        lbl.textAlignment = .right
        lbl.textColor = .black
        
        
        //        lb.sizeToFit()
        //          lb.backgroundColor = .gray
        return lbl
    }()
    
    lazy var signupLinkBtn: UIButton = {
        var btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
//        btn.backgroundColor = .red
        if preferredLanguage == "ar" {
            btn.setTitle("Sign Up".localized("ar"), for: .normal)
        } else {
            btn.setTitle("Sign Up", for: .normal)
        }

        btn.titleLabel?.textAlignment = .right
        btn.tintColor = .rgb(red: 101, green: 183, blue: 180)

//        btn.titleLabel?.font = .boldSystemFont(ofSize: 20)
//        btn.layer.cornerRadius = 15
        btn.addTarget(self, action: #selector(signupLinkPressed), for: .touchUpInside)
        return btn
    }()
    
    lazy var emailStackView: UIStackView = {
        var sv = UIStackView(arrangedSubviews: [emailTxtFld, separatorOne])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.spacing = 0
        sv.distribution = .fillProportionally
        return sv
    }()
    
    lazy var pwAndForgotStackView: UIStackView = {
        var sv = UIStackView(arrangedSubviews: [passwordTxtFld, forgotPwBtn])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.spacing = 0
        sv.distribution = .fillProportionally
        return sv
    }()
    
    lazy var passwordStackView: UIStackView = {
        var sv = UIStackView(arrangedSubviews: [pwAndForgotStackView, separatorTwo])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.spacing = 0
        sv.distribution = .fillProportionally
        return sv
    }()
    
    lazy var loginStackView: UIStackView = {
        var sv = UIStackView(arrangedSubviews: [emailStackView, passwordStackView, loginBtn])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.spacing = 10
        sv.distribution = .equalSpacing
        return sv
    }()
    
    lazy var labelsStackView: UIStackView = {
        var sv = UIStackView(arrangedSubviews: [noAccLbl, signupLinkBtn])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.spacing = 3
        sv.distribution = .fillProportionally
        sv.alignment = .center
//        sv.backgroundColor = .blue

        return sv
    }()
    
    private var indicator: ProgressIndicator?

    lazy var popUpWindow: PopUpWindow = {
        let view = PopUpWindow()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.delegate = self
        return view
    }()
    
    let visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .light)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    // MARK: - Inits
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupKeyboardListener()
        setupActivityIndicator()
        
        loginBtn.isEnabled = false
        
        setupView()
        checkFirstTimeUser()
        handleLoginBtnUX()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
  @objc func keyboardWillShow(notification: NSNotification) {
        if view.bounds.height <= 667{
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                if self.view.frame.origin.y == 0 {
                    self.view.frame.origin.y -= (keyboardSize.height - keyboardSize.height) + 70
                }
            }
        } else {
            print("bigger size screen")
        }
   }

   @objc func keyboardWillHide(notification: NSNotification) {
        if view.bounds.height <= 667{
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y = 0
            }
        } else {
            print("bigger size screen")
        }
   }
    
    @objc func signupLinkPressed(){
        view.endEditing(true)
        let signupVC = SignupVC()
//        self.present(signupVC, animated: true)
        signupVC.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(signupVC, animated: true)
    }
    
    @objc func loginBtnPressed(){
        indicator?.isHidden = false
        view.endEditing(true)
        view.isUserInteractionEnabled = false
        // validate text fields
        loginBtn.setTitle("", for: .normal)
        indicator!.start()

        // created cleaned version of textfield
        let email = emailTxtFld.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTxtFld.text?.trimmingCharacters(in: .whitespacesAndNewlines)

        // signin the user
        Auth.auth().signIn(withEmail: email!, password: password!) { (result, error) in
            
            if error != nil {
                
                var errorReader = "\(error!.localizedDescription)"
                
                if preferredLanguage == "ar" { // arabic
                    
                    if errorReader == "There is no user record corresponding to this identifier. The user may have been deleted."
                    {   // handles Email input error
                        errorReader = "Incorrect Email"
                        
                        let alertController = UIAlertController(title: errorReader.localized("ar"), message: "The email you entered doesn't appear to belong to an account. Please check your email and try again.".localized("ar"), preferredStyle: .alert)
                        let tryAgainAction = UIAlertAction(title: "OK".localized("ar"), style: .cancel) { UIAlertAction in }
                        // enable UX
                        self.indicator!.stop()
                        self.loginBtn.setTitle("Log In".localized("ar"), for: .normal)
                        print("Couldn't sign in: " + error!.localizedDescription)
                        self.view.isUserInteractionEnabled = true
                        self.loginBtn.isEnabled = true
                        self.indicator?.isHidden = true
                        // presenting alertController
                        alertController.view.tintColor = .rgb(red: 101, green: 183, blue: 180)
                        alertController.addAction(tryAgainAction)
                        self.present(alertController, animated: true, completion: nil)
                        
                    } else if errorReader == "The password is invalid or the user does not have a password." {
                        // handles password input error
                        errorReader = "Incorrect Password"
                        
                        let alertController = UIAlertController(title: errorReader.localized("ar"), message: "The password you entered is incorrect. Please try again.".localized("ar"), preferredStyle: .alert)
                        let tryAgainAction = UIAlertAction(title: "OK".localized("ar"), style: .cancel) { UIAlertAction in }
                        // enable UX
                        self.indicator!.stop()
                        self.loginBtn.setTitle("Log In".localized("ar"), for: .normal)
                        print("Couldn't sign in: " + error!.localizedDescription)
                        self.view.isUserInteractionEnabled = true
                        self.loginBtn.isEnabled = true
                        self.indicator?.isHidden = true
                        // presenting alertController
                        alertController.view.tintColor = .rgb(red: 101, green: 183, blue: 180)
                        alertController.addAction(tryAgainAction)
                        self.present(alertController, animated: true, completion: nil)
                        
                    }  else if errorReader == "Network error (such as timeout, interrupted connection or unreachable host) has occurred." {
                        // handles time out error
                        errorReader = "Connection Issue"
                        
                        let alertController = UIAlertController(title: errorReader.localized("ar"), message: "We are having problem to connect with your account. Please try again.".localized("ar"), preferredStyle: .alert)
                        let tryAgainAction = UIAlertAction(title: "OK".localized("ar"), style: .cancel) { UIAlertAction in }
                        // enable UX
                        self.indicator!.stop()
                        self.loginBtn.setTitle("Log In".localized("ar"), for: .normal)
                        print("Couldn't sign in: " + error!.localizedDescription)
                        self.view.isUserInteractionEnabled = true
                        self.loginBtn.isEnabled = true
                        self.indicator?.isHidden = true
                        // presenting alertController
                        alertController.view.tintColor = .rgb(red: 101, green: 183, blue: 180)
                        alertController.addAction(tryAgainAction)
                        self.present(alertController, animated: true, completion: nil)
                        
                    } else if errorReader == "Too many unsuccessful login attempts. Please try again later." {
                        // handles Too many unsuccessful login attempts error
                        errorReader = "Forgot Password?"
                        
                        let alertController = UIAlertController(title: errorReader.localized("ar"), message: "You entered many times a wrong password. Do you want to reset your password?".localized("ar"), preferredStyle: .alert)
                        let yesAction = UIAlertAction(title: "Yes".localized("ar"), style: .default) { UIAlertAction in
                            let forgotPwVC = ForgotPasswordVC()
                            self.present(forgotPwVC, animated: true, completion: nil)
                        }
                        
                        let tryAgainAction = UIAlertAction(title: "No".localized("ar"), style: .cancel) { UIAlertAction in }
                        // enable UX
                        self.indicator!.stop()
                        self.loginBtn.setTitle("Log In".localized("ar"), for: .normal)
                        print("Couldn't sign in: " + error!.localizedDescription)
                        self.view.isUserInteractionEnabled = true
                        self.loginBtn.isEnabled = true
                        self.indicator?.isHidden = true
                        // presenting alertController
                        alertController.view.tintColor = .rgb(red: 101, green: 183, blue: 180)
                        alertController.addAction(yesAction)
                        alertController.addAction(tryAgainAction)
                        self.present(alertController, animated: true, completion: nil)
                    }
                    
                    let alertController = UIAlertController(title: error!.localizedDescription.localized("ar"), message: "", preferredStyle: .alert)
                    let tryAgainAction = UIAlertAction(title: "OK".localized("ar"), style: .cancel) { UIAlertAction in }
                    // enable UX
                    self.indicator!.stop()
                    self.loginBtn.setTitle("Log In".localized("ar"), for: .normal)
                    print("Couldn't sign in: " + error!.localizedDescription)
                    self.view.isUserInteractionEnabled = true
                    self.loginBtn.isEnabled = true
                    self.indicator?.isHidden = true
                    // presenting alertController
                    alertController.view.tintColor = .rgb(red: 101, green: 183, blue: 180)
                    alertController.addAction(tryAgainAction)
                    self.present(alertController, animated: true, completion: nil)
                    
                } else { // english
                    
                    if errorReader == "There is no user record corresponding to this identifier. The user may have been deleted."
                    {   // handles Email input error
                        errorReader = "Incorrect Email"
                        
                        let alertController = UIAlertController(title: errorReader, message: "The email you entered doesn't appear to belong to an account. Please check your email and try again.", preferredStyle: .alert)
                        let tryAgainAction = UIAlertAction(title: "OK", style: .cancel) { UIAlertAction in }
                        // enable UX
                        self.indicator!.stop()
                        self.loginBtn.setTitle("Log In", for: .normal)
                        print("Couldn't sign in: " + error!.localizedDescription)
                        self.view.isUserInteractionEnabled = true
                        self.loginBtn.isEnabled = true
                        self.indicator?.isHidden = true
                        // presenting alertController
                        alertController.view.tintColor = .rgb(red: 101, green: 183, blue: 180)
                        alertController.addAction(tryAgainAction)
                        self.present(alertController, animated: true, completion: nil)
                        
                    } else if errorReader == "The password is invalid or the user does not have a password." {
                        // handles password input error
                        errorReader = "Incorrect Password"
                        
                        let alertController = UIAlertController(title: errorReader, message: "The password you entered is incorrect. Please try again.", preferredStyle: .alert)
                        let tryAgainAction = UIAlertAction(title: "OK", style: .cancel) { UIAlertAction in }
                        // enable UX
                        self.indicator!.stop()
                        self.loginBtn.setTitle("Log In", for: .normal)
                        print("Couldn't sign in: " + error!.localizedDescription)
                        self.view.isUserInteractionEnabled = true
                        self.loginBtn.isEnabled = true
                        self.indicator?.isHidden = true
                        // presenting alertController
                        alertController.view.tintColor = .rgb(red: 101, green: 183, blue: 180)
                        alertController.addAction(tryAgainAction)
                        self.present(alertController, animated: true, completion: nil)
                        
                    }  else if errorReader == "Network error (such as timeout, interrupted connection or unreachable host) has occurred." {
                        // handles time out error
                        errorReader = "Connection Issue"
                        
                        let alertController = UIAlertController(title: errorReader, message: "We are having problem to connect with our server. Please try again.", preferredStyle: .alert)
                        let tryAgainAction = UIAlertAction(title: "OK", style: .cancel) { UIAlertAction in }
                        // enable UX
                        self.indicator!.stop()
                        self.loginBtn.setTitle("Log In", for: .normal)
                        print("Couldn't sign in: " + error!.localizedDescription)
                        self.view.isUserInteractionEnabled = true
                        self.loginBtn.isEnabled = true
                        self.indicator?.isHidden = true
                        // presenting alertController
                        alertController.view.tintColor = .rgb(red: 101, green: 183, blue: 180)
                        alertController.addAction(tryAgainAction)
                        self.present(alertController, animated: true, completion: nil)
                        
                    } else if errorReader == "Too many unsuccessful login attempts. Please try again later." {
                        // handles Too many unsuccessful login attempts error
                        errorReader = "Forgot Password?"
                        
                        let alertController = UIAlertController(title: errorReader, message: "You entered many times a wrong password. Do you want to reset your password?.", preferredStyle: .alert)
                        let yesAction = UIAlertAction(title: "Yes", style: .default) { UIAlertAction in
                            let forgotPwVC = ForgotPasswordVC()
                            self.present(forgotPwVC, animated: true, completion: nil)
                    }
                        
                        let tryAgainAction = UIAlertAction(title: "No", style: .cancel) { UIAlertAction in }
                        // enable UX
                        self.indicator!.stop()
                        self.loginBtn.setTitle("Log In", for: .normal)
                        print("Couldn't sign in: " + error!.localizedDescription)
                        self.view.isUserInteractionEnabled = true
                        self.loginBtn.isEnabled = true
                        self.indicator?.isHidden = true
                        // presenting alertController
                        alertController.view.tintColor = .rgb(red: 101, green: 183, blue: 180)
                        alertController.addAction(yesAction)
                        alertController.addAction(tryAgainAction)
                        self.present(alertController, animated: true, completion: nil)
                    }
                    
                    let alertController = UIAlertController(title: error!.localizedDescription, message: "", preferredStyle: .alert)
                    let tryAgainAction = UIAlertAction(title: "OK", style: .cancel) { UIAlertAction in }
                    // enable UX
                    self.indicator!.stop()
                    self.loginBtn.setTitle("Log In", for: .normal)
                    print("Couldn't sign in: " + error!.localizedDescription)
                    self.view.isUserInteractionEnabled = true
                    self.loginBtn.isEnabled = true
                    self.indicator?.isHidden = true
                    // presenting alertController
                    alertController.view.tintColor = .rgb(red: 101, green: 183, blue: 180)
                    alertController.addAction(tryAgainAction)
                    self.present(alertController, animated: true, completion: nil)
                    
                } // end of preferredLanguage block
            }
            else
            {
                if preferredLanguage == "ar" { // arabic
                    print("signed in successfully")
                    self.indicator!.stop()
                    self.loginBtn.setTitle("Log In".localized("ar"), for: .normal)
                    self.view.isUserInteractionEnabled = true
                    self.indicator?.isHidden = true
                    //                self.loginBtn.isEnabled = true
                    self.checkUserIsLoggedIn()
                    self.dismiss(animated: true, completion: nil)
                } else { // english
                    print("signed in successfully")
                    self.indicator!.stop()
                    self.loginBtn.setTitle("Log In", for: .normal)
                    self.view.isUserInteractionEnabled = true
                    self.indicator?.isHidden = true
                    //                self.loginBtn.isEnabled = true
                    self.checkUserIsLoggedIn()
                    self.dismiss(animated: true, completion: nil)
                }
            } // end of error block
        }
    }
    
    fileprivate func checkUserIsLoggedIn(){ // if user just logged in fetch profile image and username.
        if Auth.auth().currentUser == nil {
            print("User is not logged in.")
        }
        else
        {
            let uid = Auth.auth().currentUser?.uid
            let db = Database.database().reference().child("users").child(uid!)
            db.observeSingleEvent(of: .value) { (snapshot) in
                // print(snapshot)
                DispatchQueue.main.async {
                    if let dict = snapshot.value as? [String: AnyObject] {
                        userName.text = dict["username"] as? String
                        let profileUrl = dict["profileImageUrl"] as! String
                        
                        let storageRef = Storage.storage().reference(forURL: profileUrl)
                        storageRef.downloadURL{ (url, error) in
                            do {
                                guard let url = url else { return }
                                let data = try Data(contentsOf: url)
                                let image = UIImage(data: data)
                                profileImageView.image = image
                            } catch {
                                print("no image: " + error.localizedDescription)
                            }
                            
                        }
                    }
                }
                
            }
            
        }
    }
    
    @objc func forgotPWBtnPressed(){
        view.endEditing(true)
        let forgotPwVC = ForgotPasswordVC()
        present(forgotPwVC, animated: true, completion: nil)
    }
    
    // MARK: - Functions
    func handleShowPopUp() {
        view.addSubview(popUpWindow)
        popUpWindow.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, size: CGSize(width: 0, height: 250))
        
        //        popUpWindow.showSuccessMessage = success
        //        success = !success
        
        popUpWindow.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        popUpWindow.alpha = 0
        
        UIView.animate(withDuration: 0.5) {
            self.visualEffectView.alpha = 1
            self.popUpWindow.alpha = 4
            self.popUpWindow.transform = CGAffineTransform.identity
        }
    }
    
    fileprivate func handleLoginBtnUX(){
        emailTxtFld.addTarget(self, action: #selector(textFldDidChange), for: .editingChanged)
        passwordTxtFld.addTarget(self, action: #selector(textFldDidChange), for: .editingChanged)
    }
    
    @objc fileprivate func textFldDidChange(){
        guard let email = emailTxtFld.text, !email.isEmpty, let password = passwordTxtFld.text, !password.isEmpty else {
            self.loginBtn.setTitleColor(.systemGray4, for: .normal)
            self.loginBtn.isEnabled = false
            return
        }
        
        loginBtn.setTitleColor(.white, for: .normal)
        loginBtn.isEnabled = true
    }
    
    fileprivate func assignbackground(){
        let background = UIImage(named: "AbstractDark.jpg")
        
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
    
    fileprivate func setupKeyboardListener(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    fileprivate func setupActivityIndicator(){
        // Setting up activity indicator
        indicator = ProgressIndicator(inview:self.view,loadingViewColor: UIColor.clear, indicatorColor: UIColor.black, msg: "")
        indicator?.isHidden = true
    }
    
    fileprivate func checkFirstTimeUser(){
        // MARK: Shows the view when user open it for the first time
        if defaults.object(forKey: "isFirstTime") == nil {
            defaults.set("No", forKey:"isFirstTime")
            defaults.synchronize()
            handleShowPopUp()
        }
        
    }
    
    fileprivate func setupView(){
        [ logoImageView, loginStackView, labelsStackView, indicator!, visualEffectView].forEach({view.addSubview($0)})
        
        // blur the screen while showing lang selection view
        visualEffectView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        visualEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        visualEffectView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        visualEffectView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        visualEffectView.alpha = 0
        
        // setting up activity indicator
        if preferredLanguage == "ar" {
            indicator?.anchor(top: loginBtn.topAnchor, leading: view.leadingAnchor, bottom: loginBtn.bottomAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: view.frame.width/2 - 20))
        } else {
            indicator?.anchor(top: loginBtn.topAnchor, leading: view.leadingAnchor, bottom: loginBtn.bottomAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 0, left: view.frame.width/2 - 20, bottom: 0, right: 0))
        }
        
         logoImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: view.frame.height/15, left: view.frame.width/2 - 80, bottom: 0, right: 0), size: CGSize.init(width: 160, height: 160))
                
        loginStackView.anchor(top: logoImageView.safeAreaLayoutGuide.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets.init(top: 10, left: 40, bottom: 0, right: 40))
        
    
        if view.bounds.width < 414{
            labelsStackView.anchor(top: loginStackView.bottomAnchor, leading: loginStackView.leadingAnchor, bottom: nil, trailing: loginStackView.trailingAnchor, padding: UIEdgeInsets.init(top: 15, left: view.frame.width/16.5, bottom: 0, right: view.frame.width/16.5)
                //            view.frame.width/8.4
            )
        }
        else {
            labelsStackView.anchor(top: loginStackView.bottomAnchor, leading: loginStackView.leadingAnchor, bottom: nil, trailing: loginStackView.trailingAnchor, padding: UIEdgeInsets.init(top: 15, left: view.frame.width/8.5, bottom: 0, right: view.frame.width/8.5)
                //            view.frame.width/8.4
            )
        }
        
        emailStackView.withHeight(45)
        passwordStackView.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, size: CGSize.init(width: view.frame.width - 80, height: 45))
        separatorOne.withHeight(1)
        separatorTwo.withHeight(1)
        loginBtn.withHeight(45)
        forgotPwBtn.withWidth(60)

        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.hideNavBarSeperator()
    }

}


extension LoginVC: PopUpDelegate {
    
    func handleEnglishBtnDismissal(){
        
        UIView.animate(withDuration: 0.5, animations: {
            self.popUpWindow.alpha = 0
            self.popUpWindow.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }) { (_) in
            self.popUpWindow.removeFromSuperview()
            print("Did remove pop up window..")
        }
        
        let alertController = UIAlertController(title: "Language", message: "We will close your app to change language completely,  please reopen your app after so.", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .cancel) { UIAlertAction in
            print("OK Pressed 2")
            
//            UIView.animate(withDuration: 0.3, animations: {
//                self.visualEffectView.alpha = 0
//            }) { (_) in
                print("Change App Lang to English")
                let arr = NSArray(objects: self.langsArray[0])
                self.defaults.set(arr, forKey: "AppleLanguages")
                exit(0)
//            }
        }
        
        alertController.view.tintColor = .rgb(red: 101, green: 183, blue: 180)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func handleArabicBtnDismissal(){
        
        UIView.animate(withDuration: 0.5, animations: {
            self.popUpWindow.alpha = 0
            self.popUpWindow.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }) { (_) in
            self.popUpWindow.removeFromSuperview()
            print("Did remove pop up window..")
        }
        
        let alertController = UIAlertController(title: "Language", message: "We will close your app to change language completely,  please reopen your app after so.", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .cancel) { UIAlertAction in
            print("OK Pressed 2")
            
//            UIView.animate(withDuration: 0.3, animations: {
//                self.visualEffectView.alpha = 0
//            }) { (_) in
                print("Change App Lang to Arabic")
                
                let arr = NSArray(objects: self.langsArray[1])
                self.defaults.set(arr, forKey: "AppleLanguages")
                exit(0)
//            }
        }
        
        alertController.view.tintColor = .rgb(red: 101, green: 183, blue: 180)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
}
