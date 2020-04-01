//
//  PopUpWindow.swift
//  PopUpWindow
//
//  Created by Stephen Dowless on 12/13/18.
//  Copyright © 2018 Stephan Dowless. All rights reserved.
//

import UIKit

protocol PopUpDelegate {
    func handleEnglishBtnDismissal()
    func handleArabicBtnDismissal()
}

class PopUpWindow: UIView {

    // MARK: - Properties
    
    var delegate: PopUpDelegate?
    
    var showSuccessMessage: Bool? {
        didSet {
            guard let success = showSuccessMessage else { return }
            if success {
                checkLabel.text = "✓"
                notificationLabel.text = "Success"
                checkLabel.textColor = UIColor(red: 147/255, green: 227/255, blue: 105/255, alpha: 1)
            } else {
                checkLabel.text = "X"
                notificationLabel.text = "Error"
                checkLabel.textColor = .red
            }
        }
    }
    
    let checkLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 96)
        
        return label
    }()
    
    let notificationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Avenir", size: 24)
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Avenir", size: 24)
        label.text = "Select Language"
        return label
    }()
    
    let englishBtn: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .rgb(red: 101, green: 183, blue: 180)
        button.setTitle("English", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleEnglishBtn), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 20
        return button
    }()
    
    let arabicBtn: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .rgb(red: 101, green: 183, blue: 180)
        button.setTitle("Arabic", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleArabicBtn), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 20
        return button
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .rgb(red: 240, green: 240, blue: 240)
        
        addSubview(arabicBtn)
        arabicBtn.heightAnchor.constraint(equalToConstant: 45).isActive = true
        arabicBtn.leftAnchor.constraint(equalTo: leftAnchor, constant: 40).isActive = true
        arabicBtn.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50).isActive = true
        arabicBtn.rightAnchor.constraint(equalTo: rightAnchor, constant: -40).isActive = true
        
        addSubview(englishBtn)
        englishBtn.heightAnchor.constraint(equalToConstant: 45).isActive = true
        englishBtn.leftAnchor.constraint(equalTo: leftAnchor, constant: 40).isActive = true
        englishBtn.rightAnchor.constraint(equalTo: rightAnchor, constant: -40).isActive = true
        englishBtn.bottomAnchor.constraint(equalTo: arabicBtn.topAnchor, constant: -20).isActive = true
        
        addSubview(descriptionLabel)
        descriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    @objc func handleEnglishBtn() {
        delegate?.handleEnglishBtnDismissal()
    }
    
    @objc func handleArabicBtn() {
        delegate?.handleArabicBtnDismissal()
    }
    
}
