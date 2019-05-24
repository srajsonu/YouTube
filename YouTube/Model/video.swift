//
//  video.swift
//  YouTube
//
//  Created by ARY@N on 21/05/19.
//  Copyright © 2019 ARYAN. All rights reserved.
//

import UIKit

class video: NSObject {
    
    var thumbnailImageName: String?
    var title: String?
    var numberOfViews: NSNumber?
    var uploadDate: NSDate?
    
    var channel: Channel?
}

class Channel: NSObject {
    var name: String?
    var prifileImageViewName: String?
}
