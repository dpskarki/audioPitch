//
//  RecordViewController.swift
//  Audio Pitch
//
//  Created by Dipesh Karki on 23/07/2015.
//  Copyright (c) 2015 Dipesh Karki. All rights reserved.
//

import UIKit
import AVFoundation

class RecordViewController: UIViewController {

    var audioRecorder : AVAudioPlayer!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var pauseText: UILabel!
    @IBOutlet weak var resumeButton: UIButton!
    @IBOutlet weak var resumeText: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var stopText: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var startText: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(animated: Bool) {
        pauseButton.enabled = false
        resumeButton.enabled = false
        pauseText.enabled = false
        resumeText.enabled = false
        stopButton.enabled = false
        stopText.enabled = false
    
        
    }

    
    @IBAction func startRecord(sender: UIButton) {
        startButton.enabled = false
        startText.enabled = false
        
        
        
        // finding and creating path for our audio
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        let audioName = "testAudio.wav"
        let pathArray = [dirPath, audioName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        
    }
    

}

