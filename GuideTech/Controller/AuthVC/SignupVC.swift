//
//  SignupVC.swift
//  swapIt
//
//  Created by Valter Andre Machado on 1/24/20.
//  Copyright © 2020 Valter Andre Machado. All rights reserved.
//

import UIKit
import LBTATools

class SignupVC: UIViewController {
    let imageBackground = UIImage(named: "balance.jpg")
        var imageView : UIImageView!

        lazy var logoLabel: UILabel = {
            var lb = UILabel()
            lb.translatesAutoresizingMaskIntoConstraints = false
            lb.text = "SwapIt"
    //        lb.font = UIFont(name: "Billabong", size: 50)
            lb.font = UIFont(name: "Bunch Blossoms Personal Use", size: 50)
    //        lb.font = .boldSystemFont(ofSize: 50)
            lb.textAlignment = .center
            lb.textColor = .white
    //        lb.backgroundColor = .gray
            return lb
        }()
      
        lazy var separatorOne: UIView = {
            var view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .lightGray
            return view
        }()
        
        lazy var separatorTwo: UIView = {
            var view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .lightGray

            return view
        }()
    
        lazy var separatorThree: UIView = {
            var view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .lightGray

            return view
        }()
        
        lazy var emailTxtFld: UITextField = {
            var txtFld = UITextField()
            txtFld.translatesAutoresizingMaskIntoConstraints = false
    //        txtFld.backgroundColor = .blue
             let placeholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
            txtFld.attributedPlaceholder = placeholder
    //        txtFld.placeholder = "Email"
    //        txtFld.borderStyle = .roundedRect
            txtFld.textAlignment = .center
            txtFld.textColor = .black

            return txtFld
        }()
        
        lazy var passwordTxtFld: UITextField = {
            var txtFld = UITextField()
            txtFld.translatesAutoresizingMaskIntoConstraints = false
    //        txtFld.backgroundColor = .red
            let placeholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
            txtFld.attributedPlaceholder = placeholder
            txtFld.textAlignment = .center
            txtFld.textColor = .black
            txtFld.isSecureTextEntry = true


            return txtFld
        }()
    
