//
//  videoCell.swift
//  YouTube
//
//  Created by ARY@N on 20/05/19.
//  Copyright © 2019 ARYAN. All rights reserved.
//

import UIKit

class baseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    func setupViews(){
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class videoCell: baseCell {
    
    var video: video? {
        didSet {
            titleLabel.text = video?.title
           // thumbnailImageView.image = UIImage(named: video!.thumbnailImageName!)
            setupThumbnailImage()
            setupProfileImage()
            
            if let channelName = video?.channel?.name, let numberOfViews = video?.numberOfViews {
                
                let numberFormatter = NumberFormatter() // for views format
                numberFormatter.numberStyle = .decimal
                let subtitleText = "\(channelName) - \(numberFormatter.string(from: numberOfViews)!) - 2 years ago"
                subtitleTextView.text = subtitleText
            }
            //measure title text
            if let title = video?.title{
                let size = CGSize(width: frame.width - 10 - 44 - 8, height: 1000)
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                let estimateRect = NSString(string: title).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)], context: nil)
                
                if estimateRect.size.height > 20 {
                    titleLabelHeightConstraints?.constant = 60
                }else {
                    titleLabelHeightConstraints?.constant = 20
                }
            }
        }
    }
    func setupProfileImage(){
        
        if let profileImageURL = video?.channel?.prifileImageViewName {
            
            let url = NSURL(string: profileImageURL)
            let request = URLRequest(url: url! as URL)
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                if error != nil {
                    print(error!)
                    return
                }
                DispatchQueue.main.async {
                    self.userProfileImageView.image = UIImage(data: data!)
                }
                }.resume()
        }
    }
    func setupThumbnailImage(){
        if let thumbnailImageURL = video?.thumbnailImageName {
            
            let url = NSURL(string: thumbnailImageURL)
            let request = URLRequest(url: url! as URL)
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                if error != nil {
                    print(error!)
                    return
                }
                DispatchQueue.main.async {
                    self.thumbnailImageView.image = UIImage(data: data!)
                }
            }.resume()
        }
    }
    
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "taylor")
        imageView.contentMode = ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let userProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "taylor-swift")
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Taylor Swift - Blank Space"
        label.numberOfLines = 2
        return label
    }()
    
    let subtitleTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "TaylorSwiftVEVO - 1,604,684,607 views - 2 years ago"
        textView.textContainerInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
        textView.textColor = UIColor.lightGray
        return textView
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(displayP3Red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        //view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var titleLabelHeightConstraints: NSLayoutConstraint?

    override func setupViews(){
        addSubview(thumbnailImageView)
        addSubview(separatorView)
        addSubview(userProfileImageView)
        addSubview(titleLabel)
        addSubview(subtitleTextView)
        
        //Horizontal Axis
        addConstrainsWithFormat(format: "H:|-0-[v0]-0-|", views: thumbnailImageView)
        
        addConstrainsWithFormat(format: "H:|-10-[v0(44)]", views: userProfileImageView)
        
        addConstrainsWithFormat(format: "H:|[v0]|", views: separatorView)
        
        //Vertical Axis
        addConstrainsWithFormat(format: "V:|-16-[v0]-8-[v1(44)]-16-[v2(1)]|", views: thumbnailImageView,userProfileImageView,separatorView)
        
        //Top Constraints
        addConstraints([NSLayoutConstraint.init(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 8)])
        
        //left Constraint
        addConstraints([NSLayoutConstraint.init(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8)])
        
        //Right constraints
        addConstraints([NSLayoutConstraint.init(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0)])
        
        //height constraints
        titleLabelHeightConstraints =  NSLayoutConstraint.init(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 44)
        addConstraints([titleLabelHeightConstraints!]) // size of title label
        
        //        addConstrainsWithFormat(format: "V:[v0(20)]", views: titleLabel)
        //        addConstrainsWithFormat(format: "H:|-60-[v0]|", views: titleLabel)
        
        //Top Constraints
        addConstraints([NSLayoutConstraint.init(item: subtitleTextView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 4)])
        
        //left Constraint
        addConstraints([NSLayoutConstraint.init(item: subtitleTextView, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8)])
        
        //Right constraints
        addConstraints([NSLayoutConstraint.init(item: subtitleTextView, attribute: .right, relatedBy: .equal, toItem: titleLabel, attribute: .right, multiplier: 1, constant: 0)])
        
        //height constraints
        addConstraints([NSLayoutConstraint.init(item: subtitleTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20)])
    }
    
    
}
