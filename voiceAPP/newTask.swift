//
//  newTask.swift
//  voiceAPP
//
//  Created by user on 2020/09/06.
//  Copyright © 2020 user. All rights reserved.
//

import SwiftUI
import Speech
import AVFoundation


class ViewController: UIViewController, AVAudioRecorderDelegate, UITableViewDelegate, UITableViewDataSource {
   
       var recordingSession:AVAudioSession!
       var audioRecorder:AVAudioRecorder!
       var audioPlayer:AVAudioPlayer!
       var numberOfRecords:Int = 0
       @IBOutlet weak var buttonLabel: UIButton!
       @IBOutlet weak var myTableView: UITableView!

            
        
            
            
            
                override func viewDidLoad() {
                super.viewDidLoad()
                //setting up session 音声の許可の設定
                recordingSession = AVAudioSession.sharedInstance()
                if let number:Int = UserDefaults.standard.object(forKey: "myNumber") as? Int    {
               numberOfRecords = number   }
                AVAudioSession.sharedInstance().requestRecordPermission { (hasPermission) in
                if hasPermission{  print ("ACCEPTED")  }}}
                //Function that gets path to directory
                func getDirectory() -> URL {
                let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
                let documentDirectory = paths[0]
                return documentDirectory    }

        
        
        
        //Function that displays an alert
        func displayAlert(title:String, message:String)
        { let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
             alert.addAction(UIAlertAction(title: "dismiss", style: .default, handler: nil))
             present(alert, animated: true, completion: nil)     }
        
        
        //SETTING UO Table view  テーブルの設定
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return numberOfRecords
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = String(indexPath.row + 1)
            return cell
        }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
        {
            let path = getDirectory().appendingPathComponent("\(indexPath.row + 1).m4a")
            
            do
            {
             audioPlayer = try AVAudioPlayer(contentsOf: path)
                audioPlayer.play()
            }
            catch
            {
                
            }
        }
        
        
    }


    

struct newTask: View {
    
    
    @State var task: String = ""
    @State var task2: String = ""
   // @State var record: Date? = Date()
    @State var time: Date? = Date()
    @State var category: Int16 = Entity.Category.ImpUrg_1st.rawValue
    var categories: [Entity.Category]
        = [.ImpUrg_1st, .ImpNUrg_2nd, .NImpUrg_3rd, .NImpNUrg_4th, .NImpNUrg_5th, .NImpNUrg_6th]
    
    @Environment(\.managedObjectContext) var viewContext
    
    fileprivate func save() {
        do {
            try self.viewContext.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    
    //タイトル（科目名の入力）
    //enviromentは、
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("内容")) {
                TextField("内容の入力", text: $task)
                    
                }
                
                
                
                
                
                /*    Section(header: Toggle(isOn: Binding(isNotNil: $time, defaultValue: Date())){Text("時間設定")}) {
                    if time != nil {
               DatePicker(selection: Binding($time, Date()), label: { Text("日時")})
                } else {
                   Text("時間未設定").foregroundColor(.secondary)}} */
                
                
                //種類の選択
                Picker(selection: $category, label: Text("種類")) {
                    ForEach(categories, id: \.self) { category in
                    HStack {
                        CategoryImage(category)
                        Text(category.toString())
                    }.tag(category.rawValue)
                    .foregroundColor(.black)
                    }
                    
                }
                
                
                
                

                
                
                //メモ（テストの内容とか一言）
                    Section(header: Text("メモ")) {
                    TextField("メモ", text: $task2)}
                
                
                
                
               
               Section(header: Text("")) {
                VStack {
                    NavigationLink(destination: recordRecord()) {
                        Text("録音")  //, text: $record
                    }
                    .foregroundColor(.black)
                }
              //  }
             
                 
                
                
    


                

                
                
            }.navigationBarTitle("内容の追加")
                .navigationBarItems(trailing: Button(action: {
                    Entity.create(in: self.viewContext, category: Entity.Category(rawValue: self.category) ?? .ImpUrg_1st,
                                  task: self.task, time: self.time) //task2: self.task
                    
                    
                    
                    self.save()
                    //dismissで画面を閉じる
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("保存")
                    
             
                    
                    
            }
            
            )
        }
    }
}

struct newTask_Previews: PreviewProvider {
    static let context = (UIApplication.shared.delegate as! AppDelegate)
        .persistentContainer.viewContext
    static var previews: some View {
        newTask()
            .environment(\.managedObjectContext, context)
    }
}

}
