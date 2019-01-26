//
//  RecordViewController.swift
//  Pitch Perfect
//
//  Created by Malak Bassam on 10/28/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import UIKit
import AVFoundation


class RecordViewController: UIViewController , AVAudioRecorderDelegate {
    var audioRecorder: AVAudioRecorder!
 
    @IBOutlet weak var Lable: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    
    @IBOutlet weak var record_Button: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    @IBAction func recordAudio(_ sender: UIButton) {
        stopButton.isEnabled = true
        record_Button.isEnabled = false
        Lable.text = "Recording in Progress"
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
       let session = AVAudioSession.sharedInstance()
       try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
       try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
       // print("Record in Progress")
    }
    
    
    @IBAction func stopAudio(_ sender: UIButton) {
        stopButton.isEnabled = false
        Lable.text = "Tab To Record"
        record_Button.isEnabled = true
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
          print("Record in Stop")
        
    }
    
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag
        {
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        }
        else { print ("recording was successful")}
    
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            let playSoundVC = segue.destination  as! PlaySoundViewController
            let recordAudioURL = sender as! URL
              playSoundVC.recordedAudioURL = recordAudioURL
            
        }
    }
}

