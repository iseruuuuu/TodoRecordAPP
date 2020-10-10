//
//  Llist.swift
//  voiceAPP
//
//  Created by user on 2020/09/06.
//  Copyright © 2020 user. All rights reserved.
//

import SwiftUI
import CoreData


struct Llist: View {
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Entity.time, ascending: true)],
        animation: .default)
    
    var Llist: FetchedResults<Entity>
    
    @Environment(\.managedObjectContext) var viewContext
    
    
    @ObservedObject var keyboard = KeyboardObserver()
    
    
    
    
    fileprivate func deleteTodo(at offsets: IndexSet) {
        for index in offsets {
            let entity = Llist[index]
            viewContext.delete(entity)
        }
        do {
            try viewContext.save()
        } catch {
            print("Delete Error.\(offsets)")
        }
        
    }
    
    
    
    let category: Entity.Category
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(Llist) { todo in
                        if todo.category == self.category.rawValue {
                            NavigationLink(destination: EditTask(todo: todo)) {
                                DetailRoww(todo: todo, hideIcon: true)
                            }
                        }
                    }.onDelete(perform: deleteTodo)
                }
                QuickNewTask(Category: category)
                    .padding()
            }.navigationBarTitle(category.toString())
            .navigationBarItems(trailing: EditButton())
        }.onAppear{
            // self.keyboard.startObserve()
            // UIApplication.shared.closeKeyboard()
            
            
        }.onDisappear{
            //self.keyboard.stopObserve()
            //  UIApplication.shared.closeKeyboard()
        }.padding(.bottom, keyboard.keyboardHeight)
    }
}







struct Llist_Previews: PreviewProvider {
    static let container = (UIApplication.shared.delegate as! AppDelegate)
        .persistentContainer
    static let context = container.viewContext
    
    static var previews: some View {
        // テストデータの全削除
        let request = NSBatchDeleteRequest(
            fetchRequest: NSFetchRequest(entityName: "Entity"))
        try! container.persistentStoreCoordinator.execute(request,
                                                          with: context)
        
        // データを追加
        Entity.create(in: context,
                      category: .ImpUrg_1st, task: "炎上プロジェクト")
        Entity.create(in: context,
                      category: .ImpNUrg_2nd, task: "自己啓発")
        Entity.create(in: context,
                      category: .NImpUrg_3rd, task: "意味のない会議")
        Entity.create(in: context,
                      category: .NImpNUrg_4th, task: "暇つぶし")
        
        return Llist(category: .ImpUrg_1st)
            .environment(\.managedObjectContext, context)
    }
}


