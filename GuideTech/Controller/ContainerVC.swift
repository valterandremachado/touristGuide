//
//  ContainerVC.swift
//  GuideTech
//
//  Created by Valter A. Machado on 3/16/20.
//  Copyright © 2020 Valter A. Machado. All rights reserved.
//

import UIKit
import MessageUI

class ContainerVC: UIViewController {
    
    var menuVC: MenuSliderVC!
    var centerController: UIViewController!
    var isExpanded = false
    
    /// hiding statusBar
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation{
        return .slide
    }
    
    override var prefersStatusBarHidden: Bool{
        return isExpanded
    }
    //**
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
        configHomeVC()
        
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
        
        if preferredLanguage == "ar"
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
        else
        {
            if shouldExpand
            {
                // Show Menu
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                    self.centerController.view.frame.origin.x = self.centerController.view.frame.width - 80
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
        
//        if preferredLanguage == "en" {
//
//            if shouldExpand
//            {
//                // Show Menu
//                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
//                    self.centerController.view.frame.origin.x = self.centerController.view.frame.width - 80
//                }, completion: nil)
//            }
//            else
//            {
//                // Hide Menu
//                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
//                    self.centerController.view.frame.origin.x = 0
//                }) { (_) in
//
//                    guard let menuOption = menuOption else {return}
//                    self.didSelectMenuOption(menuOption: menuOption)
//
//                }
//            }
//
//        } else if preferredLanguage == "ar" {
//
//            if shouldExpand
//            {
//                // Show Menu
//                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
//                    self.centerController.view.frame.origin.x = -(self.centerController.view.frame.width - 80) // makes view slide from right to left
//                }, completion: nil)
//            }
//            else
//            {
//                // Hide Menu
//                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
//                    self.centerController.view.frame.origin.x = 0
//                }) { (_) in
//
//                    guard let menuOption = menuOption else {return}
//                    self.didSelectMenuOption(menuOption: menuOption)
//
//                }
//            }
//        }
        
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
//            let helpCenterVC = HelpCenterVC()
//            let navigationController = UINavigationController(rootViewController: helpCenterVC)
//            navigationController.modalPresentationStyle = .fullScreen
//            present(navigationController, animated: true)
            print("HelpCenter")
            showMailComposer()
            
        case .Logout:
            let loginVC = LoginVC()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: true, completion: nil)
            print("Logout")
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
//        let home = HomeVC()
//        home.menuPressed(isExpanded)
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
