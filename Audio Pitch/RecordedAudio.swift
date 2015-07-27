//
//  RecordedAudio.swift
//  Audio Pitch
//
//  Created by Dipesh Karki on 24/07/2015.
//  Copyright (c) 2015 Dipesh Karki. All rights reserved.
//

import Foundation

class RecordedAudio : NSObject {
    
    var title : String
    var filePathUrl : NSURL
    
    init(title: String, filePathUrl: NSURL) {
        self.title = title
        self.filePathUrl = filePathUrl
    }
}
