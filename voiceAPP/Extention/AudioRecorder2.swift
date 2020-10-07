
//  Created by user on 2020/10/02.
//  Copyright © 2020 user. All rights reserved.
//

import AVFoundation
import SwiftUI

class AudioRecorder2 {
    
    
    private var recorder: AVAudioRecorder!
    
    internal var audioPlayer: AVAudioPlayer!
    
    var audios : [URL] = []
    
    //レコードの中身。
    
    internal func record() {
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord)
        try! session.setActive(true)
    //    self.getAudios()
    //    return
        _ = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
     //   let fileName = URL.appendingPathComponent("record\(self.audios.count + 1"))
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 44100,
            AVNumberOfChannelsKey: 2,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        recorder = try! AVAudioRecorder(url: getURL(), settings: settings)
        self.recorder = try! AVAudioRecorder(url: getURL(), settings: settings)
        self.recorder.record()
        
    }
    
    
    internal func recordStop() -> Data?{
        recorder.stop()
        let data   = try? Data(contentsOf: getURL())
        return data
    }
    
    internal func play() {
        audioPlayer = try! AVAudioPlayer(contentsOf: getURL())
        audioPlayer.volume = 10.0
        audioPlayer.play()
    }
    
    internal func playStop() {
        audioPlayer.stop()
    }
  /*
    internal func recordApper() {
        audioRecorder.audios()
        
    }
    */
    
    
    private func getURL() -> URL{
       
        do{
        
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let result = try! FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: .producesRelativePathURLs)

            self.audios.removeAll()
            
        for i in result {
            self.audios.append(i)
        }
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("record.m4a")
    }
        
      
}
    /*
    
    func getURL() {
        do {
            let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let result = try! FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: .producesRelativePathURLs)
            
            for i in result {
                self.audios.append(i)
            }
        
        }catch{
            print(error.localizedDescription)
        }
        
    }
    
    */
    
    
}


