//
//  RecordViewController.swift
//  Audio Pitch
//
//  Created by Dipesh Karki on 23/07/2015.
//  Copyright (c) 2015 Dipesh Karki. All rights reserved.
//

import UIKit
import AVFoundation

class RecordViewController: UIViewController, AVAudioRecorderDelegate {

    var audioRecorder : AVAudioRecorder!
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
        stopButton.enabled = true
        
        
        
        // finding and creating path for our audio
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        let audioName = "testAudio.wav"
        let pathArray = [dirPath, audioName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        
        //creating an audio session
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        
        //initializing audio recorder with the file path we created
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        // audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        println("\(filePath)")
        
    }
    
    
   /* override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if(segue.identifier == "sendAudio"){
            println("Good Job mate!!")
        }
        else {
            println("Something wrong")
        }
    } */
    

    @IBAction func stopRecord(sender: UIButton) {
        
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
        
        // var data = "hello"
        // self.performSegueWithIdentifier("sendAudio", sender: data)
    }
}

