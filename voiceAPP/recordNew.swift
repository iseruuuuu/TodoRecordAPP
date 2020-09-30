//
//  recordNew.swift
//  voiceAPP
//
//  Created by user on 2020/09/12.
//  Copyright © 2020 user. All rights reserved.
//レコードの保存先をタスクみたいにする


import SwiftUI
import AVKit
import AVFoundation

class AudioViewControler: UIViewController {

    

struct recordNew: View {
    var body: some View {
        
        Home()
            //背景設定(ずっと黒)
          //  .preferredColorScheme(.dark)
        
    }
}

struct recordNew_Previews: PreviewProvider {
    static var previews: some View {
        recordNew()
    }
}

struct  Home : View {
    
@State var record = false
   // createing instance for recording.　レコードのインスタンスを作成
    @State var session : AVAudioSession!
    @State var recorder : AVAudioRecorder!
   // @State var audio: AVAudioPlayer!
    @State var alert = false
    // Fetch Audios...　オーディオを取得する。
    @State var audios : [URL] = []
    
    var body: some View {
        
        NavigationView{
    
            VStack{
                
                List(self.audios,id: \.self){i in
                    Group {
                        HStack {
                            Text("tap me")
                            Text("Button").onTapGesture {
                                print("tap")
                            }
                        }
                    }
                    
                    
                    // printing only file name....　ファイルの印刷
                    Text(i.relativeString)
                    
                    
                    
                }
                

                Button(action: {
                
                    //Now going to record audio.　音声の録音
                
                
                    // Intialization....初期化
                
                    // Were going to store audio in document direcr　保存するコード
                
                    do {
                    
                        if self.record {
                            //Alert Started Recording means stooping and saving...　停止と保存
        
                            
                        self.recorder.stop()
                        self.record.toggle()
                        //updating data for every rcd....レコードの更新
                        self.getAudios()
                        return 
                    }
                    let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                    
                        //same file name...　同じ名前
                        //so were updating based on audio count...更新する
                    let fileName = url.appendingPathComponent("record\(self.audios.count + 1)")
                    
                    
                    let  settings = [
                    
                        AVFormatIDKey : Int(kAudioFormatMPEG4AAC),
                        AVSampleRateKey : 12000,
                        AVNumberOfChannelsKey : 1,
                        AVEncoderAudioQualityKey : AVAudioQuality.high.rawValue
                        
                    ]
                    
                    self.recorder = try AVAudioRecorder(url: fileName, settings: settings)
                    self.recorder.record()
                    self.record.toggle()

                }
                catch {
                    print(error.localizedDescription)
                    
                }//onDelete(preform: delete)

             
                
    
                    
                    
                    
                    
                
            }) {
                //ボタンの設定
                    ZStack{
                    
                        Circle()
                            .fill(Color.red)
                            .frame(width: 70, height: 70)
                    
                        if self.record{
                        
                            Circle()
                                .stroke(Color.white, lineWidth: 6)
                                .frame(width: 85, height: 85)
                        }
                    }
                }
                .padding(.vertical, 25)
            }//タイトル
            .navigationBarTitle("録音")
        }
        .alert(isPresented: self.$alert, content: {
        
            Alert(title: Text("Error"), message: Text("Enable Acess"))
        })
        .onAppear {
        
        do {
            //Instalizing
            self.session = AVAudioSession.sharedInstance()
            try self.session.setCategory(.playAndRecord)
            //requesting permission　録音の許可
            // for this we request microphone usage descripiton in info.plist
            self.session.requestRecordPermission{ (status) in
                
            if !status{
            //error msg....
            self.alert.toggle()
                    
        } else {
                // if permission granted means fetching all data...
                self.getAudios()
                }
            }
        }
        catch {
            print(error.localizedDescription)
        }
    }
}
    //保存のリストの中身
    func getAudios() {
        do{
      //      let player: AVAudioPlayer = try! AVAudioPlayer(contentsOf: URL)
            let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            //fech all data from document directrory
            let result = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: .producesRelativePathURLs)

            //update all data from document directry....データの更新
            
            
            self.audios.removeAll()
            
            
            for i in result{
                
                self.audios.append(i)
                
            }
        }
        catch{
            
            print(error.localizedDescription)
        }
    }
}
}
