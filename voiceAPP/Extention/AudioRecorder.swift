//
//  AudioRecorder.swift
//  voiceAPP
//
//  Created by user on 2020/10/02.
//  Copyright © 2020 user. All rights reserved.
//https://kerubito.net/technology/9869を参考に作成

import AVFoundation
import MediaPlayer
import SwiftUI


class AudioRecorder {
    
    
    
    private var audioRecorder: AVAudioRecorder!
    internal var audioPlayer: AVAudioPlayer!
    var audios : [URL] = []
    
    var audioFilename: URL!
    
    
    //音声の録音をするためのもの
    internal func record()  {
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord)
        try! session.setActive(true)
    //    self.getAudios()
    //    return
        _ = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
     
        
        audioFilename = Bundle.main.bundleURL.appendingPathComponent("sound.m5p")
        
        
        let setting = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 44100,
            AVNumberOfChannelsKey: 2,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
       audioRecorder = try! AVAudioRecorder(url: getURL(), settings: setting)
       self.audioRecorder = try! AVAudioRecorder(url: getURL(), settings: setting)
        audioRecorder.record()
    }
    
    
    
    
    
    //ファイルからバイナリーにして戻る。
    internal func recordStop() -> Data?{
        audioRecorder.stop()
        let data   = try? Data(contentsOf: getURL())
        return data
    }
    
    internal func play() {
        audioPlayer = try! AVAudioPlayer(contentsOf: getURL())
        audioPlayer.volume = 10.0
        audioPlayer.play()
        
      //  audioPlayer.stop()
        
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
        //ドキュメント直下に「sound.m4a」として録音データをファイルにて保存します。
        //m4aはAAC形式の拡張子
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("sound.m4a")
    }
}
    
  /*
    private func getURL() -> URL {
        return FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask)[0].appendingPathComponent("")
    }
    */
    
    /*
    func getURL() {
        do {
            let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let result = try! FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: .producesRelativePathURLs)
            for i in result {
                self.audios.append(i)
            }
        
        }
        
    }
    
    
    */
    
}
