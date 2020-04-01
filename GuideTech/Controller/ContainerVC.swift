//
//  ContainerVC.swift
//  GuideTech
//
//  Created by Valter A. Machado on 3/16/20.
//  Copyright © 2020 Valter A. Machado. All rights reserved.
//

import UIKit
import MessageUI
import Firebase

class ContainerVC: UIViewController {
    
    var menuVC: MenuSliderVC!
    var centerController: UIViewController!
    var isExpanded = false
//    /// hiding statusBar
//    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation{
//        return .slide
//    }
//
//    override var prefersStatusBarHidden: Bool{
//        return isExpanded
//    }
    //**
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .rgb(red: 240, green: 240, blue: 240)
        checkUserIsLoggedIn()
        configHomeVC()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
////        checkUserIsLoggedIn()
//    }
    
    fileprivate func checkUserIsLoggedIn(){
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let loginVC = LoginVC()
                let navigationController = UINavigationController(rootViewController: loginVC)
                navigationController.modalPresentationStyle = .fullScreen
                self.present(navigationController, animated: false, completion: nil)
                return
            }
        } else {
            print("is Logged in")
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
       
    fileprivate func configHomeVC(){
        let homeVC = HomeVC()
        homeVC.delegate = self
        centerController = UINavigationController(rootViewController: homeVC)
        view.addSubview(centerController.view)
        addChild(centerController)
        centerController.didMove(toParent: self)
        
    }
    
    fileprivate func configMenuController(){
        if menuVC == nil {
            menuVC = MenuSliderVC()
            menuVC.delegate = self
            view.insertSubview(menuVC.view, at: 0)
            addChild(menuVC)
            menuVC.didMove(toParent: self)
//            print("menuSlider added...")
        }
    }
 
    // animates the burger menu and toggles selected menu option
    fileprivate func animatePanel(shouldExpand: Bool, menuOption: MenuOptions?){
        
        if preferredLanguage == "ar" // arabic
        {
            if shouldExpand
            {
                // Show Menu
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                    self.centerController.view.frame.origin.x = -(self.centerController.view.frame.width - 80) // makes view slide from right to left
                }, completion: nil)
            }
            else
            {
                // Hide Menu
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                    self.centerController.view.frame.origin.x = 0
                }) { (_) in
                    
                    guard let menuOption = menuOption else {return}
                    self.didSelectMenuOption(menuOption: menuOption)
                    
                }
            }
            
        }
        else // english
        {
            if shouldExpand
            {
                // Show Menu
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                    self.centerController.view.frame.origin.x = self.centerController.view.frame.width - 80
                }, completion: nil)
//                transparentView.isHidden = false
//                transparentView2.isHidden = false
            }
            else
            {
                // Hide Menu
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                    self.centerController.view.frame.origin.x = 0
                }) { (_) in
                    
                    guard let menuOption = menuOption else {return}
                    self.didSelectMenuOption(menuOption: menuOption)
                    
                }
            }
            
        }
        
//        animateStatusBar()
    }
    
    fileprivate func didSelectMenuOption(menuOption: MenuOptions){
        /// didSelect method to triggler the VCs inside MenuVC
        switch menuOption{
        case .VoiceMapping:
            let voiceMappingVC = VoiceMappingVC()
            let navigationController = UINavigationController(rootViewController: voiceMappingVC)
            navigationController.modalPresentationStyle = .fullScreen
            present(navigationController, animated: true)
            print("VoiceMapping")
            
        case .Settings:
            let settingsVC = SettingsVC()
            let navigationController = UINavigationController(rootViewController: settingsVC)
            navigationController.modalPresentationStyle = .fullScreen
            present(navigationController, animated: true)
            print("Settings")
            
        case .HelpCenter:
            print("HelpCenter")
            showMailComposer()
            
        case .Logout:
            // Logging out the user
            
            if preferredLanguage == "ar" {
                
                let alertController = UIAlertController(title: "Log Out".localized("ar"), message: "Are you sure you want to log out?".localized("ar"), preferredStyle: .alert)
                
                let logOutAction = UIAlertAction(title: "Log Out".localized("ar"), style: .destructive) { UIAlertAction in
                    do {
                        try Auth.auth().signOut()
                    } catch let logoutError {
                        print(logoutError)
                    }
                    
                    let loginVC = LoginVC()
                    let navigationController = UINavigationController(rootViewController: loginVC)
                    navigationController.modalPresentationStyle = .fullScreen
                    self.present(navigationController, animated: true, completion: nil)
                    print("Logout")
                }
                
                let cancelAction = UIAlertAction(title: "Cancel".localized("ar"), style: .cancel) { UIAlertAction in }
                
                alertController.view.tintColor = .rgb(red: 101, green: 183, blue: 180)
                alertController.addAction(logOutAction)
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true, completion: nil)
                
            } else {
                
                let alertController = UIAlertController(title: "Log Out", message: "Are you sure you want to log out?", preferredStyle: .alert)
                
                let logOutAction = UIAlertAction(title: "Log Out", style: .destructive) { UIAlertAction in
                    do {
                        try Auth.auth().signOut()
                    } catch let logoutError {
                        print(logoutError)
                    }
                    
                    let loginVC = LoginVC()
                    let navigationController = UINavigationController(rootViewController: loginVC)
                    navigationController.modalPresentationStyle = .fullScreen
                    self.present(navigationController, animated: true, completion: nil)
                    print("Logout")
                }
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { UIAlertAction in }
                
                alertController.view.tintColor = .rgb(red: 101, green: 183, blue: 180)
                alertController.addAction(logOutAction)
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true, completion: nil)
                
            }
            
            
        }
    }
    /// func to hide the statusBar
    func animateStatusBar(){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.setNeedsStatusBarAppearanceUpdate()
        }, completion: nil)
    }
    
}


extension ContainerVC: homeVCDelegate {
    
    func handleMenuToggle(forMenuOption menuOption: MenuOptions?) {
        
        if !isExpanded{
            configMenuController()
        }
        isExpanded = !isExpanded
        animatePanel(shouldExpand: isExpanded, menuOption: menuOption)
//        print("isExplanded: \(isExpanded)")
        
    }
    
}

extension ContainerVC: MFMailComposeViewControllerDelegate {
    
    func showMailComposer() {
        
        guard MFMailComposeViewController.canSendMail() else {
            //Show alert informing the user
            return
        }
        
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients(["support@guidetech.co"])
        composer.setSubject("HELP!")
        composer.setMessageBody("", isHTML: false)
        
        present(composer, animated: true)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        if let _ = error {
            //Show error alert
            controller.dismiss(animated: true)
            return
        }
        
        switch result {
        case .cancelled:
            print("Cancelled")
        case .failed:
            print("Failed to send")
        case .saved:
            print("Saved")
        case .sent:
            print("Email Sent")
        @unknown default:
            break
        }
        
        controller.dismiss(animated: true)
    }
}