        lazy var confirmPwTxtFld: UITextField = {
                   var txtFld = UITextField()
                   txtFld.translatesAutoresizingMaskIntoConstraints = false
           //        txtFld.backgroundColor = .red
                   let placeholder = NSAttributedString(string: "Confirm Password", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
                   txtFld.attributedPlaceholder = placeholder
                   txtFld.textAlignment = .center
                   txtFld.textColor = .black
                   txtFld.isSecureTextEntry = true


                   return txtFld
               }()
        
        lazy var SignupBtn: UIButton = {
            var btn = UIButton(type: .system)
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.backgroundColor = .rgb(red: 101, green: 183, blue: 180)
            btn.setTitle("Sign Up", for: .normal)
            btn.titleLabel?.font = .boldSystemFont(ofSize: 20)
            btn.layer.cornerRadius = 10
            btn.tintColor = .white
            btn.addTarget(self, action: #selector(signupBtnPressed), for: .touchUpInside)
            return btn
        }()
        
        lazy var haveAccLbl: UILabel = {
              var lb = UILabel()
              lb.translatesAutoresizingMaskIntoConstraints = false
              lb.text = "Already have an account?"
    //          lb.font = .boldSystemFont(ofSize: 50)
              lb.textAlignment = .right
            lb.textColor = .black
    //        lb.sizeToFit()
//              lb.backgroundColor = .gray
              return lb
          }()
        
        lazy var loginLinkBtn: UIButton = {
            var btn = UIButton(type: .system)
            btn.translatesAutoresizingMaskIntoConstraints = false
//            btn.backgroundColor = .red
            btn.setTitle("Log In", for: .normal)
            btn.titleLabel?.textAlignment = .right
            btn.tintColor = .rgb(red: 101, green: 183, blue: 180)

    //        btn.titleLabel?.font = .boldSystemFont(ofSize: 20)
    //        btn.layer.cornerRadius = 15
            btn.addTarget(self, action: #selector(loginLinkPressed), for: .touchUpInside)
            return btn
        }()
        lazy var closeViewBtn: UIButton = {
            var btn = UIButton(type: .system)
            btn.translatesAutoresizingMaskIntoConstraints = false
    //            btn.backgroundColor = .red
            let largeConfig = UIImage.SymbolConfiguration(textStyle: .largeTitle)
            btn.setPreferredSymbolConfiguration(largeConfig, forImageIn: .normal)
            btn.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
            btn.tintColor = .white
            
//            btn.titleLabel?.font = .systemFont(ofSize: 60, weight: .regular)
            btn.addTarget(self, action: #selector(closeViewBtnPressed), for: .touchUpInside)
            return btn
            }()
        
        lazy var loginStackView: UIStackView = {
            var sv = UIStackView(arrangedSubviews: [emailTxtFld, passwordTxtFld, confirmPwTxtFld, SignupBtn])
            sv.translatesAutoresizingMaskIntoConstraints = false
            sv.axis = .vertical
            sv.spacing = 30
            sv.distribution = .equalSpacing
            return sv
        }()
        
        lazy var labelsStackView: UIStackView = {
            var sv = UIStackView(arrangedSubviews: [haveAccLbl, loginLinkBtn])
            sv.translatesAutoresizingMaskIntoConstraints = false
            sv.axis = .horizontal
            sv.spacing = 0
            sv.distribution = .equalSpacing
    //        sv.backgroundColor = .blue

            return sv
        }()

        override var preferredStatusBarStyle: UIStatusBarStyle {
            return .lightContent
        }
        
    
    //MARK: viewDidLoad
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
            view.backgroundColor = .white
            self.isModalInPresentation = true

            setupView()
//            assignbackground()
    //        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "balance.jpg")!)
        }
    
    
    @objc func closeViewBtnPressed(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func loginLinkPressed(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func signupBtnPressed(){
//        let mainVC = ContainerVC()
//        mainVC.modalPresentationStyle = .fullScreen
//        self.present(mainVC, animated: true, completion: nil)
        dismiss(animated: true, completion: nil)
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
            [logoLabel,loginStackView, labelsStackView, separatorOne, separatorTwo, separatorThree, closeViewBtn].forEach({view.addSubview($0)})

            /// stackview containers:
            logoLabel.anchor(top: nil, leading: loginStackView.leadingAnchor, bottom: loginStackView.topAnchor, trailing: loginStackView.trailingAnchor, padding: UIEdgeInsets.init(top: 0, left: 0, bottom: 10, right: 0))
            
            loginStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets.init(top: view.frame.height/3, left: 25, bottom: 0, right: 25))
            
            labelsStackView.anchor(top: nil, leading: loginStackView.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: loginStackView.trailingAnchor, padding: UIEdgeInsets.init(top: 0, left: view.frame.width/6.7, bottom: 10, right: view.frame.width/6.7)
//                view.frame.width/8.8
            )
            /// separator views:
            SignupBtn.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, size: CGSize.init(width: 0, height: 45))
            separatorOne.anchor(top: emailTxtFld.bottomAnchor, leading: loginStackView.leadingAnchor, bottom: nil, trailing: loginStackView.trailingAnchor, size: CGSize.init(width: 0, height: 0.5))
            
            separatorTwo.anchor(top: passwordTxtFld.bottomAnchor, leading: loginStackView.leadingAnchor, bottom: nil, trailing: loginStackView.trailingAnchor, size: CGSize.init(width: 0, height: 0.5))
            
            separatorThree.anchor(top: confirmPwTxtFld.bottomAnchor, leading: loginStackView.leadingAnchor, bottom: nil, trailing: loginStackView.trailingAnchor, size: CGSize.init(width: 0, height: 0.5))
            
            closeViewBtn.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets.init(top: 5, left: 0, bottom: 0, right: 5))
            
        }
    
}
