//
//  SignupVC.swift
//  swapIt
//
//  Created by Valter Andre Machado on 1/24/20.
//  Copyright © 2020 Valter Andre Machado. All rights reserved.
//

import UIKit
import LBTATools
import Firebase

class SignupVC: UIViewController {
    let imageBackground = UIImage(named: "balance.jpg")
    
    var selectedImage: UIImage?
    
    lazy var profileImageViewPicker: UIImageView = {
        var iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(systemName: "person.crop.circle.fill")?.withTintColor(.rgb(red: 101, green: 183, blue: 180), renderingMode: .alwaysOriginal)
        iv.clipsToBounds = true
        //        iv.sizeToFit()
        iv.contentMode = .scaleAspectFill
        //        iv.backgroundColor = .red
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleSelectedProfileIV))
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(tapRecognizer)
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
    
    lazy var separatorThree: UIView = {
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
            txtFld.textAlignment = .right
            txtFld.attributedPlaceholder = placeholder
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
    
    lazy var usernameTxtFld: UITextField = {
        var txtFld = UITextField()
        txtFld.translatesAutoresizingMaskIntoConstraints = false
        //                txtFld.backgroundColor = .red
        if preferredLanguage == "ar" {
            let placeholder = NSAttributedString(string: "Username".localized("ar"), attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
            txtFld.attributedPlaceholder = placeholder
            txtFld.textAlignment = .right
        } else {
            let placeholder = NSAttributedString(string: "Username", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
            txtFld.attributedPlaceholder = placeholder
        }
        //        txtFld.textAlignment = .center
        txtFld.textColor = .black
        txtFld.autocorrectionType = .no
        txtFld.autocapitalizationType = .none
        
        return txtFld
    }()
    
    lazy var signupBtn: UIButton = {
        var btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .rgb(red: 101, green: 183, blue: 180)
        
        if preferredLanguage == "ar" {
            btn.setTitle("Sign Up".localized("ar"), for: .normal)
        } else {
            btn.setTitle("Sign Up", for: .normal)
        }
        
        btn.titleLabel?.font = .boldSystemFont(ofSize: 20)
        btn.layer.cornerRadius = 10
        btn.tintColor = .systemGray4
        btn.addTarget(self, action: #selector(signupBtnPressed), for: .touchUpInside)
        return btn
    }()
    
    lazy var haveAccLbl: UILabel = {
        var lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Already have an account?"
        //          lb.font = .boldSystemFont(ofSize: 50)
        lbl.textAlignment = .right
        lbl.textColor = .black
        //        lb.sizeToFit()
        //              lb.backgroundColor = .gray
        return lbl
    }()
    
    //    lazy var loginLinkBtn: UIButton = {
    //        var btn = UIButton(type: .system)
    //        btn.translatesAutoresizingMaskIntoConstraints = false
    //        //            btn.backgroundColor = .red
    //        btn.setTitle("Log In", for: .normal)
    //        btn.titleLabel?.textAlignment = .right
    //        btn.tintColor = .rgb(red: 101, green: 183, blue: 180)
    //
    //        //        btn.titleLabel?.font = .boldSystemFont(ofSize: 20)
    //        //        btn.layer.cornerRadius = 15
    //        btn.addTarget(self, action: #selector(loginLinkPressed), for: .touchUpInside)
    //        return btn
    //    }()
    
    //    lazy var closeViewBtn: UIButton = {
    //        var btn = UIButton(type: .system)
    //        btn.translatesAutoresizingMaskIntoConstraints = false
    //        //            btn.backgroundColor = .red
    //        let largeConfig = UIImage.SymbolConfiguration(textStyle: .largeTitle)
    //        btn.setPreferredSymbolConfiguration(largeConfig, forImageIn: .normal)
    //        btn.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
    //        btn.tintColor = .black
    //
    //        //            btn.titleLabel?.font = .systemFont(ofSize: 60, weight: .regular)
    //        btn.addTarget(self, action: #selector(closeViewBtnPressed), for: .touchUpInside)
    //        return btn
    //    }()
    
    lazy var usernameStackView: UIStackView = {
        var sv = UIStackView(arrangedSubviews: [usernameTxtFld, separatorOne])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.spacing = 0
        sv.distribution = .fillProportionally
        return sv
    }()
    
    lazy var emailStackView: UIStackView = {
        var sv = UIStackView(arrangedSubviews: [emailTxtFld, separatorTwo])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.spacing = 0
        sv.distribution = .fillProportionally
        return sv
    }()
    
    lazy var passwordStackView: UIStackView = {
        var sv = UIStackView(arrangedSubviews: [passwordTxtFld, separatorThree])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.spacing = 0
        sv.distribution = .fillProportionally
        return sv
    }()
    
    lazy var loginStackView: UIStackView = {
        var sv = UIStackView(arrangedSubviews: [usernameStackView, emailStackView, passwordStackView, signupBtn])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.spacing = 10
        sv.distribution = .equalSpacing
        return sv
    }()
    
    //    lazy var labelsStackView: UIStackView = {
    //        var sv = UIStackView(arrangedSubviews: [haveAccLbl, loginLinkBtn])
    //        sv.translatesAutoresizingMaskIntoConstraints = false
    //        sv.axis = .horizontal
    //        sv.spacing = 0
    //        sv.distribution = .equalSpacing
    //        //        sv.backgroundColor = .blue
    //
    //        return sv
    //    }()
    
    private var indicator: ProgressIndicator?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        // Setting up activity indicator
        indicator = ProgressIndicator(inview:self.view,loadingViewColor: UIColor.clear, indicatorColor: UIColor.black, msg: "")
        indicator?.isHidden = true
        // prevents modal view to be dismissed by gesture.
        //        self.isModalInPresentation = true
        signupBtn.isEnabled = false
        
        setupView()
        handleSignupBtnUX()
        //            assignbackground()
        //        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "balance.jpg")!)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        profileImageViewPicker.roundedImage()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // MARK: Selectors
    @objc func closeViewBtnPressed(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func loginLinkPressed(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func signupBtnPressed(){
        
        indicator?.isHidden = false
        view.endEditing(true)
        view.isUserInteractionEnabled = false
        // validate text fields
        signupBtn.setTitle("", for: .normal)
        indicator!.start()
        
        if selectedImage == nil
        {
            print("No Selected Image")
            if preferredLanguage == "ar" { // arabic
                
                let alertController = UIAlertController(title: "Missing Profile Photo.".localized("ar"), message: "Please choose a profile photo.".localized("ar"), preferredStyle: .alert)
                let tryAgainAction = UIAlertAction(title: "OK".localized("ar"), style: .cancel) { UIAlertAction in }
                // enable UX
                self.indicator!.stop()
                self.signupBtn.setTitle("Sign Up".localized("ar"), for: .normal)
                self.view.isUserInteractionEnabled = true
                self.signupBtn.isEnabled = true
                self.indicator?.isHidden = true
                // presenting alertController
                alertController.view.tintColor = .rgb(red: 101, green: 183, blue: 180)
                alertController.addAction(tryAgainAction)
                self.present(alertController, animated: true, completion: nil)
                
            } else  { // english
                
                let alertController = UIAlertController(title: "Missing Profile Photo.", message: "Please choose a profile photo.", preferredStyle: .alert)
                let tryAgainAction = UIAlertAction(title: "OK", style: .cancel) { UIAlertAction in }
                // enable UX
                self.indicator!.stop()
                self.signupBtn.setTitle("Sign Up", for: .normal)
                self.view.isUserInteractionEnabled = true
                self.signupBtn.isEnabled = true
                self.indicator?.isHidden = true
                // presenting alertController
                alertController.view.tintColor = .rgb(red: 101, green: 183, blue: 180)
                alertController.addAction(tryAgainAction)
                self.present(alertController, animated: true, completion: nil)
                
            } // end of preferredLanguage block
            
        }
        else
        {
            print("An image was selected")
            
            let error = validateFields()
            
            if error != nil {
                // can also check password validation
                print("Please fill in all fields.")
                if preferredLanguage == "ar" { // arabic
                    
                    let alertController = UIAlertController(title: "Please fill in all fields.".localized("ar"), message: "", preferredStyle: .alert)
                    let tryAgainAction = UIAlertAction(title: "OK".localized("ar"), style: .cancel) { UIAlertAction in }
                    // enable UX
                    self.indicator!.stop()
                    self.signupBtn.setTitle("Sign Up", for: .normal)
                    self.view.isUserInteractionEnabled = true
                    self.signupBtn.isEnabled = true
                    self.indicator?.isHidden = true
                    // presenting alertController
                    alertController.view.tintColor = .rgb(red: 101, green: 183, blue: 180)
                    alertController.addAction(tryAgainAction)
                    self.present(alertController, animated: true, completion: nil)
                    
                } else { // english
                    
                    let alertController = UIAlertController(title: "Please fill in all fields.", message: "", preferredStyle: .alert)
                    let tryAgainAction = UIAlertAction(title: "OK", style: .cancel) { UIAlertAction in }
                    // enable UX
                    self.indicator!.stop()
                    self.signupBtn.setTitle("Sign Up", for: .normal)
                    self.view.isUserInteractionEnabled = true
                    self.signupBtn.isEnabled = true
                    self.indicator?.isHidden = true
                    // presenting alertController
                    alertController.view.tintColor = .rgb(red: 101, green: 183, blue: 180)
                    alertController.addAction(tryAgainAction)
                    self.present(alertController, animated: true, completion: nil)
                    
                } // end of preferredLanguage block
               
            }
            else {
                
                Auth.auth().createUser(withEmail: emailTxtFld.text!, password: passwordTxtFld.text!) { authResult, error in
                    if error != nil  {
                        var errorReader = "\(error!.localizedDescription)"
                        
                        if preferredLanguage == "ar" { // arabic
                            
                            if errorReader == "There is no user record corresponding to this identifier. The user may have been deleted."
                            {   // handles Email input error
                                errorReader = "Incorrect Email"
                                
                                let alertController = UIAlertController(title: errorReader.localized("ar"), message: "The email you entered doesn't appear to belong to an account. Please check your email and try again.".localized("ar"), preferredStyle: .alert)
                                let tryAgainAction = UIAlertAction(title: "OK".localized("ar"), style: .cancel) { UIAlertAction in }
                                // enable UX
                                self.indicator!.stop()
                                self.signupBtn.setTitle("Sign Up".localized("ar"), for: .normal)
                                print("Couldn't Sign Up: " + error!.localizedDescription)
                                self.view.isUserInteractionEnabled = true
                                self.signupBtn.isEnabled = true
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
                                self.signupBtn.setTitle("Sign Up".localized("ar"), for: .normal)
                                print("Couldn't Sign Up: " + error!.localizedDescription)
                                self.view.isUserInteractionEnabled = true
                                self.signupBtn.isEnabled = true
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
                                self.signupBtn.setTitle("Sign Up".localized("ar"), for: .normal)
                                print("Couldn't Sign Up: " + error!.localizedDescription)
                                self.view.isUserInteractionEnabled = true
                                self.signupBtn.isEnabled = true
                                self.indicator?.isHidden = true
                                // presenting alertController
                                alertController.view.tintColor = .rgb(red: 101, green: 183, blue: 180)
                                alertController.addAction(tryAgainAction)
                                self.present(alertController, animated: true, completion: nil)
                                
                            }
//                            else if errorReader == "Too many unsuccessful login attempts. Please try again later." {
//                                // handles Too many unsuccessful login attempts error
//                                errorReader = "Forgot Password?"
//
//                                let alertController = UIAlertController(title: errorReader.localized("ar"), message: "You entered many times a wrong password. Do you want to reset your password?".localized("ar"), preferredStyle: .alert)
//                                let yesAction = UIAlertAction(title: "Yes".localized("ar"), style: .default) { UIAlertAction in
//                                    let forgotPwVC = ForgotPasswordVC()
//                                    self.present(forgotPwVC, animated: true, completion: nil)
//                                }
//
//                                let tryAgainAction = UIAlertAction(title: "No".localized("ar"), style: .cancel) { UIAlertAction in }
//                                // enable UX
//                                self.indicator!.stop()
//                                self.signupBtn.setTitle("Sign Up".localized("ar"), for: .normal)
//                                print("Couldn't Sign Up: " + error!.localizedDescription)
//                                self.view.isUserInteractionEnabled = true
//                                self.signupBtn.isEnabled = true
//                                self.indicator?.isHidden = true
//                                // presenting alertController
//                                alertController.view.tintColor = .rgb(red: 101, green: 183, blue: 180)
//                                alertController.addAction(yesAction)
//                                alertController.addAction(tryAgainAction)
//                                self.present(alertController, animated: true, completion: nil)
//                            }
                            
                            let alertController = UIAlertController(title: error!.localizedDescription.localized("ar"), message: "", preferredStyle: .alert)
                            let tryAgainAction = UIAlertAction(title: "OK".localized("ar"), style: .cancel) { UIAlertAction in }
                            // enable UX
                            self.indicator!.stop()
                            self.signupBtn.setTitle("Sign Up".localized("ar"), for: .normal)
                            print("Couldn't Sign Up: " + error!.localizedDescription)
                            self.view.isUserInteractionEnabled = true
                            self.signupBtn.isEnabled = true
                            self.indicator?.isHidden = true
                            // presenting alertController
                            alertController.view.tintColor = .rgb(red: 101, green: 183, blue: 180)
                            alertController.addAction(tryAgainAction)
                            self.present(alertController, animated: true, completion: nil)
                            
                            
                        }  else { // english
                            
                            if errorReader == "There is no user record corresponding to this identifier. The user may have been deleted."
                            {   // handles Email input error
                                errorReader = "Incorrect Email"
                                
                                let alertController = UIAlertController(title: errorReader, message: "The email you entered doesn't appear to belong to an account. Please check your email and try again.", preferredStyle: .alert)
                                let tryAgainAction = UIAlertAction(title: "OK", style: .cancel) { UIAlertAction in }
                                // enable UX
                                self.indicator!.stop()
                                self.signupBtn.setTitle("Sign Up", for: .normal)
                                print("Couldn't Sign Up: " + error!.localizedDescription)
                                self.view.isUserInteractionEnabled = true
                                self.signupBtn.isEnabled = true
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
                                self.signupBtn.setTitle("Sign Up", for: .normal)
                                print("Couldn't Sign Up: " + error!.localizedDescription)
                                self.view.isUserInteractionEnabled = true
                                self.signupBtn.isEnabled = true
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
                                self.signupBtn.setTitle("Sign Up", for: .normal)
                                print("Couldn't Sign Up: " + error!.localizedDescription)
                                self.view.isUserInteractionEnabled = true
                                self.signupBtn.isEnabled = true
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
                                self.signupBtn.setTitle("Sign Up", for: .normal)
                                print("Couldn't Sign Up: " + error!.localizedDescription)
                                self.view.isUserInteractionEnabled = true
                                self.signupBtn.isEnabled = true
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
                            self.signupBtn.setTitle("Sign Up", for: .normal)
                            print("Couldn't Sign Up: " + error!.localizedDescription)
                            self.view.isUserInteractionEnabled = true
                            self.signupBtn.isEnabled = true
                            self.indicator?.isHidden = true
                            // presenting alertController
                            alertController.view.tintColor = .rgb(red: 101, green: 183, blue: 180)
                            alertController.addAction(tryAgainAction)
                            self.present(alertController, animated: true, completion: nil)
                            
                            
                        } // end of preferredLanguage block
                        
                        
                    }
                    else {
                        
                        let uid = authResult?.user.uid
                        
                        //                    print(authResult)
                        let storageRef = Storage.storage().reference(forURL: "gs://guidetech101.appspot.com").child("profile_image").child(uid!)
                        //
                        let metadata = StorageMetadata()
                        metadata.contentType = "image/jpg"
                        
                        guard let imageData = self.selectedImage?.jpegData(compressionQuality: 0.4) else { return }
                        
                        storageRef.putData(imageData, metadata: metadata) { (storageMetadata, error) in
                            if error != nil {
                                print(error!.localizedDescription)
                                return
                            } else {
                                // MARK: - Storing profileImage, username and email in the firebase (Auth and Storage)
                                storageRef.downloadURL { (url, error) in
                                    if let profileImageUrl = url?.absoluteString {
                                        
                                        // User was created successfully, now store username and email to the firebaseDB
                                        let db = Database.database().reference()
                                        let useRef = db.child("users")
                                        let newUserRef = useRef.child(uid!)
                                        newUserRef.setValue(["username": self.usernameTxtFld.text!, "email": self.emailTxtFld.text!, "password": self.passwordTxtFld.text!, "profileImageUrl": profileImageUrl])
                                        
                                        self.checkUserIsLoggedIn()
                                        self.dismiss(animated: true, completion: nil)
                                        print("signup")
                                    }
                                }
                            }
                        }
                        
                    }
                }
                
            }
            
        }
        
    } // end of sign up btn func handler
    
    // MARK: - Functions
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
       
    
    fileprivate func handleSignupBtnUX(){
        usernameTxtFld.addTarget(self, action: #selector(textFldDidChange), for: .editingChanged)
        emailTxtFld.addTarget(self, action: #selector(textFldDidChange), for: .editingChanged)
        passwordTxtFld.addTarget(self, action: #selector(textFldDidChange), for: .editingChanged)
    }
    
    @objc fileprivate func textFldDidChange(){
        
        guard let username = usernameTxtFld.text, !username.isEmpty, let email = emailTxtFld.text, !email.isEmpty, let password = passwordTxtFld.text, !password.isEmpty else {
            
            self.signupBtn.setTitleColor(.systemGray4, for: .normal)
            self.signupBtn.isEnabled = false
            
            return
        }
        
        signupBtn.setTitleColor(.white, for: .normal)
        signupBtn.isEnabled = true
    }
    
    fileprivate func validateFields() -> String? {
        // check that all fields are filled in
        if usernameTxtFld.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailTxtFld.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTxtFld.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields."
        }
        
        //        // check if the password is secure
        //        let cleanedPassword = passwordTxtFld.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        //
        //        if Utilities.isPasswordValid(cleanedPassword) == false {
        //            // password isn't secure enough
        //            return "Please make sure your password is at least 8 characters, contains a special character and a number."
        //        }
        return nil
    }
    
  
    @objc func handleSelectedProfileIV() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
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
    
    fileprivate func setupView(){
        [profileImageViewPicker, loginStackView, indicator!].forEach({view.addSubview($0)})
        
        let backButton = UIBarButtonItem()
        
        if preferredLanguage == "ar" {
            backButton.title = "Log In".localized("ar")
            navigationItem.title = "Create your account".localized("ar")
        } else {
            backButton.title = "Log In"
            navigationItem.title = "Create your account"
        }
//        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        navigationController?.navigationBar.tintColor = .rgb(red: 101, green: 183, blue: 180)
        
        // setting up activity indicator
        if preferredLanguage == "ar"{
            indicator?.anchor(top: signupBtn.topAnchor, leading: view.leadingAnchor, bottom: signupBtn.bottomAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: view.frame.width/2 - 20))
        } else {
            indicator?.anchor(top: signupBtn.topAnchor, leading: view.leadingAnchor, bottom: signupBtn.bottomAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 0, left: view.frame.width/2 - 20, bottom: 0, right: 0))
        }
        
        /// stackview containers:
        profileImageViewPicker.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: view.frame.height/15, left: view.frame.width/2 - 50, bottom: 0, right: 0), size: CGSize.init(width: 100, height: 100))
        
        loginStackView.anchor(top: profileImageViewPicker.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets.init(top: 10, left: 40, bottom: 0, right: 40))
        
        //        labelsStackView.anchor(top: nil, leading: loginStackView.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: loginStackView.trailingAnchor, padding: UIEdgeInsets.init(top: 0, left: view.frame.width/6.7, bottom: 10, right: view.frame.width/6.7)
        //            //                view.frame.width/8.8
        //        )
        
        usernameStackView.withHeight(45)
        emailStackView.withHeight(45)
        passwordStackView.withHeight(45)
        separatorOne.withHeight(1)
        separatorTwo.withHeight(1)
        separatorThree.withHeight(1)
        signupBtn.withHeight(45)
        
    }
    
}

extension SignupVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectedImage = image
            profileImageViewPicker.image = image
            
            // enables the signup button only when user picks a profile image
//            signupBtn.setTitleColor(.white, for: .normal)
//            signupBtn.isEnabled = true
            
        }
        
        print("did pick")
        dismiss(animated: true, completion: nil)
    }
}
