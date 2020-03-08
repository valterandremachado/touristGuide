//
//  RestaurantsCell.swift
//  GuideTech
//
//  Created by Valter A. Machado on 3/7/20.
//  Copyright © 2020 Valter A. Machado. All rights reserved.
//

import UIKit
import LBTATools

class RestaurantsCell: UICollectionViewCell {
    private let cellID = "cellId"
    
    var images: [String]? {
        didSet{
            collectionView.reloadData()
        }
    }
    var names: [String]? {
        didSet{
            collectionView.reloadData()
        }
    }
    var addresses: [String]? {
        didSet{
            collectionView.reloadData()
        }
    }
    var descriptions: [String]? {
        didSet{
            collectionView.reloadData()
        }
    }
    var reviews: [String]? {
        didSet{
            collectionView.reloadData()
        }
    }
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        
        cv.backgroundColor = .clear
        cv.delegate = self
        cv.dataSource = self
        cv.register(RestaurantIconsCell.self, forCellWithReuseIdentifier: cellID)
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
        //             contentView.backgroundColor = .blue
    }
    
    fileprivate func setupView(){
        [collectionView].forEach({contentView.addSubview($0)})
        
        collectionView.anchor(top: contentView.safeAreaLayoutGuide.topAnchor, leading: contentView.leadingAnchor, bottom: contentView.safeAreaLayoutGuide.bottomAnchor, trailing: contentView.trailingAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RestaurantsCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! RestaurantIconsCell
        
        if let imageName = images?[indexPath.item]{
            cell.coverImageView.image = UIImage(named: imageName)
        }
        
        if let names = names?[indexPath.item]{
            cell.name.text = names
        }
        
        if let description = descriptions?[indexPath.item]{
            cell.placeDescription.text = description
        }
        
        if let reviews = reviews?[indexPath.item]{
            cell.review.text = reviews
        }
        
        if let addresses = addresses?[indexPath.item]{
            cell.address.text = addresses
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 135, height: frame.height - 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Restaurants:\(indexPath.item)")
    }
}

// restaurant icons cell
class RestaurantIconsCell: UICollectionViewCell {
    // image
    lazy var coverImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        //        iv.backgroundColor = .blue
        //        iv.contentMode = .scaleAspectFill
        //        iv.sizeToFit()
        //        iv.contentMode = .scaleToFill
        
        return iv
    }()
    // name
    lazy var name: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
//        lbl.backgroundColor = .blue
        
        return lbl
    }()
    // address
    lazy var address: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
//        lbl.backgroundColor = .purple
        lbl.textColor = .lightGray
        
        return lbl
    }()
    // place info
    lazy var placeDescription: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0 // 0 = as many lines as the label needs
        lbl.frame.origin.x = 32
        lbl.frame.origin.y = 32
        lbl.frame.size.width = self.bounds.width - 64
        lbl.font = UIFont.boldSystemFont(ofSize: 13) // my UIFont extension
        lbl.textColor = UIColor.lightGray
        lbl.sizeToFit()
        //        lbl.backgroundColor = .systemPink
        
        return lbl
    }()
    // stars (convert it from string to int)
    lazy var review: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var stackView1: UIStackView = {
        var sv = UIStackView(arrangedSubviews: [name, address, review])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.spacing = 0
        //        sv.alignment = .center
        sv.distribution = .equalSpacing
        //        sv.addBackground(color: .green)
        
        return sv
    }()
    
    lazy var stackView2: UIStackView = {
        var sv = UIStackView(arrangedSubviews: [coverImageView])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.spacing = 0
        //        sv.alignment = .center
        sv.distribution = .equalSpacing
        //        sv.addBackground(color: .green)
        
        return sv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
        //        contentView.backgroundColor = .red
        self.layer.cornerRadius = 15
        //                self.layer.borderWidth = 1.0
        //                self.layer.borderColor = UIColor.lightGray.cgColor
        //
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 1.0
        self.layer.masksToBounds = false
    }
    
    fileprivate func setupView(){
        [stackView1, stackView2].forEach({contentView.addSubview($0)})
        
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 15
        
        stackView2.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 105))
        
        stackView1.anchor(top: stackView2.bottomAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor, padding:  UIEdgeInsets(top: 10, left: 10, bottom: 15, right: 10))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
