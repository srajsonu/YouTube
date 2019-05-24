//
//  menuBar.swift
//  YouTube
//
//  Created by ARY@N on 20/05/19.
//  Copyright © 2019 ARYAN. All rights reserved.
//

import UIKit

class menuBar: UIView,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .rgb(displayP3Red: 230, green: 32, blue: 31)
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    let cellID = "cellID"
    let imageNames = ["home","trending","subscriptions","library"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        collectionView.register(menuCell.self, forCellWithReuseIdentifier: cellID)
        
        addSubview(collectionView)
        addConstrainsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstrainsWithFormat(format: "V:|[v0]|", views: collectionView)
        
        //selected when start
        let selectedIndexPath = NSIndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedIndexPath as IndexPath, animated: false, scrollPosition: [])
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! menuCell
        cell.imageView.image = UIImage(named: imageNames[indexPath.row])?.withRenderingMode(.alwaysTemplate)
        cell.tintColor = UIColor.rgb(displayP3Red: 91, green: 14, blue: 13)
        //cell.backgroundColor = .rgb(displayP3Red: 230, green: 32, blue: 31)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width/4, height: frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class menuCell: baseCell {
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "home")
        return iv
    }()
    
    override var isHighlighted: Bool{
        didSet{
            imageView.tintColor = isHighlighted ? UIColor.white : UIColor.rgb(displayP3Red: 91, green: 14, blue: 13)
        }
    }
    override var isSelected: Bool{
        didSet{
            imageView.tintColor = isSelected ? UIColor.white : UIColor.rgb(displayP3Red: 91, green: 14, blue: 13)
        }
    }
    override func setupViews() {
        super.setupViews()
        
        addSubview(imageView)
        addConstrainsWithFormat(format: "H:[v0(24)]", views: imageView)
        addConstrainsWithFormat(format: "V:[v0(24)]", views: imageView)
        
        addConstraints([NSLayoutConstraint.init(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)])
        addConstraints([NSLayoutConstraint.init(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)])
    }

}
