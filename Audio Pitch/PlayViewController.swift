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
    
    //global variable initializing for AVAudioPlayerNode
    var audioPlayerNode: AVAudioPlayerNode!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
        
    }

    

    @IBAction func playSlowAudio(sender: UIButton) {
        playAudio(0.5)
    }
    
    
    
    @IBAction func playFastAudio(sender: UIButton) {
       playAudio(2.0)
    }
    
    func playAudio(rate: Float){
        
        resettingAudio()
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
        
        audioEngineFoundation()
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlaying()
        
        }
    
    
   
    
    @IBAction func playEcho(sender: UIButton) {
        
        audioEngineFoundation()
        
        var echoNode = AVAudioUnitDelay()
        echoNode.delayTime = NSTimeInterval(0.3)
        audioEngine.attachNode(echoNode)
        
        // Connect Player to AudioEffect node
        audioEngine.connect(audioPlayerNode, to: echoNode, format: nil)
        // Connect AudioEffect to Output node
        audioEngine.connect(echoNode, to: audioEngine.outputNode, format: nil)
        
        audioPlaying()

    }
    
    
    @IBAction func playReverb(sender: UIButton) {
       
        audioEngineFoundation()
        var audioReverb = AVAudioUnitReverb()
        audioReverb.loadFactoryPreset( AVAudioUnitReverbPreset.Cathedral)
        audioReverb.wetDryMix = 60
       
        // Attach the audio effect node corresponding to the user selected effect
        audioEngine.attachNode(audioReverb)
        
        // Connect Player --> AudioEffect
        audioEngine.connect(audioPlayerNode, to: audioReverb, format: nil)
        
        // Connect AudioEffect --> Output
        audioEngine.connect(audioReverb, to: audioEngine.outputNode, format: nil)
        
        audioPlaying()
    }
    
    
    
    //starting audio engine and attaching audioPlayer node to audio engine
    func audioEngineFoundation() {
       resettingAudio()
        
        audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
    }
    
    
    // Scheduling and playing the audio
    func audioPlaying() {
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
        
    }
    
    
    @IBAction func stopAudio(sender: UIButton) {
        resettingAudio()
       
    }
    
    func resettingAudio() {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
    
   }
