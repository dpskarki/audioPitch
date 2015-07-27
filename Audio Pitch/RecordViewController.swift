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
    var recordedAudio : RecordedAudio!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var pauseText: UILabel!
    @IBOutlet weak var resumeButton: UIButton!
    @IBOutlet weak var resumeText: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var stopText: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var startText: UILabel!
    
    var state : Bool!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(animated: Bool) {
        
        buttonState(false)
        startButton.enabled = true
        startText.enabled = true
        startText.text = "Tap to Record Voice"
    }

    
    @IBAction func startRecord(sender: UIButton) {
        startButton.enabled = false
        startText.text = "Recording in Progress"
        buttonState(true)
        resumeButton.enabled = false
        resumeText.enabled = false
        
        
        
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
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
       
        //if recording successfull
        if(flag) {
            
            //inititalizing object of our model RecordedAudio and saving title and url
            recordedAudio = RecordedAudio(title: recorder.url.lastPathComponent!, filePathUrl: recorder.url)
           
            self.performSegueWithIdentifier("sendAudio", sender: recordedAudio)
        }
        else {
            stopButton.enabled = false
            startButton.enabled = true
        }
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        //confirming, its the same segway
        if(segue.identifier == "sendAudio"){
            let playSoundVC : PlayViewController = segue.destinationViewController as! PlayViewController
            let data = sender as! RecordedAudio
            playSoundVC.receivedAudio = data
        }
        else {
            println("Something wrong")
        }
    }
    
    
    @IBAction func pauseRecord(sender: UIButton) {
        audioRecorder.pause()
        buttonState(false)
        resumeButton.enabled = true
        resumeText.enabled = true
    }
    

    @IBAction func resumeRecord(sender: UIButton) {
        audioRecorder.record()
        buttonState(false)
        startText.enabled = true
        stopButton.enabled = true
        stopText.enabled = true
        
        
    }
    
    @IBAction func stopRecord(sender: UIButton) {
        
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
        
        
    }
    
    
    func buttonState(state: Bool) {
        
        stopButton.enabled = state
        stopText.enabled = state
        resumeButton.enabled = state
        resumeText.enabled = state
        pauseText.enabled = state
        pauseButton.enabled = state
        startButton.enabled = state
        startText.enabled = state
        
    }
}

