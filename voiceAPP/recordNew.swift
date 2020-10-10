
//文字起こしも入れたいけど、１分が限界らしい。
//バックグラウンド再生ができるようになった。

import SwiftUI
import Speech
import MediaPlayer
import AVKit
import AVFoundation






struct recordNew: View {
    
    let audioRecorder: AudioRecorder = AudioRecorder()
    
    @State var isRecording = false
    @State private var selection: Int? = nil
    
    @State var recognizedText: String?
    
    @State var audios : [URL] = []
    
    @State var button = true
    @State var record = false
    @State var session : AVAudioSession!
    @State var recorder : AVAudioRecorder!
    internal var audioPlayer: AVAudioPlayer!
    
    
    
    
    
    //スライダーの設定
    @State private var currentValue: Double = 50
    @State private var textActive = false
    @State private var volume: Float = 0.5
    @State private var seekPosition : Double = 0.3
    @State private var sVolume: Float = UserDefaults.standard.float(forKey: "sVolume")
    //現在の再生位置
    //  @State public var currentPosition: TimeInterval
    
    
    
    var body: some View {
        
        
        //   ForEach(self.audios, id, \.self) {i in Text(i.relativeString) }
        
        
        HStack(spacing: 30) {
            
            
            Button(action: {
                print("タップさた")
            }) {
                Image(systemName: "ellipsis")   // システムアイコンを指定
                Text("")
                
            }
            .foregroundColor(.blue)
            .font(.headline)
            .padding(.bottom, 40)
            .padding(.top, 90)
            
            
            Button(action: {
                print("タップされま")
            }) {
                Image(systemName: "gobackward.15")   // システムアイコンを指定
                Text("")
            }
            .font(.title)
            .foregroundColor(.blue)
            .padding(.bottom, 40)
            .padding(.top, 90)
            
            
            
            
            Button(action: {
                self.audioRecorder.play()
            }) {
                Image(systemName: "play.fill")
            }
            .font(.largeTitle)
            .foregroundColor(.blue)
            .padding(.bottom, 40)
            .padding(.top, 90)
            
            
            
            
            Button(action:  {
                self.audioRecorder.playStop()
            }) {
                Image(systemName: "stop")
            }
            .font(.largeTitle)
            .foregroundColor(.blue)
            .padding(.bottom, 40)
            .padding(.top, 90)
            
            
            
            
            
            
            //15秒進める。
            Button(action: {
                self.audioPlayer.currentTime
            }) {
                Image(systemName: "goforward.15")   // システムアイコンを指定
                Text("")
            }
            .font(.title)
            .foregroundColor(.blue)
            .padding(.bottom, 40)
            .padding(.top, 90)
            
            
            /*
             //捨てる動作
             Button(action:  {
             print("ました")
             }) {
             Image(systemName: "trash")   // システムアイコンを指定
             Text("")
             }
             .foregroundColor(.blue)
             .font(.headline)
             .padding(.bottom, 40)
             .padding(.top, 90)
             
             */
            
            
        }
        
        
        /*     ForEach(self.audioRecorder ,id: \.self){i in
         
         Text(i.relativeString)
         
         }
         */
        
        
        Text("　音声名： record.m4a　")
            .padding(.top, 20)
            .padding(. bottom, 40)
            .foregroundColor(.black)
            .font(.title)
        
        
        
        
        
        
        HStack {
            Text("   　")
            Slider(value: $seekPosition, in: 0...1)
            Text("　   ")
            
            HStack {
                //   Text(formatTime(sec: Int(nowPlaying.duration * seekPosition)))
                Spacer()
                //       Text("-" + formatTime(sec: Int(nowPlaying.duration * (1 - seekPosition))))
                
            }
        }
        //     .padding(.bottom, 40)
        
        
        
        
        
        
        HStack {
            Text("　MIN")
                .foregroundColor(.black)
            Slider(value: $volume, in:0.0...100.0, onEditingChanged: { _ in
                
            })
            Text("MAX　")
                .foregroundColor(.black)
        }
        .padding(.top, 40)
        HStack {
            Spacer()
            Text("音量:\(Int(self.volume))")
                .foregroundColor(.black)
            Spacer()
        }
        
        HStack {
            Text("　MIN")
                .foregroundColor(.black)
            Slider(value: $sVolume, in:0.0...100.0, onEditingChanged: { _ in
                
            })
            Text("MAX　")
                .foregroundColor(.black)
        }
        .padding(.top, 40)
        HStack {
            Spacer()
            Text("音量:\(Int(self.volume))")
                .foregroundColor(.black)
            Spacer()
        }
        
        
        
        
        HStack (spacing: 145){
            
            
            
            Button(action: {
                self.audioRecorder.record()
                
                _ = self.audioRecorder.recordStop()
                
            }) {
                Image(systemName: "waveform.circle")
            }
            .foregroundColor(.blue)
            .padding(.bottom, 60)
            .padding(.top, 20)
            .font(.largeTitle)
            
            
            Button(action: {
                _ = self.audioRecorder.recordStop()
            }) {
                Image(systemName: "record.circle")
                
                
            }
            .foregroundColor(.blue)
            .padding(.bottom, 60)
            .padding(.top, 20)
            .font(.largeTitle)
            
        }
        
    }
    
}









struct recordNew_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


