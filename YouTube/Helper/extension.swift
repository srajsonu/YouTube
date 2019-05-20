//
//  extension.swift
//  YouTube
//
//  Created by ARY@N on 20/05/19.
//  Copyright © 2019 ARYAN. All rights reserved.
//

import UIKit

extension UIColor{
    static func rgb(displayP3Red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor{
        return UIColor(displayP3Red: displayP3Red/255, green: green/255, blue: blue/255, alpha: 1)
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
