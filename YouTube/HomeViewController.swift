//
//  ViewController.swift
//  YouTube
//
//  Created by ARY@N on 18/05/19.
//  Copyright © 2019 ARYAN. All rights reserved.
//

import UIKit

class HomeViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {

    override func viewDidLoad() {
        super.viewDidLoad()
       // let start = Date()
        navigationItem.title = "YouTube"
        collectionView?.backgroundColor = .white
        collectionView.register(videoCell.self, forCellWithReuseIdentifier: "cellID")
        //let end = Date()
       // print("Elapsed time \(end.timeIntervalSince(start))")
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width,height: 200)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

class videoCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.blue
        //imageView.translatesAutoresizingMaskIntoConstraints = false  // Auto resieze
        return imageView
    }()
    
    let userProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.blue
        return imageView
    }()
    
    let separatorView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.black
        //view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    func setupViews(){
        addSubview(thumbnailImageView)
        addSubview(separatorView)
        
        addConstrainsWithFormat(format: "H:|-0-[v0]-0-|", views: thumbnailImageView)
        
        addConstrainsWithFormat(format: "V:|-16-[v0]-16-[v1(1)]|", views: thumbnailImageView,separatorView)
        
        addConstrainsWithFormat(format: "H:|[v0]|", views: separatorView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension UIView{
    func addConstrainsWithFormat(format: String, views: UIView...){
        
        var viewsDictionary = [String : UIView]()
        for (index,view) in views.enumerated(){
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
}
