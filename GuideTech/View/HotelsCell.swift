//
//  HotelsCell.swift
//  GuideTech
//
//  Created by Valter A. Machado on 3/7/20.
//  Copyright © 2020 Valter A. Machado. All rights reserved.
//

import UIKit
import LBTATools

class HotelsCell: UICollectionViewCell {
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
    var prices: [String]? {
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
//        cv.layer.shadowColor = UIColor.black.cgColor
//        cv.layer.shadowOffset = CGSize(width: 0, height: 1)
//        cv.layer.shadowOpacity = 1
//        cv.layer.shadowRadius = 1.0
//        cv.clipsToBounds = false
//        cv.layer.masksToBounds = false
        
        cv.backgroundColor = .clear
        cv.delegate = self
        cv.dataSource = self
        cv.register(HotelIconsCell.self, forCellWithReuseIdentifier: cellID)
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
            setupView()
//        contentView.backgroundColor = .blue
    }
        
   fileprivate  func setupView(){
        [collectionView].forEach({contentView.addSubview($0)})

        collectionView.anchor(top: contentView.safeAreaLayoutGuide.topAnchor, leading: contentView.leadingAnchor, bottom: contentView.safeAreaLayoutGuide.bottomAnchor, trailing: contentView.trailingAnchor)
    }
        
    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
}
}

extension HotelsCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! HotelIconsCell
        
        if let imageName = images?[indexPath.item]{
            cell.coverImageView.image = UIImage(named: imageName)
        }
        
        if let names = names?[indexPath.item]{
            cell.name.text = names
        }
        
        if let addresses = addresses?[indexPath.item]{
            cell.address.text = addresses
        }
        
        if let prices = prices?[indexPath.item]{
            cell.pricePerNight.text = prices
        }
        
        if let reviews = reviews?[indexPath.item]{
            cell.review.text = reviews
        }
//        cell.coverImageView.backgroundColor = .blue
//        cell.name.backgroundColor = .blue
//        cell.address.backgroundColor = .blue
//        cell.stackView1.addBackground(color: stackViewColor)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 135, height: frame.height - 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Hotels:\(indexPath.item)")
    }
}




// MARK: icons cell (cell that will provide the data)
class HotelIconsCell: UICollectionViewCell {
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
    // price per night (convert it from string to int)
    lazy var pricePerNight: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    // stars (convert it from string to int)
    lazy var review: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var stackView1: UIStackView = {
        var sv = UIStackView(arrangedSubviews: [name, address, stackView2])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.spacing = 2
        //        sv.alignment = .center
        sv.distribution = .equalSpacing
//        sv.addBackground(color: .green)
        
        return sv
    }()
    
    lazy var stackView2: UIStackView = {
        var sv = UIStackView(arrangedSubviews: [pricePerNight, review])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.spacing = -10
        //        sv.alignment = .center
        sv.distribution = .equalSpacing
//        sv.addBackground(color: .lightGray)
        
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
        [stackView1, coverImageView].forEach({contentView.addSubview($0)})
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 15
        stackView1.anchor(top: coverImageView.bottomAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor, padding:  UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        
        coverImageView.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 105))
        
//        name.anchor(top: coverImageView.bottomAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 25))
//
//        address.anchor(top: name.bottomAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 25))
//
//        stackView2.anchor(top: address.bottomAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0))
//        name.anchor(top: coverImageView.bottomAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 0))
//        coverImageView.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
