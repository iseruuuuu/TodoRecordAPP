
import SwiftUI
import AVKit
import AVFoundation

var audios:AVAudioPlayer!
struct recordRecord: View {
    var body: some View {
        Homee()
        //背景設定(ずっと黒)
        //  .preferredColorScheme(.dark)
    }
}
struct recordRecord_Previews: PreviewProvider {
    static var previews: some View {
        recordRecord()
    }
}
struct  Homee : View {
@State var record = false
// createing instance for recording.　レコードのインスタンスを作成
@State var session : AVAudioSession!
@State var recorder : AVAudioRecorder!
internal var audioRecorder: AVAudioPlayer!
@State var alert = false
// Fetch Audios...　オーディオを取得する。
@State var audios : [URL] = []
    
    /// Viewの編集モードを取得
    @Environment(\.editMode) var envEditMode
    
    
    var body: some View {
        NavigationView{
            VStack {
                List {
                    ForEach(self.audios,id: \.self){i in
                        VStack {
            // printing only file name....　ファイルの印刷
                            Text(i.relativeString)
                                .font(.headline)
                            Divider()
                            
                            
                            
           //共有機能
                            

            HStack(spacing: 40) {
                Button(action: {
                    print("タップさた")
                }) {
                    Image(systemName: "ellipsis")   // システムアイコンを指定
                        Text("")
            
                }
                    .foregroundColor(.blue)
                    .font(.headline)
                            
            //15秒戻る機能
            Button(action: {
                print("タップされま")
                }) {
                Image(systemName: "gobackward.15")   // システムアイコンを指定
                    Text("")
            }
            .font(.title)
           
                    
            //再生機能
            Button(action: {
               // self.audioRecorder.play()
                print("されました")
                }) {
                Image(systemName: "play.fill")   // システムアイコンを指定
                    Text("")
            }
            .font(.title)
           

            //15秒進める。
            Button(action: {
                print("タッした")
                }) {
                Image(systemName: "goforward.15")   // システムアイコンを指定
                Text("")
            }
            .font(.title)
           
                 
                    
            //捨てる動作
            Button(action:  {
                print("ました")
                }) {
                Image(systemName: "trash")   // システムアイコンを指定
                Text("")
            }
            .foregroundColor(.blue)
            .font(.headline)
            }
                       
           
          
            }
                 
                       
        
                    }
                .onDelete(perform: rowRemove)
                }
                
                
                /// 編集モード時のみ削除処理を有効にする
                
                
          //録音のボタン
                
            Button(action: {
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
            //再生するためのもの
                    self.recorder.record()
                    self.record.toggle()

                }
                catch {
                    print(error.localizedDescription)
                }
                
            }) {
                //ボタンの設定
                    ZStack{
                    
                        Circle()
                            .fill(Color.red)
                            .frame(width: 55, height: 55 )
                    
                        if self.record{
                        
                            Circle()
                                .stroke(Color.black, lineWidth: 10)
                                .frame(width: 50, height: 50)
                        }
                    }
                }
                .padding(.vertical, 25)
            }//タイトル
            .navigationBarTitle("録音")
            //.navigationBarItems(trailing: EditButton())
            .foregroundColor(.blue)
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

    
    func onDelete(at index:Int) {
        audios.remove(at:index)
    }
    
    func rowRemove(offsets: IndexSet) {
           audios.remove(atOffsets: offsets)
       }
    

    
    
    
    
}



 

