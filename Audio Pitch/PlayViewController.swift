//
//  PlayViewController.swift
//  Audio Pitch
//
//  Created by Dipesh Karki on 23/07/2015.
//  Copyright (c) 2015 Dipesh Karki. All rights reserved.
//

import UIKit
import AVFoundation

class PlayViewController: UIViewController {

    var audioPlayer: AVAudioPlayer!
    var receivedAudio : RecordedAudio!
    var audioEngine: AVAudioEngine!
    var audioFile: AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func playSlowAudio(sender: UIButton) {
        playAudio(0.5)
    }
    
    
    
    @IBAction func playFastAudio(sender: UIButton) {
       playAudio(2.0)
    }
    
    func playAudio(rate: Float){
        
        audioPlayer.stop()
        audioPlayer.rate = rate
        
        // starting player from the begining
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }
  
    @IBAction func playChipmunk(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func playDarth(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
        
    }
    
    func playAudioWithVariablePitch(pitch : Float) {
        
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
    
    
    @IBAction func playEcho(sender: UIButton) {
    }
    
    
    @IBAction func playReverb(sender: UIButton) {
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
