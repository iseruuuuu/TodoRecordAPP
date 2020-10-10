//
//  Entity+Extension.swift
//  voiceAPP
//
//  Created by user on 2020/09/05.
//  Copyright © 2020 user. All rights reserved.
//

import Foundation

import CoreData
import SwiftUI

//extension Entity: Identifiable {}
extension Entity {
    
    static func create(in managedObjectContext: NSManagedObjectContext,
                       category: Category,
                       task: String,
                       //task2: String,
                       time: Date? = Date()){
        let todo = self.init(context: managedObjectContext)
        print(task)
        //時間
        todo.time = time
        //カテゴリー
        todo.category = category.rawValue
        //タスクは、文の内容
        todo.task = task
        todo.task2 = task
        //todo.record = task
        
        
        //タスクが進行しているのかどうかを判断する
        todo.state = State.todo.rawValue
        
        
        todo.id = UUID().uuidString
        
        do {
            try  managedObjectContext.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    
    
    enum Category: Int16 {
        case ImpUrg_1st     // Important & Urgent (第Ⅰ領域）
        case ImpNUrg_2nd    // Important & Not Urgent (第Ⅱ領域）
        case NImpUrg_3rd    // Not Important & Urgent（第Ⅲ領域）
        case NImpNUrg_4th   // Not Important & Not Urgent（第Ⅳ領域）
        case NImpNUrg_5th // Not Important & Not Urgent（第Ⅳ領域）
        case NImpNUrg_6th
        
        func toString() -> String {
            switch self {
            case .ImpUrg_1st:
                return "月曜日"
            case .ImpNUrg_2nd:
                return "火曜日"
            case .NImpUrg_3rd:
                return "水曜日"
            case .NImpNUrg_4th:
                return "木曜日"
            case .NImpNUrg_5th:
                return "金曜日"
            case .NImpNUrg_6th:
                return "土曜日"
            }
        }
        
        func image() -> String {
            switch self {
            case .ImpUrg_1st:
                return "moon"
            case .ImpNUrg_2nd:
                return "flame"
            case .NImpUrg_3rd:
                return "umbrella"
            case .NImpNUrg_4th:
                return "cloud"
            case .NImpNUrg_5th:
                return "bell"
            case .NImpNUrg_6th:
                return "globe"
                
            }
        }
        
        func color() -> Color {
            switch self {
            case .ImpUrg_1st:
                return .tYellow
            case .ImpNUrg_2nd:
                return .tRed
            case .NImpUrg_3rd:
                return .tBlue
            case .NImpNUrg_4th:
                return .tGreen
            case .NImpNUrg_5th:
                return .tgold
            case .NImpNUrg_6th:
                return .tpurple
            }
        }
    }
    
    enum State: Int16 {
        case todo
        case done
        
    }
    
    static func count(in managedObjectContext: NSManagedObjectContext,
                      category: Category) -> Int {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Entity")
        fetchRequest.predicate = NSPredicate(format: "category == \(category.rawValue)")
        
        
        do {
            let count = try managedObjectContext.count(for: fetchRequest)
            return count
        } catch  {
            print("Error: \(error.localizedDescription)")
            return 0
        }
    }
}


