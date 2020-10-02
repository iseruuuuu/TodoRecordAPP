//
//  QuickNewTask.swift
//  voiceAPP
//
//  Created by user on 2020/09/05.
//  Copyright © 2020 user. All rights reserved.
//

import SwiftUI

struct QuickNewTask: View {
    let Category: Entity.Category
    
    @State var newTask:String = ""
    @Environment(\.managedObjectContext) var viewContext
    
    fileprivate func addNewtasks() {
        Entity.create(in: self.viewContext, category: self.Category, task: self.newTask)
        self.newTask = ""
    }
    
    fileprivate func cancelTask() {
        self.newTask = ""
        
    }
    
    var body: some View {
            HStack {
                TextField("新しい記録", text: $newTask, onCommit:  {
                    self.addNewtasks()
                })
//textFieldStyle(RoundedBorderTextFieldStyle())は、文字の枠
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: { self.addNewtasks()
                }) {
                    Text("追加")
                        .foregroundColor(.blue)
                }
                Button(action: { self.cancelTask()
            }) {
                Text("Cancel").foregroundColor(.red)
            }
        }
    }
}

struct QuickNewTask_Previews: PreviewProvider {
    static let context = (UIApplication.shared.delegate as! AppDelegate)
        .persistentContainer.viewContext
    static var previews: some View {
        QuickNewTask(Category: .ImpUrg_1st)
            .environment(\.managedObjectContext, context)
    }
}
